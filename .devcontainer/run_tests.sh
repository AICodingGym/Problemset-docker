#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  tox --current-env -epy39 -v -- tests/test_domain_py.py tests/test_pycode_ast.py
else
  tox --current-env -epy39 -v -- "$@"
fi
