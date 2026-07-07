#!/usr/bin/env bash

set -euo pipefail

echo "==> Installing Python build dependencies..."

sudo dnf install -q -y \
  make \
  gcc \
  zlib-devel \
  bzip2 \
  bzip2-devel \
  readline-devel \
  sqlite \
  sqlite-devel \
  openssl-devel \
  tk-devel \
  libffi-devel \
  xz-devel \
  libuuid-devel \
  findutils

if [[ -d "$HOME/.pyenv" ]] || command -v pyenv >/dev/null; then
  echo "✓ pyenv already installed"
else
  echo "==> Installing pyenv..."

  curl -fsSL https://pyenv.run | bash

  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

if ! command -v pipx >/dev/null; then
  echo "==> Installing pipx..."
  sudo dnf install -y pipx
  pipx ensurepath
fi

if ! command -v uv >/dev/null; then
  echo "==> Installing uv..."
  curl -fsSL https://astral.sh/uv/install.sh | bash
fi

echo "✓ Python environment ready"
