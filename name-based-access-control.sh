#!/usr/bin/env bash
set -eo pipefail

mkdir -p name-based-access-control
cd name-based-access-control

../checkout_gerrit.sh name-based-access-control

echo Building name-based-access-control
./waf configure --with-tests --debug
./waf -j$(nproc) || ./waf -j1

echo Running name-based-access-control tests
LD_LIBRARY_PATH=build build/unit-tests
