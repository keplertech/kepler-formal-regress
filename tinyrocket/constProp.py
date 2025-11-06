# SPDX-FileCopyrightText: 2024 The Naja authors
# <https://github.com/najaeda/naja/blob/main/AUTHORS>
#
# SPDX-License-Identifier: Apache-2.0

from os import path
import sys
import logging
from najaeda import netlist
from najaeda import naja

logging.basicConfig(level=logging.INFO)

# snippet-start: load_design_liberty
benchmarks = path.join('.')
liberty_files = [
    'NangateOpenCellLibrary_typical.lib',
    'fakeram45_1024x32.lib',
    'fakeram45_64x32.lib',
    'fakeram45_64x15.lib',
    'fakeram45_64x96.lib',
    'fakeram45_512x64.lib',
    'fakeram45_256x95.lib',
    'fakeram45_64x7.lib'
]
liberty_files = list(map(lambda p:path.join(benchmarks, p), liberty_files))
    
netlist.load_liberty(liberty_files)
top = netlist.load_verilog('black_parrot.v')

netlist.apply_constant_propagation()
netlist.dump_verilog('black_parrot_cp.v')
netlist.dump_naja_if('black_parrot_cp.if')