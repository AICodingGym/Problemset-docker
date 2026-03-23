#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  ./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1 tests/backends/sqlite/test_features.py tests/fixtures_regress/fixtures/nk_with_foreign_key.json tests/fixtures_regress/models.py tests/fixtures_regress/tests.py
else
  ./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1 "$@"
fi
