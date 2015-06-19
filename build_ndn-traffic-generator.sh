#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

mkdir -p repos/ndn-traffic-generator
cd repos/ndn-traffic-generator

../../checkout.sh TRAFFICGEN ndn-traffic-generator

echo Building ndn-traffic-generator
./waf configure $BOOST_LIBS
./waf -j4 || ./waf -j1
