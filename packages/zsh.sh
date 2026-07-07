#!/usr/bin/env bash

set -euo pipefail

sudo dnf install -y zsh curl git

if [[ "$SHELL" != "$(which zsh)" ]]; then
  echo "Changing default shell to Zsh..."
  sudo usermod -s "$(which zsh)" "$USER"
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Installing Oh My Zsh..."

  RUNZSH=no \
    CHSH=no \
    KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

plugins=(
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-completions
)

for plugin in "${plugins[@]}"; do
  name=$(basename "$plugin")
  target="$ZSH_CUSTOM/plugins/$name"

  if [[ ! -d "$target" ]]; then
    echo "==> Installing $name..."
    git clone "https://github.com/$plugin.git" "$target"
  fi
done

if ! command -v starship >/dev/null; then
  echo "Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

echo "✓ Zsh environment ready"
