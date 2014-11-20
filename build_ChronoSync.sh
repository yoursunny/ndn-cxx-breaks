#!/usr/bin/env bash
set -e

mkdir -p repos/ChronoSync
cd repos/ChronoSync

echo Checking out from Gerrit: NLSR master
git init
git fetch --depth=1 http://gerrit.named-data.net/ChronoSync && git checkout FETCH_HEAD
git submodule update --init

echo Building ChronoSync
./waf configure --with-tests --debug
./waf -j4

echo Running ChronoSync tests
build/unit-tests -l test_suite
