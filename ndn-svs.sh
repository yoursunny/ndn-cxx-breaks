#!/usr/bin/env bash
set -eo pipefail

mkdir -p ndn-svs
cd ndn-svs

../checkout_github.sh ndn-svs

echo Building ndn-svs
./waf configure --debug $([[ -z $1 ]] && echo --with-examples --with-tests)
./waf -j$(nproc) || ./waf -j1

if [[ $1 == install ]]; then
  sudo ./waf install
  sudo ldconfig
  exit 0
fi

echo Running ndn-svs tests
LD_LIBRARY_PATH=build build/unit-tests
