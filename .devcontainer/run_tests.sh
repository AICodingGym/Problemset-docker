#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA astropy/io/fits/tests/test_header.py
else
  pytest -rA "$@"
fi
