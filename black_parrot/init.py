# script for copying all library files to current directory

import os
import shutil
from os import path
import logging
logging.basicConfig(level=logging.INFO)
# snippet-start: copy_lib_files
benchmarks = path.join('.')
lib_files = [
    'NangateOpenCellLibrary_typical.lib',
    'fakeram45_1024x32.lib',
    'fakeram45_64x32.lib',
    'fakeram45_64x15.lib',
    'fakeram45_64x96.lib',
    'fakeram45_512x64.lib',
    'fakeram45_256x95.lib',
    'fakeram45_64x7.lib'
]

source_dir = '../library'  # Update this path to the actual source directory

for lib_file in lib_files:
    src = path.join(source_dir, lib_file)
    dst = path.join(benchmarks, lib_file)
    shutil.copyfile(src, dst)
    logging.info(f'Copied {lib_file} to {benchmarks}')
# snippet-end: copy_lib_files
# end of script