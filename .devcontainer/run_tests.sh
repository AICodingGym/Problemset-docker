#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA sklearn/linear_model/tests/test_logistic.py
else
  pytest -rA "$@"
fi
