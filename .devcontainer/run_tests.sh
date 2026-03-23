#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  tox --current-env -epy39 -v -- tests/roots/test-ext-inheritance_diagram/conf.py tests/roots/test-ext-inheritance_diagram/index.rst tests/roots/test-ext-inheritance_diagram/subdir/index.rst tests/roots/test-ext-inheritance_diagram/subdir/other.py tests/roots/test-ext-inheritance_diagram/test.py tests/test_ext_inheritance_diagram.py
else
  tox --current-env -epy39 -v -- "$@"
fi
