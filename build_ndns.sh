#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

mkdir -p repos/ndns
cd repos/ndns

../../checkout.sh NDNS ndns

echo Building ndns
./waf configure --with-tests --debug $BOOST_LIBS
./waf -j4 || ./waf -j1

echo Running ndns tests
build/unit-tests -l test_suite
