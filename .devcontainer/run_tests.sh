#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA tests/lint/unittest_lint.py tests/regrtest_data/directory/ignored_subdirectory/failing.py tests/test_self.py
else
  pytest -rA "$@"
fi
