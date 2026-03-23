#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  ./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1 tests/i18n/patterns/tests.py tests/i18n/patterns/urls/default.py tests/urlpatterns/path_urls.py tests/urlpatterns/tests.py tests/urlpatterns_reverse/tests.py
else
  ./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1 "$@"
fi
