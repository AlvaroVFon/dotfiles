#!/usr/bin/env bash

set -euo pipefail

USE_PODMAN="${USE_PODMAN:-false}"

if [[ "$USE_PODMAN" == "true" ]]; then
  if command -v podman >/dev/null; then
    echo "✓ Podman already installed"
  else
    echo "==> Installing Podman..."
    sudo dnf install -y podman podman-compose
  fi

  if ! grep -q "$USER" < <(getent group podman 2>/dev/null); then
    echo "==> Adding user to podman group..."
    sudo usermod -aG podman "$USER"
  fi
else
  if command -v docker >/dev/null; then
    echo "✓ Docker already installed"
  else
    echo "==> Installing Docker..."

    sudo dnf install -y dnf-plugins-core
    sudo curl -sSL https://download.docker.com/linux/fedora/docker-ce.repo -o /etc/yum.repos.d/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

    sudo systemctl enable --now docker
  fi

  if ! groups "$USER" | grep -q docker; then
    echo "==> Adding user to docker group..."
    sudo usermod -aG docker "$USER"
    echo "  ⚠ You'll need to log out and back in for group changes to take effect."
  fi
fi

echo "✓ Containers ready"
