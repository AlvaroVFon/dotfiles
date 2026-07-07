#!/usr/bin/env bash

set -euo pipefail

echo "==> Installing essential CLI tools..."

sudo dnf install -y \
  ripgrep \
  fd-find \
  fzf \
  bat \
  eza \
  zoxide \
  jq \
  btop \
  fastfetch \
  unzip \
  git

if command -v bat >/dev/null; then
  bat cache --build &>/dev/null || true
fi

echo "✓ Essentials installed"
