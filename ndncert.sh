#!/usr/bin/env bash
set -eo pipefail

mkdir -p ndncert
cd ndncert

../checkout_gerrit.sh ndncert

echo Building ndncert
./waf configure --with-tests --debug
./waf -j$(nproc) || ./waf -j1

echo Running ndncert tests
LD_LIBRARY_PATH=build build/unit-tests
