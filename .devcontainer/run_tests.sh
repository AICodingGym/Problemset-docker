#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA lib/mpl_toolkits/axes_grid1/tests/test_axes_grid1.py
else
  pytest -rA "$@"
fi
