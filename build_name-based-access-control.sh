#!/usr/bin/env bash
set -e

mkdir -p name-based-access-control
cd name-based-access-control

../checkout.sh name-based-access-control NAC

echo Building name-based-access-control
./waf configure --with-tests --debug
./waf -j4 || ./waf -j1

echo Running name-based-access-control tests
LD_LIBRARY_PATH=build build/unit-tests
