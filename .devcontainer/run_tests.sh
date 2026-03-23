#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  tox --current-env -epy39 -v -- tests/roots/test-directive-include/baz/baz.rst tests/roots/test-directive-include/conf.py tests/roots/test-directive-include/foo.rst tests/roots/test-directive-include/text.txt tests/test_directive_other.py
else
  tox --current-env -epy39 -v -- "$@"
fi
