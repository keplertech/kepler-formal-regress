#!/usr/bin/env python3
import re
import sys
from pathlib import Path

from najaeda import netlist


DESIGN_DIR = Path(__file__).resolve().parent
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


def _remove_first(text, needle):
    pos = text.find(needle)
    if pos == -1:
        raise RuntimeError("could not find text to remove")
    return text[:pos] + text[pos + len(needle):]


def _load_with_naja(gate_rel, liberty_files):
    netlist.reset()
    for liberty in liberty_files:
        netlist.load_liberty(str(DESIGN_DIR / liberty))
    return netlist.load_verilog(str(DESIGN_DIR / gate_rel))


def _infer_inverter(liberty_files):
    lib_text = " ".join(str(path) for path in liberty_files).lower()
    if "asap7" in lib_text:
        variant = "L" if "_lvt_" in lib_text else "R"
        return f"INVx1_ASAP7_75t_{variant}", "A", "Y"
    if "sky130_fd_sc_hd" in lib_text:
        return "sky130_fd_sc_hd__inv_1", "A", "Y"
    if "sky130_fd_sc_hs" in lib_text:
        return "sky130_fd_sc_hs__inv_1", "A", "Y"
    if "nangate" in lib_text:
        return "INV_X1", "A", "ZN"
    if "sg13g2" in lib_text:
        return "sg13g2_inv_1", "A", "Y"
    raise RuntimeError("could not infer an inverter cell from liberty_files")


def _validate_driver_with_naja(gate_rel, liberty_files, output_expr, pin_name):
    top = _load_with_naja(gate_rel, liberty_files)
    for term in top.get_output_bit_terms():
        if str(term.get_lower_net()) != output_expr:
            continue
        for driver in term.get_equipotential().get_leaf_drivers():
            if driver.get_name() == pin_name:
                return
    raise RuntimeError(f"Naja could not confirm {pin_name} drives {output_expr}")


