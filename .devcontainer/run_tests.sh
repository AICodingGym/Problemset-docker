#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  PYTHONWARNINGS='ignore::UserWarning,ignore::SyntaxWarning' bin/test -C --verbose sympy/physics/quantum/tests/test_dagger.py sympy/physics/quantum/tests/test_operator.py
else
  PYTHONWARNINGS='ignore::UserWarning,ignore::SyntaxWarning' bin/test -C --verbose "$@"
fi
