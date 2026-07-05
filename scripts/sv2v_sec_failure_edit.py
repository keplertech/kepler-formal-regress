#!/usr/bin/env python3
import re
from pathlib import Path

from najaeda import netlist


MARKER = "Kepler SEC negative fixture"


def _sanitize(name):
    cleaned = re.sub(r"[^A-Za-z0-9_]+", "_", name).strip("_")
    if not cleaned or cleaned[0].isdigit():
        cleaned = "n_" + cleaned
    return cleaned[:96]


def _declaration_insert_pos(text, before_pos):
    pos = 0
    insert_pos = 0
    decl_re = re.compile(r"\s*(input|output|inout|wire|tri|supply0|supply1)\b")
    for line in text.splitlines(keepends=True):
        next_pos = pos + len(line)
        if next_pos > before_pos:
            break
        if decl_re.match(line):
            insert_pos = next_pos
        pos = next_pos
    return insert_pos


def _load_with_naja(design_dir, gate_rel, liberty_files):
    netlist.reset()
    for liberty in liberty_files:
        netlist.load_liberty(str(Path(design_dir, liberty)))
    return netlist.load_verilog(str(Path(design_dir, gate_rel)))


def _validate_driver_with_naja(design_dir, gate_rel, liberty_files, output_expr, pin_name):
    top = _load_with_naja(design_dir, gate_rel, liberty_files)
    for term in top.get_output_bit_terms():
        if str(term.get_lower_net()) != output_expr:
            continue
        for driver in term.get_equipotential().get_leaf_drivers():
            if driver.get_name() == pin_name:
                return
    raise RuntimeError(f"Naja could not confirm {pin_name} drives {output_expr}")


def _validate_term_with_naja(design_dir, gate_rel, liberty_files, output_expr):
    top = _load_with_naja(design_dir, gate_rel, liberty_files)
    for term in top.get_output_bit_terms():
        if str(term.get_lower_net()) == output_expr:
            return
    raise RuntimeError(f"Naja could not confirm output term {output_expr}")


def _term_net_name(term):
    net = term.get_upper_net()
    if net is None:
        net = term.get_lower_net()
    return None if net is None else str(net)


def _validate_instance_pin_net_with_naja(
    design_dir, gate_rel, liberty_files, instance_name, pin_name, expected_net
):
    top = _load_with_naja(design_dir, gate_rel, liberty_files)
    inst = top.get_child_instance(instance_name)
    if inst is None:
        raise RuntimeError(f"Naja could not find instance {instance_name} in {gate_rel}")

    term = inst.get_term(pin_name)
    if term is None:
        raise RuntimeError(f"Naja could not find pin {instance_name}/{pin_name}")

    actual_net = _term_net_name(term)
    if actual_net != expected_net:
        raise RuntimeError(
            f"Naja saw {instance_name}/{pin_name} on {actual_net}, expected {expected_net}"
        )


