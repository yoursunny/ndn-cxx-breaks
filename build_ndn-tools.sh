#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

mkdir -p repos/ndn-tools
cd repos/ndn-tools

../../checkout.sh NDNTOOLS ndn-tools

echo Building ndn-tools
./waf configure --debug $BOOST_LIBS
./waf -j4 || ./waf -j1
