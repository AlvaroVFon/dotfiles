#!/usr/bin/env bash

set -euo pipefail

if ! rpm -q terra-release >/dev/null 2>&1; then
  echo "==> Adding Terra repository..."

  sudo dnf install -y \
    --nogpgcheck \
    --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' \
    terra-release
fi

sudo dnf install -y lazygit

echo "✓ lazygit installed"
