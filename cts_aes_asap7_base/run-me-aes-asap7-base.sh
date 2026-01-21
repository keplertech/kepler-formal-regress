#!/usr/bin/env bash
source vars-aes-asap7-base.sh
if [[ ! -z ${GDB+x} ]]; then
    gdb --args openroad -no_init ${SCRIPTS_DIR}/cts.tcl
else
    openroad -no_init ${SCRIPTS_DIR}/cts.tcl
fi
