#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  PYTHONWARNINGS='ignore::UserWarning,ignore::SyntaxWarning,ignore::DeprecationWarning' bin/test -C --verbose sympy/utilities/tests/test_lambdify.py
else
  PYTHONWARNINGS='ignore::UserWarning,ignore::SyntaxWarning,ignore::DeprecationWarning' bin/test -C --verbose "$@"
fi
