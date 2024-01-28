#!/bin/bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

for DEP in *.deps; do
  env LC_ALL=C sort $DEP >$DEP.sorted
  mv $DEP.sorted $DEP
done

docker run --rm -u $(id -u):$(id -g) -v $PWD:/mnt -w /mnt mvdan/shfmt:v3 -l -w -s -i=2 -ci *.sh
