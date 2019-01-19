#!/usr/bin/env bash
set -e

mkdir -p ndncert
cd ndncert

../checkout.sh ndncert

echo Building ndncert
./waf configure --with-tests --debug
./waf -j4 || ./waf -j1

echo Running ndncert tests
LD_LIBRARY_PATH=build build/unit-tests -l test_suite
