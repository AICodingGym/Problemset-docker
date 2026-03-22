#!/bin/bash
set -x

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

cd /app

git reset --hard 45c0a114e2b7b27b83c9618bc05b36afac82183c
git checkout 45c0a114e2b7b27b83c9618bc05b36afac82183c

# Apply user patch
git apply -v /workspace/patch.diff || echo 'WARNING: patch apply failed'

# Apply test setup (checkout gold test files)
# (before_repo_cmd will be added per-instance if needed)

# Run tests
bash /workspace/run_script.sh > /workspace/stdout.log 2> /workspace/stderr.log
RUN_SCRIPT_EXIT=$?

# Parse results
python /workspace/parser.py /workspace/stdout.log /workspace/stderr.log /workspace/output.json || true

# Print outputs for GHA log
echo '=== STDOUT ==='
cat /workspace/stdout.log 2>/dev/null || true
echo '=== STDERR ==='
cat /workspace/stderr.log 2>/dev/null || true
echo '=== PARSED OUTPUT ==='
cat /workspace/output.json 2>/dev/null || true

# Exit with the test runner's exit code
exit $RUN_SCRIPT_EXIT
