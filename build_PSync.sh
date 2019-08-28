#!/usr/bin/env bash
set -e

mkdir -p PSync
cd PSync

../checkout.sh PSync

echo Building PSync
./waf configure --with-tests --debug
./waf -j4 || ./waf -j1

if [[ -n DEP_PSYNC ]]; then
  sudo ./waf install
  sudo ldconfig
  exit 0
fi

echo Running PSync tests
LD_LIBRARY_PATH=build build/unit-tests
