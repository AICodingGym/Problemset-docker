#!/bin/bash
set -e

# Run tests
if [ $# -eq 0 ]; then
  pytest -rA 
else
  pytest -rA "$@"
fi
