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
  if command -v docker-desktop >/dev/null; then
    echo "✓ Docker Desktop already installed"
  else
    echo "==> Installing Docker Desktop..."

    # Remove conflicting Docker CE packages if present
    if rpm -q docker-ce docker-ce-cli containerd.io docker-compose-plugin &>/dev/null 2>&1; then
      echo "  -> Removing conflicting Docker CE packages..."
      sudo dnf remove -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    fi

    # Ensure dependencies
    sudo dnf install -y dnf-plugins-core curl

    # Download Docker Desktop RPM
    rpm_url="https://desktop.docker.com/linux/main/amd64/docker-desktop-x86_64.rpm"
    rpm_file="/tmp/docker-desktop-x86_64.rpm"

    echo "  -> Downloading Docker Desktop..."
    curl -sSL "$rpm_url" -o "$rpm_file"

    echo "  -> Installing Docker Desktop..."
    sudo dnf install -y "$rpm_file"

    # Cleanup
    rm -f "$rpm_file"
  fi

  if ! groups "$USER" | grep -q docker; then
    echo "==> Adding user to docker group..."
    sudo usermod -aG docker "$USER"
    echo "  ⚠ You'll need to log out and back in for group changes to take effect."
  fi
fi

echo "✓ Containers ready"
