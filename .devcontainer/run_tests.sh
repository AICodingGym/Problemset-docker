#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA -vv -o console_output_style=classic --tb=no astropy/utils/tests/test_introspection.py
else
  pytest -rA -vv -o console_output_style=classic --tb=no "$@"
fi
