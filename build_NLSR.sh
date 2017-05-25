#!/usr/bin/env bash
set -e

mkdir -p repos/ChronoSync
cd repos/ChronoSync

../../checkout.sh CHRONOSYNC ChronoSync

echo Building ChronoSync
./waf configure --debug
./waf -j4 || ./waf -j1
sudo ./waf install
sudo ldconfig

cd ../..

mkdir -p repos/NLSR
cd repos/NLSR

../../checkout.sh NLSR NLSR

echo Building NLSR
./waf configure --with-tests --debug
./waf -j4 || ./waf -j1

echo Running NLSR tests: nlsr
build/unit-tests-nlsr -l test_suite

echo Running NLSR tests: nsync
build/unit-tests-nsync -l test_suite
