#!/usr/bin/env bash
set -eo pipefail

mkdir -p name-based-access-control
cd name-based-access-control

../checkout.sh name-based-access-control

echo Building name-based-access-control
./waf configure --debug --with-examples --with-tests
./waf -j$(nproc) || ./waf -j1

echo Running name-based-access-control tests
LD_LIBRARY_PATH=build build/unit-tests
