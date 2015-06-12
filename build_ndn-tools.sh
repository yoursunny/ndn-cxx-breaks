#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

mkdir -p repos/ndn-tools
cd repos/ndn-tools

echo Checking out from Gerrit: ndn-tools master
git init
git fetch --depth=1 http://gerrit.named-data.net/ndn-tools && git checkout FETCH_HEAD
git submodule update --init

echo Building ndn-tools
./waf configure --debug $BOOST_LIBS
./waf -j4 || ./waf -j1