def _validate_term_with_naja(gate_rel, liberty_files, output_expr):
    top = _load_with_naja(gate_rel, liberty_files)
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
    gate_rel, liberty_files, instance_name, pin_name, expected_net
):
    top = _load_with_naja(gate_rel, liberty_files)
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
    gate_rel,
    instance_name,
    pin_name,
    old_net,
    new_net,
    liberty_files,
    validate_with_naja=True,
):
    gate_path = DESIGN_DIR / gate_rel
    text = gate_path.read_text()

    if validate_with_naja:
        try:
            _validate_instance_pin_net_with_naja(
                gate_rel, liberty_files, instance_name, pin_name, old_net
            )
        except RuntimeError:
            _validate_instance_pin_net_with_naja(
                gate_rel, liberty_files, instance_name, pin_name, new_net
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
        r"(\." + re.escape(pin_name) + r"\s*\(\s*)" + re.escape(old_net) + r"(\s*\))"
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
    mutated = text[:inst_match.start("body")] + new_body + text[inst_match.end("body"):]
    gate_path.write_text(mutated)

    if validate_with_naja:
        _validate_instance_pin_net_with_naja(
            gate_rel, liberty_files, instance_name, pin_name, new_net
        )

    print(f"mutated {gate_rel}: {instance_name}/{pin_name} {old_net} -> {new_net}")


def detach_driver_and_invert(
    gate_rel, output_expr, pin_name, liberty_files, validate_with_naja=True
):
    gate_path = DESIGN_DIR / gate_rel
    text = gate_path.read_text()
    inverter_cell, inverter_input_pin, inverter_output_pin = _infer_inverter(liberty_files)
    aux_wire = "__kepler_sec_fail_orig_" + _sanitize(output_expr)
    inv_instance = "__kepler_sec_fail_inv_" + _sanitize(output_expr)
    edit = (
        f"// {MARKER}: invert {output_expr} while preserving its original driver.\n"
        f"wire {aux_wire};\n"
        f"{inverter_cell} {inv_instance} (.{inverter_input_pin}({aux_wire}),\n"
        f"    .{inverter_output_pin}({output_expr}));\n"
    )
    if edit in text:
        print(f"skip {gate_rel}: marker for {output_expr} already present")
        return

    if validate_with_naja:
        _validate_driver_with_naja(gate_rel, liberty_files, output_expr, pin_name)

    pattern = re.compile(
        r"(\." + re.escape(pin_name) + r"\s*\(\s*)" + re.escape(output_expr) + r"(\s*\))"
    )
    match = pattern.search(text)
    if not match:
        raise RuntimeError(f"could not find .{pin_name}({output_expr}) in {gate_rel}")

    mutated = pattern.sub(r"\1" + aux_wire + r"\2", text, count=1)
    insert_pos = _declaration_insert_pos(mutated, match.start())
    gate_path.write_text(mutated[:insert_pos] + edit + mutated[insert_pos:])
    print(f"mutated {gate_rel}: {pin_name} -> {aux_wire}, {output_expr} inverted")


def revert_detach_driver_and_invert(gate_rel, output_expr, pin_name, liberty_files):
    gate_path = DESIGN_DIR / gate_rel
    text = gate_path.read_text()
    inverter_cell, inverter_input_pin, inverter_output_pin = _infer_inverter(liberty_files)
    aux_wire = "__kepler_sec_fail_orig_" + _sanitize(output_expr)
    inv_instance = "__kepler_sec_fail_inv_" + _sanitize(output_expr)
    edit = (
        f"// {MARKER}: invert {output_expr} while preserving its original driver.\n"
        f"wire {aux_wire};\n"
        f"{inverter_cell} {inv_instance} (.{inverter_input_pin}({aux_wire}),\n"
        f"    .{inverter_output_pin}({output_expr}));\n"
    )
    if edit not in text:
        print(f"skip {gate_rel}: marker for {output_expr} not present")
        return
    pattern = re.compile(
        r"(\." + re.escape(pin_name) + r"\s*\(\s*)" + re.escape(aux_wire) + r"(\s*\))"
    )
    if not pattern.search(text):
        raise RuntimeError(f"could not find .{pin_name}({aux_wire}) in {gate_rel}")
    restored = pattern.sub(r"\1" + output_expr + r"\2", text, count=1)
    gate_path.write_text(_remove_first(restored, edit))
    print(f"reverted {gate_rel}: {output_expr} restored on {pin_name}")


def force_output_value(gate_rel, output_expr, value, liberty_files, validate_with_naja=True):
    gate_path = DESIGN_DIR / gate_rel
    text = gate_path.read_text()
    edit = (
        f"// {MARKER}: force {output_expr} to perturb this pad wrapper.\n"
        f"assign {output_expr} = {value};\n"
    )
    if edit in text:
        print(f"skip {gate_rel}: force marker for {output_expr} already present")
        return
    if validate_with_naja:
        _validate_term_with_naja(gate_rel, liberty_files, output_expr)
    insert_pos = _declaration_insert_pos(text, len(text))
    gate_path.write_text(text[:insert_pos] + edit + text[insert_pos:])
    print(f"mutated {gate_rel}: {output_expr} forced to {value}")


def revert_force_output_value(gate_rel, output_expr, value):
    gate_path = DESIGN_DIR / gate_rel
    text = gate_path.read_text()
    edit = (
        f"// {MARKER}: force {output_expr} to perturb this pad wrapper.\n"
        f"assign {output_expr} = {value};\n"
    )
    if edit not in text:
        print(f"skip {gate_rel}: force marker for {output_expr} not present")
        return
    gate_path.write_text(_remove_first(text, edit))
    print(f"reverted {gate_rel}: removed force on {output_expr}")

ACTIONS = [('detach',
  './1_synth_lec.v',
  'rdata[31]',
  'Y',
  ['./asap7sc7p5t_AO_RVT_FF_nldm_211120.lib.gz',
   './asap7sc7p5t_INVBUF_RVT_FF_nldm_220122.lib.gz',
   './asap7sc7p5t_OA_RVT_FF_nldm_211120.lib.gz',
   './asap7sc7p5t_SIMPLE_RVT_FF_nldm_211120.lib.gz',
   './asap7sc7p5t_SEQ_RVT_FF_nldm_220123.lib'],
  True)]


def _apply(action, revert):
    kind = action[0]
    if kind == "replace":
        _, gate_rel, instance_name, pin_name, old_net, new_net, liberty_files, validate = action
        if revert:
            old_net, new_net = new_net, old_net
        replace_instance_pin_net(
            gate_rel, instance_name, pin_name, old_net, new_net, liberty_files, validate
        )
    elif kind == "detach":
        _, gate_rel, output_expr, pin_name, liberty_files, validate = action
        if revert:
            revert_detach_driver_and_invert(gate_rel, output_expr, pin_name, liberty_files)
        else:
            detach_driver_and_invert(gate_rel, output_expr, pin_name, liberty_files, validate)
    elif kind == "force":
        _, gate_rel, output_expr, value, liberty_files, validate = action
        if revert:
            revert_force_output_value(gate_rel, output_expr, value)
        else:
            force_output_value(gate_rel, output_expr, value, liberty_files, validate)
    else:
        raise RuntimeError(f"unknown action kind: {kind}")


def main():
    revert = len(sys.argv) == 2 and sys.argv[1] == "--revert"
    if len(sys.argv) not in (1, 2) or (len(sys.argv) == 2 and sys.argv[1] != "--revert"):
        raise SystemExit(f"usage: {Path(sys.argv[0]).name} [--revert]")
    ordered_actions = reversed(ACTIONS) if revert else ACTIONS
    for action in ordered_actions:
        _apply(action, revert)


if __name__ == "__main__":
    main()
