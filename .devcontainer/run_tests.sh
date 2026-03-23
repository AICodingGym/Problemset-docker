#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA testing/test_nose.py testing/test_unittest.py
else
  pytest -rA "$@"
fi
