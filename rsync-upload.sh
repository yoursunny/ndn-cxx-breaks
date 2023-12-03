#!/bin/bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

rsync -rLpvog --delete --delete-excluded --chmod=D770,F660 --chown=sunny:www-data \
  --exclude 'node_modules' --exclude '.git' \
  ./ vps5-php:/home/web/ndn-cxx-breaks
