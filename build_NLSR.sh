#!/usr/bin/env bash
set -e

DEP_CHRONOSYNC=1 ./build_ChronoSync.sh
DEP_PSYNC=1 ./build_PSync.sh

mkdir -p NLSR
cd NLSR

../checkout.sh NLSR

echo Building NLSR
./waf configure --with-tests --debug
./waf -j4 || ./waf -j1

echo Running NLSR tests
build/unit-tests-nlsr -l test_suite
