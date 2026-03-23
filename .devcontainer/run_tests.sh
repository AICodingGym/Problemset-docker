#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  PYTHONWARNINGS='ignore::UserWarning,ignore::SyntaxWarning,ignore::DeprecationWarning' bin/test -C --verbose sympy/printing/pretty/tests/test_pretty.py sympy/printing/tests/test_ccode.py sympy/printing/tests/test_fcode.py sympy/printing/tests/test_jscode.py sympy/printing/tests/test_julia.py sympy/printing/tests/test_latex.py sympy/printing/tests/test_octave.py sympy/printing/tests/test_rcode.py sympy/printing/tests/test_str.py
else
  PYTHONWARNINGS='ignore::UserWarning,ignore::SyntaxWarning,ignore::DeprecationWarning' bin/test -C --verbose "$@"
fi
