#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA lib/matplotlib/tests/test_axes.py lib/mpl_toolkits/tests/test_mplot3d.py
else
  pytest -rA "$@"
fi
