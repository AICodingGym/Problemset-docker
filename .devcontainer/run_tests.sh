#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA sklearn/metrics/cluster/tests/test_supervised.py
else
  pytest -rA "$@"
fi
