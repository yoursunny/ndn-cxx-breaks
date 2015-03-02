#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

mkdir -p repos/ndn-traffic-generator
cd repos/ndn-traffic-generator

echo Checking out from Gerrit: ndn-traffic-generator master
git init
git fetch --depth=1 http://gerrit.named-data.net/ndn-traffic-generator && git checkout FETCH_HEAD
git submodule update --init

echo Building ndn-traffic-generator
./waf configure $BOOST_LIBS
./waf -j4 || ./waf -j1
