#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  ./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1 tests/serializers/models/base.py tests/serializers/test_json.py tests/serializers/test_jsonl.py tests/serializers/test_xml.py tests/serializers/test_yaml.py tests/serializers/tests.py
else
  ./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1 "$@"
fi
