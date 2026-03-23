#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  tox --current-env -epy39 -v -- tests/roots/test-toctree-index/conf.py tests/roots/test-toctree-index/foo.rst tests/roots/test-toctree-index/index.rst tests/test_environment_toctree.py
else
  tox --current-env -epy39 -v -- "$@"
fi
