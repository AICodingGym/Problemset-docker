#!/bin/bash
set -e

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate testbed

# Run tests
if [ $# -eq 0 ]; then
  ./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1 tests/admin_docs/test_views.py tests/auth_tests/test_forms.py tests/forms_tests/tests/test_forms.py tests/forms_tests/widget_tests/base.py tests/forms_tests/widget_tests/test_clearablefileinput.py tests/model_forms/tests.py tests/template_tests/filter_tests/test_addslashes.py tests/template_tests/filter_tests/test_make_list.py tests/template_tests/filter_tests/test_title.py tests/template_tests/filter_tests/test_urlize.py tests/template_tests/syntax_tests/test_url.py tests/utils_tests/test_html.py tests/view_tests/tests/test_csrf.py tests/view_tests/tests/test_debug.py
else
  ./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1 "$@"
fi
