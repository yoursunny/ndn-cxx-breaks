#!/usr/bin/env bash
set -eo pipefail

./build_ChronoSync.sh install
./build_PSync.sh install

mkdir -p NLSR
cd NLSR

../checkout.sh NLSR

echo Building NLSR
./waf configure --with-tests --debug
./waf -j$(nproc) || ./waf -j1

echo Running NLSR tests
build/unit-tests-nlsr
