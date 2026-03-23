#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA -vv -o console_output_style=classic --tb=no astropy/units/tests/py3_test_quantity_annotations.py astropy/units/tests/test_quantity_decorator.py
else
  pytest -rA -vv -o console_output_style=classic --tb=no "$@"
fi
