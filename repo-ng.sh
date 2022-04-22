#!/usr/bin/env bash
set -eo pipefail

mkdir -p repo-ng
cd repo-ng

../checkout.sh repo-ng

echo Building repo-ng
./waf configure --debug --with-examples --with-tests
./waf -j$(nproc) || ./waf -j1

echo Running repo-ng tests
build/unit-tests
