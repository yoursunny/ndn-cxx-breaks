#!/usr/bin/env bash
set -e

mkdir -p repos/repo-ng
cd repos/repo-ng

../../checkout.sh REPONG repo-ng

echo Building repo-ng
./waf configure --with-tests --with-examples --debug
./waf -j4 || ./waf -j1

echo Running repo-ng tests
build/unit-tests -l test_suite
