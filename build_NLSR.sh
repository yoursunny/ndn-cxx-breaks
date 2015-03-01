#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

mkdir -p repos/NLSR
cd repos/NLSR

echo Checking out from Gerrit: NLSR master
git init
git fetch --depth=1 http://gerrit.named-data.net/NLSR && git checkout FETCH_HEAD
git submodule update --init

echo Building NLSR
./waf configure --with-tests --debug $BOOST_LIBS
./waf -j4

echo Running NLSR tests: nlsr
build/unit-tests-nlsr -l test_suite

echo Running NLSR tests: nsync
build/unit-tests-nsync -l test_suite
