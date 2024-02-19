#!/usr/bin/env bash
set -eo pipefail

./PSync.sh install
./ndn-svs.sh install

mkdir -p NLSR
cd NLSR

../checkout_gerrit.sh NLSR

echo Building NLSR
./waf configure --debug --with-psync --with-svs --with-tests
./waf -j$(nproc) || ./waf -j1

echo Running NLSR tests
build/unit-tests-nlsr
