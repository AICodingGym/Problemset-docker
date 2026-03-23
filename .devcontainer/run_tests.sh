#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  tox --current-env -epy39 -v -- tests/test_domain_cpp.py
else
  tox --current-env -epy39 -v -- "$@"
fi
