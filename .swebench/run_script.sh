#!/bin/bash
set -eo pipefail

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

cd /app

# Run test command with provided test files
if [ $# -eq 0 ]; then
    pytest --no-header -rA
else
    if [[ "$1" == *","* ]]; then
        IFS=',' read -r -a TEST_FILES <<< "$1"
    else
        TEST_FILES=("$@")
    fi
    pytest --no-header -rA "${TEST_FILES[@]}"
fi
