#!/usr/bin/env bash

set -euo pipefail

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd -P)"

update_vscode_extensions() {
  local extensions_file="${ROOT_DIR}/config/vscode/extensions.json"

  if [[ ! -f "$extensions_file" ]]; then
    return
  fi

  if ! command -v jq >/dev/null; then
    sudo dnf install -y jq
  fi

  echo "==> Updating VS Code extensions..."

  jq -r '.recommendations[]' "$extensions_file" | while read -r ext; do
    echo "  -> $ext"
    code --install-extension "$ext" --force
  done
}

update_ohmyzsh() {
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "==> Updating Oh My Zsh..."
    zsh -c "source \$ZSH/tools/upgrade.sh" 2>/dev/null || true
  fi
}

update_zsh_plugins() {
  local plugins_file="${ROOT_DIR}/config/zsh/oh-my-zsh.sh"
  local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

  if [[ ! -f "$plugins_file" ]]; then
    return
  fi

  echo "==> Updating zsh plugins..."

  mkdir -p "$zsh_custom/plugins"

  while IFS='#' read -r name comment; do
    name="${name//[[:space:]]/}"
    repo="${comment//[[:space:]]/}"

    [[ -z "$name" ]] && continue
    [[ "$repo" == "built-in" ]] && continue

    local target="$zsh_custom/plugins/$name"

    if [[ -d "$target/.git" ]]; then
      echo "  -> $name (updated)"
      git -C "$target" pull --ff-only --quiet 2>/dev/null || echo "  ⚠ Failed to update $name"
    elif [[ -n "$repo" ]]; then
      echo "  -> $name (installed)"
      git clone --depth 1 "https://github.com/$repo.git" "$target" 2>/dev/null || echo "  ⚠ Failed to install $name"
    fi
  done < <(sed -n '/^plugins=(/,/^)/p' "$plugins_file" | grep -E '^[[:space:]]+#?[a-z]')
}

update_starship() {
  if command -v starship >/dev/null; then
    echo "==> Updating Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y 2>/dev/null || true
  fi
}

update_node() {
  if command -v fnm >/dev/null; then
    echo "==> Updating Node.js..."
    eval "$(fnm env)"
    fnm install --lts
  fi
}

update_python() {
  if command -v pipx >/dev/null; then
    echo "==> Updating pipx packages..."
    pipx upgrade-all 2>/dev/null || true
  fi
  if command -v uv >/dev/null; then
    echo "==> Updating uv..."
    uv self update 2>/dev/null || true
  fi
}

update_rust() {
  if command -v rustup >/dev/null; then
    echo "==> Updating Rust..."
    rustup update stable 2>/dev/null || true
  fi
}

update_fonts() {
  if fc-list | grep -qi "FiraCode Nerd Font" 2>/dev/null; then
    echo "==> Updating fonts cache..."
    fc-cache -f 2>/dev/null || true
  fi
}

main() {
  echo ""
  echo "==> Updating dotfiles..."

  update_vscode_extensions
  update_ohmyzsh
  update_zsh_plugins
  update_starship
  update_node
  update_python
  update_rust
  update_fonts

  echo ""
  echo "==> Updating dnf packages..."
  sudo dnf upgrade --refresh -y

  echo ""
  echo "==> Linking dotfiles..."
  bash "${ROOT_DIR}/scripts/link.sh"

  echo ""
  echo "✓ Update complete"
}

main "$@"
