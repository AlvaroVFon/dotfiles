#!/usr/bin/env bash

set -euo pipefail

if ! dnf copr list | grep -q "scottames/ghostty"; then
  sudo dnf copr enable -y scottames/ghostty
fi

sudo dnf install -y ghostty

echo "✓ Ghostty installed"!/usr/bin/env bash
