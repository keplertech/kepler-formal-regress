# sv2v SEC negative examples

These examples are gate-level edit scripts for ORFS-origin designs. Each script is
intended to be run from its design directory:

```sh
python3 edit_sv2v_sec_failure.py
python3 edit_sv2v_sec_failure.py --revert
```

All listed scripts are self-contained per-design edit scripts. They were
smoke-tested for clean apply/revert, and validate edited instance/pin
connectivity with `najaeda` where the script enables validation.

## Verified SEC failures

| Design | Script | SEC config | Result |
| --- | --- | --- | --- |
| `asap7_ethmac` | `asap7_ethmac/edit_sv2v_sec_failure.py` | `sv2v_sec_k_induction_dual_rail_steady_test.yml` | Counterexample at `k = 2`, first mismatch `wb_err_o[0]` |

## Smoke-tested edit scripts

These scripts apply and revert cleanly, but are not currently counted as
verified SEC failures with the available `buildR` sv2v flow. In most cases the
flow is blocked by frontend parsing, output coverage skips, or boundary
abstraction before the injected bug can become a useful regression oracle.

| Design | Gate edit target |
| --- | --- |
| `asap7_aes-mbff` | `done` output inversion |
| `asap7_jpeg_lvt` | `amp[11]` output inversion |
| `asap7_mock-alu` | `io_out[63]` output inversion |
| `asap7_mock_cpu` | `rdata[31]` output inversion |
| `cts_aes_asap7_base` | `done` output inversion |
| `ihp-sg13g2_i2c-gpio-expander` | `io_i2c_interrupt_PAD` force plus `io_cmd_payload_data[7]` inversion |
| `ihp_sg13g2_ibex` | `alert_major_o` output inversion |
| `mempool_group` | `axi_mst_req_o[284]` output inversion |
| `mock_cpu` | `rdata[31]` output inversion |
| `nangate45_ariane136` | `axi_req_o[277]` output inversion |
| `nangate45_black_parrot` | `mem_cmd_o[26]` output inversion |
| `nangate45_black_parrot_sec_final` | `mem_cmd_o[26]` output inversion |
| `nangate45_bp_be` | `cmt_trace_exc_o[6]` output inversion |
| `nangate45_dynamic_node` | `dataOut_E[63]` output inversion |
| `nangate45_ibex` | `alert_major_o` output inversion |
| `nangate45_swerv` | `core_rst_l` output inversion |
| `sky130hd_gcd` | `req_rdy` output inversion; current SEC proves no difference |
| `sky130hd_riscv32i` | `aluout[31]` output inversion |
| `sky130hs_ibex` | `alert_major_o` output inversion |
| `sky130hs_riscv32i` | `aluout[31]` output inversion |
