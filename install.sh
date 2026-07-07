#!/usr/bin/env bash

set -euo pipefail

require_sudo() {
  sudo -v

  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &
}

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd -P)"
readonly PACKAGES_DIR="${ROOT_DIR}/packages"

MODULES=(
  rpmfusion
  essentials
  fonts
  zsh
  nvim
  tmux
  ghostty
  lazygit
  yazi
  vscode
  node
  python
  rust
  go
  docker
)

run_module() {
  local module="$1"
  local script="${PACKAGES_DIR}/${module}.sh"

  if [[ ! -f "${script}" ]]; then
    echo "❌ Module '${module}' not found."
    exit 1
  fi

  echo ""
  echo "==> Installing ${module}"
  bash "${script}"
}

main() {
  if [[ "${1:-}" == "--update" ]]; then
    echo "==> Running update..."
    bash "${ROOT_DIR}/update.sh"
    return
  fi

  require_sudo

  if [[ $# -eq 0 ]]; then
    for module in "${MODULES[@]}"; do
      run_module "${module}"
    done
    return
  fi

  for module in "$@"; do
    run_module "${module}"
  done

  echo ""
  echo "==> Linking dotfiles..."
  bash "${ROOT_DIR}/scripts/link.sh"
}

main "$@"
