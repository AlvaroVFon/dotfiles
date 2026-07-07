#!/usr/bin/env bash

set -euo pipefail

if command -v fnm >/dev/null; then
  echo "✓ fnm already installed"
else
  echo "==> Installing fnm..."

  curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
fi

export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"

if ! command -v node >/dev/null; then
  echo "==> Installing Node.js LTS..."
  fnm install --lts
  fnm default lts-latest
  eval "$(fnm env)"
fi

if ! command -v pnpm >/dev/null; then
  echo "==> Installing pnpm..."
  sudo npm install -g pnpm@latest
fi

echo "✓ Node.js environment ready"
