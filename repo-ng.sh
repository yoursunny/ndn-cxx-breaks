#!/usr/bin/env bash
set -eo pipefail

mkdir -p repo-ng
cd repo-ng

../checkout_gerrit.sh repo-ng

echo Building repo-ng
./waf configure --with-tests --with-examples --debug
./waf -j$(nproc) || ./waf -j1

echo Running repo-ng tests
build/unit-tests
