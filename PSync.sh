#!/usr/bin/env bash
set -eo pipefail

mkdir -p PSync
cd PSync

../checkout.sh PSync

echo Building PSync
./waf configure --debug $([[ -z $1 ]] && echo --with-examples --with-tests)
./waf -j$(nproc) || ./waf -j1

if [[ $1 == install ]]; then
  sudo ./waf install
  sudo ldconfig
  exit 0
fi

echo Running PSync tests
LD_LIBRARY_PATH=build build/unit-tests
