#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA sklearn/ensemble/tests/test_iforest.py
else
  pytest -rA "$@"
fi
