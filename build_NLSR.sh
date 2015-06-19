#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

mkdir -p repos/NLSR
cd repos/NLSR

../../checkout.sh NLSR NLSR

echo Building NLSR
./waf configure --with-tests --debug $BOOST_LIBS
./waf -j4 || ./waf -j1

echo Running NLSR tests: nlsr
build/unit-tests-nlsr -l test_suite

echo Running NLSR tests: nsync
build/unit-tests-nsync -l test_suite
