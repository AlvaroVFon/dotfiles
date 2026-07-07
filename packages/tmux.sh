#!/usr/bin/env bash
#!/usr/bin/env bash

set -euo pipefail

sudo dnf install -y tmux

TPM_DIR="$HOME/.config/tmux/plugins/tpm"

if [[ ! -d "$TPM_DIR" ]]; then
  echo "==> Installing TPM..."

  mkdir -p "$(dirname "$TPM_DIR")"

  git clone \
    https://github.com/tmux-plugins/tpm \
    "$TPM_DIR"
fi

if [[ -f "$TPM_DIR/bin/install_plugins" ]]; then
  echo "==> Installing tmux plugins..."
  "$TPM_DIR/bin/install_plugins"
fi

echo "✓ tmux installed"
