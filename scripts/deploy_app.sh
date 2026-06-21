#!/usr/bin/env bash
set -euo pipefail
cd /opt/retail-intelligence-platform/app
docker compose up -d --build
