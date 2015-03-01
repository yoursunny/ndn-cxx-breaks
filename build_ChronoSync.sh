#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

mkdir -p repos/ChronoSync
cd repos/ChronoSync

echo Checking out from Gerrit: ChronoSync master
git init
git fetch --depth=1 http://gerrit.named-data.net/ChronoSync && git checkout FETCH_HEAD
git submodule update --init

echo Building ChronoSync
./waf configure --with-tests --debug $BOOST_LIBS
./waf -j2

echo Running ChronoSync tests
LD_LIBRARY_PATH=build/ build/unit-tests -l test_suite
