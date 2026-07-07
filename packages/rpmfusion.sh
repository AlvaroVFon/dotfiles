#!/usr/bin/env bash

set -euo pipefail

echo "==> Enabling RPM Fusion repositories..."

sudo dnf install -y \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm

if rpm -q ffmpeg-free &>/dev/null; then
  sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
else
  sudo dnf install -y ffmpeg
fi

sudo dnf install -y ffmpegthumbnailer

echo "✓ RPM Fusion configured"
