#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA xarray/tests/test_dataarray.py xarray/tests/test_dataset.py xarray/tests/test_groupby.py
else
  pytest -rA "$@"
fi