def replace_instance_pin_net(
    design_dir,
    gate_rel,
    instance_name,
    pin_name,
    old_net,
    new_net,
    liberty_files=(),
    validate_with_naja=True,
):
    design_dir = Path(design_dir)
    gate_path = design_dir / gate_rel
    text = gate_path.read_text()

    if validate_with_naja:
        try:
            _validate_instance_pin_net_with_naja(
                design_dir, gate_rel, liberty_files, instance_name, pin_name, old_net
            )
        except RuntimeError:
            _validate_instance_pin_net_with_naja(
                design_dir, gate_rel, liberty_files, instance_name, pin_name, new_net
            )
            print(f"skip {gate_rel}: {instance_name}/{pin_name} already uses {new_net}")
            return

    inst_re = re.compile(
        r"(?P<head>\b\S+\s+" + re.escape(instance_name) + r"\s*\()"
        r"(?P<body>.*?)"
        r"(?P<tail>\)\s*;)",
        re.S,
    )
    inst_match = inst_re.search(text)
    if not inst_match:
        raise RuntimeError(f"could not find instance {instance_name} in {gate_rel}")

    body = inst_match.group("body")
    pin_re = re.compile(
        r"(\." + re.escape(pin_name) + r"\s*\(\s*)"
        + re.escape(old_net)
        + r"(\s*\))"
    )
    if not pin_re.search(body):
        already_re = re.compile(
            r"(\." + re.escape(pin_name) + r"\s*\(\s*)"
            + re.escape(new_net)
            + r"(\s*\))"
        )
        if already_re.search(body):
            print(f"skip {gate_rel}: {instance_name}/{pin_name} already uses {new_net}")
            return
        raise RuntimeError(
            f"could not find .{pin_name}({old_net}) on {instance_name} in {gate_rel}"
        )

    new_body = pin_re.sub(r"\1" + new_net + r"\2", body, count=1)
    mutated = (
        text[: inst_match.start("body")]
        + new_body
        + text[inst_match.end("body") :]
    )
    gate_path.write_text(mutated)

    if validate_with_naja:
        _validate_instance_pin_net_with_naja(
            design_dir, gate_rel, liberty_files, instance_name, pin_name, new_net
        )

    print(f"mutated {gate_rel}: {instance_name}/{pin_name} {old_net} -> {new_net}")


def detach_driver_and_invert(
    design_dir,
    gate_rel,
    output_expr,
    pin_name,
    inverter_cell,
    inverter_input_pin="A",
    inverter_output_pin="Y",
    liberty_files=(),
    validate_with_naja=True,
):
    design_dir = Path(design_dir)
    gate_path = design_dir / gate_rel
    text = gate_path.read_text()
    if MARKER in text:
        print(f"skip {gate_rel}: marker already present")
        return

    if validate_with_naja:
        _validate_driver_with_naja(design_dir, gate_rel, liberty_files, output_expr, pin_name)

    aux_wire = "__kepler_sec_fail_orig_" + _sanitize(output_expr)
    inv_instance = "__kepler_sec_fail_inv_" + _sanitize(output_expr)
    pattern = re.compile(
        r"(\." + re.escape(pin_name) + r"\s*\(\s*)"
        + re.escape(output_expr)
        + r"(\s*\))"
    )
    match = pattern.search(text)
    if not match:
        raise RuntimeError(f"could not find .{pin_name}({output_expr}) in {gate_rel}")

    mutated = pattern.sub(r"\1" + aux_wire + r"\2", text, count=1)
    insert_pos = _declaration_insert_pos(mutated, match.start())
    edit = (
        f"// {MARKER}: invert {output_expr} while preserving its original driver.\n"
        f"wire {aux_wire};\n"
        f"{inverter_cell} {inv_instance} (.{inverter_input_pin}({aux_wire}),\n"
        f"    .{inverter_output_pin}({output_expr}));\n"
    )
    gate_path.write_text(mutated[:insert_pos] + edit + mutated[insert_pos:])
    print(f"mutated {gate_rel}: {pin_name} -> {aux_wire}, {output_expr} inverted")


def force_output_value(
    design_dir,
    gate_rel,
    output_expr,
    value,
    liberty_files=(),
    validate_with_naja=True,
):
    design_dir = Path(design_dir)
    gate_path = design_dir / gate_rel
    text = gate_path.read_text()
    if MARKER in text:
        print(f"skip {gate_rel}: marker already present")
        return

    if validate_with_naja:
        _validate_term_with_naja(design_dir, gate_rel, liberty_files, output_expr)

    insert_pos = _declaration_insert_pos(text, len(text))
    edit = (
        f"// {MARKER}: force {output_expr} to perturb this pad wrapper.\n"
        f"assign {output_expr} = {value};\n"
    )
    gate_path.write_text(text[:insert_pos] + edit + text[insert_pos:])
    print(f"mutated {gate_rel}: {output_expr} forced to {value}")
