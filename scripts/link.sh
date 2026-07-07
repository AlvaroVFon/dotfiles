#!/usr/bin/env bash

set -euo pipefail

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly LINKS_FILE="${ROOT_DIR}/scripts/links.map"

link() {
  local source="$1"
  local target="$2"

  if [[ ! -e "$source" ]]; then
    echo "❌ Source not found: $source"
    return 1
  fi

  mkdir -p "$(dirname "$target")"

  if [[ -L "$target" || -f "$target" || -d "$target" ]]; then
    local backup="${target}.bak.$(date +%Y%m%d%H%M%S)"
    echo "  → Backing up $target to $backup"
    mv "$target" "$backup"
  fi

  ln -s "$source" "$target"

  echo "✓ Linked $target"
}

main() {
  echo "==> Linking dotfiles..."

  while IFS=: read -r source target; do

    # Ignorar líneas vacías y comentarios
    [[ -z "${source// /}" ]] && continue
    [[ "$source" =~ ^[[:space:]]*# ]] && continue

    link \
      "${ROOT_DIR}/${source}" \
      "${HOME}/${target}"

  done <"$LINKS_FILE"

  echo "✓ Done."
}

main "$@"
