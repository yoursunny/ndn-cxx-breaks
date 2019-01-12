#!/usr/bin/env bash
set -e

mkdir -p PSync
cd PSync

../checkout.sh PSYNC PSync

echo Building PSync
./waf configure --with-tests --debug
./waf -j4 || ./waf -j1

echo Running PSync tests
LD_LIBRARY_PATH=build build/unit-tests -l test_suite
