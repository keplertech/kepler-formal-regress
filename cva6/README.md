## CVA6

Standalone SystemVerilog flist example for `kepler-formal`.

This case vendors the needed CVA6 source tree inside the example folder.

Default assumptions:

- `kepler-formal` is available in `PATH`, or `KEPLER_FORMAL_BIN` points to the binary.
- `TARGET_CFG` defaults to `cv64a6_imafdc_sv39`.

Quick run:

```bash
./kepler-formal.csh
```

If you want a different target config:

```bash
TARGET_CFG=cv32a60x ./kepler-formal.csh
```

The wrapper script exports:

- `CVA6_REPO_DIR=<this folder>`
- `HPDCACHE_DIR=<this folder>/core/cache_subsystem/hpdcache`

and then runs `kepler-formal --config config.yaml` from this directory.
