#!/usr/bin/env bash

set -euo pipefail

if command -v rustup >/dev/null; then
  echo "✓ rustup already installed"
else
  echo "==> Installing rustup..."

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

  source "$HOME/.cargo/env"
fi

if ! command -v rustc >/dev/null; then
  echo "==> Installing stable toolchain..."
  rustup install stable
  rustup default stable
fi

echo "✓ Rust environment ready"
