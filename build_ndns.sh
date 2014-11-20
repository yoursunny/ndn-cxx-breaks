#!/usr/bin/env bash
set -e

mkdir -p repos/ndns
cd repos/ndns

echo Checking out from Gerrit: ndns master
git init
git fetch --depth=1 http://gerrit.named-data.net/ndns && git checkout FETCH_HEAD
git submodule update --init

echo Building ndns
./waf configure --with-tests --debug
./waf -j4

echo Running ndns tests
build/unit-tests -l test_suite
