#!/usr/bin/env python3
import json
import re
import sys

def parse(stdout_path, stderr_path, output_path):
    with open(stdout_path) as f:
        stdout = f.read()
    with open(stderr_path) as f:
        stderr = f.read()

    results = []
    combined = stdout + '\n' + stderr

    # Count PASSED/FAILED/ERROR from pytest output
    for line in combined.splitlines():
        m = re.match(r'^(\S+::\S+)\s+(PASSED|FAILED|ERROR)', line)
        if m:
            results.append({"name": m.group(1), "status": m.group(2)})

    # Detect [build failed]
    if not results:
        if re.search(r'\[build failed\]', combined, re.IGNORECASE):
            results.append({"name": "build_failed", "status": "FAILED"})

    with open(output_path, 'w') as f:
        json.dump({"tests": results}, f, indent=2)

if __name__ == "__main__":
    parse(sys.argv[1], sys.argv[2], sys.argv[3])
