#!/usr/bin/env bash
set -e

mkdir -p ndns
cd ndns

../checkout.sh NDNS ndns

echo Building ndns
./waf configure --with-tests --debug
./waf -j4 || ./waf -j1

echo Running ndns tests
build/unit-tests -l test_suite
