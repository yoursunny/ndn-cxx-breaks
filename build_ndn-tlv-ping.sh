#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

mkdir -p repos/ndn-tlv-ping
cd repos/ndn-tlv-ping

echo Checking out from Gerrit: ndn-tlv-ping master
git init
git fetch --depth=1 http://gerrit.named-data.net/ndn-tlv-ping && git checkout FETCH_HEAD
git submodule update --init

echo Building ndn-tlv-ping
./waf configure --debug $BOOST_LIBS
./waf -j4 || ./waf -j1
