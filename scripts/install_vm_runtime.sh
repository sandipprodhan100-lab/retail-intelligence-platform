#!/usr/bin/env bash
set -euo pipefail
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg git
if ! command -v docker >/dev/null 2>&1; then
  curl -fsSL https://get.docker.com | sudo sh
  sudo usermod -aG docker "$USER"
fi
sudo systemctl enable docker
sudo systemctl start docker
