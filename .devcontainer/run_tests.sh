#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA testing/code/test_code.py testing/code/test_excinfo.py testing/conftest.py testing/test_reports.py
else
  pytest -rA "$@"
fi
