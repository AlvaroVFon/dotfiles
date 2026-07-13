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

ALL_MODULES=(
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
  spotify
  kinto
)

run_module() {
  local module="$1"
  local script="${PACKAGES_DIR}/${module}.sh"

  if [[ ! -f "${script}" ]]; then
    echo " Module '${module}' not found."
    return 1
  fi

  echo ""
  echo "==> Installing ${module}"
  bash "${script}"
}

print_report() {
  local -n failed="$1"

  echo ""
  if [[ ${#failed[@]} -eq 0 ]]; then
    echo "Todos los modulos se instalaron correctamente."
  else
    echo "Los siguientes modulos fallaron:"
    printf '  - %s\n' "${failed[@]}"
    echo ""
    echo "Puedes reintentarlos con: ./install.sh ${failed[*]}"
  fi
}

main() {
  if [[ "${1:-}" == "--update" ]]; then
    echo "==> Running update..."
    bash "${ROOT_DIR}/update.sh"
    return
  fi

  require_sudo

  local modules_to_run=()
  if [[ $# -eq 0 ]]; then
    modules_to_run=("${ALL_MODULES[@]}")
  else
    modules_to_run=("$@")
  fi

  local failed_modules=()
  for module in "${modules_to_run[@]}"; do
    run_module "${module}" || failed_modules+=("$module")
  done

  echo ""
  echo "==> Linking dotfiles..."
  bash "${ROOT_DIR}/scripts/link.sh"

  print_report failed_modules
}

main "$@"
