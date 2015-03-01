#!/usr/bin/env bash
set -e

mkdir -p repos/repo-ng
cd repos/repo-ng

echo Checking out from Gerrit: repo-ng master
git init
git fetch --depth=1 http://gerrit.named-data.net/repo-ng && git checkout FETCH_HEAD
git submodule update --init

echo Building repo-ng
./waf configure --with-tests --with-examples --debug $BOOST_LIBS
./waf -j2

echo Running repo-ng tests
build/unit-tests -l test_suite
