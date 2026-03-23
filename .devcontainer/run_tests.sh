#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA sklearn/mixture/tests/test_bayesian_mixture.py sklearn/mixture/tests/test_gaussian_mixture.py
else
  pytest -rA "$@"
fi
