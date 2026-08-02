# C2RTL Dilithium NTT

Original C2RTL self-check example based on the Adams Bridge Dilithium reference NTT source.

Run from this directory:

```sh
kepler-formal --config config.yaml
```

Additional checks:

```sh
kepler-formal --config c_vs_rtl_config.yaml
kepler-formal --config generated_rtl_config.yaml
```

`config.yaml` runs C-vs-C through C2RTL. `c_vs_rtl_config.yaml` synthesizes the C reference as design1 and checks it against the checked-in RTL artifact as design2. `generated_rtl_config.yaml` checks the checked-in generated RTL artifacts directly.
