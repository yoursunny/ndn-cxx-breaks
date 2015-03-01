#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

mkdir -p repos/ndns
cd repos/ndns

echo Checking out from Gerrit: ndns master
git init
git fetch --depth=1 http://gerrit.named-data.net/ndns && git checkout FETCH_HEAD
git submodule update --init

echo Building ndns
./waf configure --with-tests --debug $BOOST_LIBS
./waf -j2

echo Running ndns tests
build/unit-tests -l test_suite
