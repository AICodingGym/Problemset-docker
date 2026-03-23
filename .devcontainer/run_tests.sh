#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  tox --current-env -epy39 -v -- tests/roots/test-ext-autodoc/target/docstring_signature.py tests/test_ext_autodoc_configs.py
else
  tox --current-env -epy39 -v -- "$@"
fi
