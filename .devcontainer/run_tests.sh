#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  ./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1 tests/auth_tests/test_validators.py
else
  ./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1 "$@"
fi
