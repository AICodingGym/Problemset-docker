#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  tox --current-env -epy39 -v -- tests/roots/test-linkcheck/links.txt tests/test_build_linkcheck.py
else
  tox --current-env -epy39 -v -- "$@"
fi
