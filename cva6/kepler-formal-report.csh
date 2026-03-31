#!/bin/csh -f

set script_dir = `cd "$0:h" && pwd`
cd "$script_dir"

setenv CVA6_REPO_DIR "$script_dir"

if ( ! $?HPDCACHE_DIR ) then
  setenv HPDCACHE_DIR "$script_dir/core/cache_subsystem/hpdcache"
endif

if ( ! $?TARGET_CFG ) then
  setenv TARGET_CFG "cv64a6_imafdc_sv39"
endif

if ( $?KEPLER_FORMAL_BIN ) then
  set kepler_formal_bin = "$KEPLER_FORMAL_BIN"
else
  set kepler_formal_bin = kepler-formal
endif

"$kepler_formal_bin" --config config.yaml --report-skipped-pos
