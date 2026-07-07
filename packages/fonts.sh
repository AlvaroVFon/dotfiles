#!/usr/bin/env bash

set -euo pipefail

FONT_DIR="$HOME/.local/share/fonts"

if fc-list | grep -qi "FiraCode Nerd Font" 2>/dev/null; then
  echo "✓ FiraCode Nerd Font already installed"
  exit 0
fi

mkdir -p "$FONT_DIR"

curl -fSLo /tmp/FiraCode.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip"
unzip -qo /tmp/FiraCode.zip -d "$FONT_DIR"
rm -f /tmp/FiraCode.zip

fc-cache -f

echo "✓ FiraCode Nerd Font installed"
