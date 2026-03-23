#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  ./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1 tests/invalid_models_tests/test_models.py tests/invalid_models_tests/test_relative_fields.py tests/migrations/test_state.py
else
  ./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1 "$@"
fi
