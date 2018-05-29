#!/usr/bin/env bash
set -e

mkdir -p ndn-traffic-generator
cd ndn-traffic-generator

../checkout.sh TRAFFICGEN ndn-traffic-generator

echo Building ndn-traffic-generator
./waf configure
./waf -j4 || ./waf -j1
