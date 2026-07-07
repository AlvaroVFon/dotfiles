#!/usr/bin/env bash

set -euo pipefail

if flatpak info com.spotify.Client &>/dev/null; then
  echo "✓ Spotify already installed"
  exit 0
fi

echo "==> Installing Spotify..."

if ! command -v flatpak &>/dev/null; then
  sudo dnf install -y flatpak
fi

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.spotify.Client

echo "✓ Spotify installed"
