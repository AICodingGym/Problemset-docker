#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA sklearn/ensemble/_hist_gradient_boosting/tests/test_gradient_boosting.py
else
  pytest -rA "$@"
fi
