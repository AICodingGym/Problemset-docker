#!/bin/bash
set -eo pipefail

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

cd /app

# Run test command with provided test files
if [ $# -eq 0 ]; then
    PYTHONWARNINGS='ignore::UserWarning,ignore::SyntaxWarning' bin/test -C --verbose
else
    if [[ "$1" == *","* ]]; then
        IFS=',' read -r -a TEST_FILES <<< "$1"
    else
        TEST_FILES=("$@")
    fi
    PYTHONWARNINGS='ignore::UserWarning,ignore::SyntaxWarning' bin/test -C --verbose "${TEST_FILES[@]}"
fi
