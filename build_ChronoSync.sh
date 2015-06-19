#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

mkdir -p repos/ChronoSync
cd repos/ChronoSync

../../checkout.sh CHRONOSYNC ChronoSync

echo Building ChronoSync
./waf configure --with-tests --debug $BOOST_LIBS
./waf -j4 || ./waf -j1

echo Running ChronoSync tests
LD_LIBRARY_PATH=build/ build/unit-tests -l test_suite
