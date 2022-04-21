#!/usr/bin/env bash
set -eo pipefail

mkdir -p ndns
cd ndns

../checkout_gerrit.sh ndns

echo Building ndns
./waf configure --with-tests --debug
./waf -j$(nproc) || ./waf -j1

echo Running ndns tests
build/unit-tests
