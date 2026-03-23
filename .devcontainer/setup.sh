#!/bin/bash
set -e

# Copy compiled artifacts (.so, _version.py) from Docker's /app to workspace
if [ -d /app ] && [ ! -L /app ]; then
  find /app -name "*.so" -exec cp --parents {} "$(pwd)/" \; 2>/dev/null || true
  find /app -name "_version.py" -exec cp --parents {} "$(pwd)/" \; 2>/dev/null || true
  # Symlink /app to workspace so editable install paths resolve correctly
  rm -rf /app
  ln -sf "$(pwd)" /app
fi

# Install AI coding CLI tools
pip install aicodinggym-cli || true
npm install -g @anthropic-ai/claude-code @openai/codex 2>/dev/null || true

echo ""
echo "=== Environment ready! ==="
