#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA sklearn/feature_selection/tests/test_base.py sklearn/feature_selection/tests/test_feature_select.py
else
  pytest -rA "$@"
fi
