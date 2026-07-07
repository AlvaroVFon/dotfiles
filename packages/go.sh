#!/usr/bin/env bash

set -euo pipefail

if command -v go >/dev/null; then
  echo "✓ Go already installed"
else
  sudo dnf install -y golang
fi

echo "✓ Go installed"
