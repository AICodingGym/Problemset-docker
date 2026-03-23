#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA astropy/table/tests/test_mixin.py astropy/table/tests/test_table.py
else
  pytest -rA "$@"
fi
