#!/usr/bin/env bash
set -e

mkdir -p ChronoSync
cd ChronoSync

../checkout.sh CHRONOSYNC ChronoSync

echo Building ChronoSync
./waf configure --debug
./waf -j4 || ./waf -j1
./waf install
ldconfig

cd ..

mkdir -p PSync
cd PSync

../checkout.sh PSYNC PSync

echo Building PSync
./waf configure --debug
./waf -j4 || ./waf -j1
./waf install
ldconfig

cd ..

mkdir -p NLSR
cd NLSR

../checkout.sh NLSR NLSR

echo Building NLSR
./waf configure --with-tests --debug
./waf -j4 || ./waf -j1

echo Running NLSR tests
build/unit-tests-nlsr -l test_suite
