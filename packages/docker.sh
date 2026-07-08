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

    # Podman is pre-installed on Fedora and may conflict
    if command -v podman >/dev/null; then
      echo "  ⚠ Podman is installed and may conflict. Remove it if you encounter issues."
      echo "    -> sudo dnf remove podman podman-compose"
    fi

    # Docker Desktop requires docker-ce-cli as a dependency.
    # Add Docker's official repository and install it.
    if ! rpm -q docker-ce-cli &>/dev/null; then
      echo "  -> Adding Docker CE repository..."
      sudo dnf install -y dnf-plugins-core curl
      sudo curl -fsSL https://download.docker.com/linux/fedora/docker-ce.repo \
        -o /etc/yum.repos.d/docker-ce.repo
      echo "  -> Installing docker-ce-cli..."
      sudo dnf install -y docker-ce-cli
    fi

    # Remove conflicting Docker CE packages (daemon only, keep cli)
    for pkg in docker-ce containerd.io docker-compose-plugin; do
      if rpm -q "$pkg" &>/dev/null; then
        echo "  -> Removing conflicting package: $pkg"
        sudo dnf remove -y "$pkg"
      fi
    done

    # Ensure dependencies
    sudo dnf install -y dnf-plugins-core curl

    # Download Docker Desktop RPM
    rpm_url="https://desktop.docker.com/linux/main/amd64/docker-desktop-x86_64.rpm"
    rpm_file="/tmp/docker-desktop-x86_64.rpm"

    echo "  -> Downloading Docker Desktop..."
    curl -fsSL "$rpm_url" -o "$rpm_file"

    if [[ ! -s "$rpm_file" ]]; then
      echo "  ❌ Download failed or file is empty."
      return 1
    fi

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
