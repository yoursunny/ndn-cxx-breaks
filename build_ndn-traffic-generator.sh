#!/usr/bin/env bash
set -e

mkdir -p repos/ndn-traffic-generator
cd repos/ndn-traffic-generator

../../checkout.sh TRAFFICGEN ndn-traffic-generator

echo Building ndn-traffic-generator
./waf configure
./waf -j4 || ./waf -j1
