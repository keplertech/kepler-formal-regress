# C2RTL Temporal Accumulator

Small sequential C2RTL SEC example. The C source uses a static accumulator and XLS channels, so this exercises temporal state instead of only a combinational C function.

Run from this directory:

```sh
kepler-formal --config config.yaml
```

The `generated/` directory keeps the SystemVerilog emitted by the C2RTL flow so the RTL artifact is available for regression/debugging as well.
