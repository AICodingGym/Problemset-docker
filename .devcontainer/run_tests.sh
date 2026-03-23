#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest --no-header -rA tests/_core/test_plot.py tests/test_relational.py
else
  pytest --no-header -rA "$@"
fi
