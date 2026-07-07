#!/usr/bin/env bash

set -euo pipefail

if ! dnf copr list | grep -q "lihaohong/yazi"; then
  sudo dnf copr enable -y lihaohong/yazi
fi

sudo dnf install -y yazi

echo "✓ Yazi installed"
