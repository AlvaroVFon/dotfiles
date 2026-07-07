#!/usr/bin/env bash

set -euo pipefail

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly EXTENSIONS_FILE="${ROOT_DIR}/config/vscode/extensions.json"

install_code() {
  if ! rpm -q code >/dev/null 2>&1; then
    echo "==> Adding Microsoft repository..."

    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

  fi

  sudo dnf install -y code
  echo "✓ VS Code installed"
}

install_extensions() {
  if ! command -v jq >/dev/null; then
    sudo dnf install -y jq
  fi

  echo "==> Installing VS Code extensions..."

  jq -r '.recommendations[]' "$EXTENSIONS_FILE" | while read -r ext; do
    echo "  -> $ext"
    code --install-extension "$ext" --force
  done

  echo "✓ Extensions installed"
}

install_code
install_extensions
