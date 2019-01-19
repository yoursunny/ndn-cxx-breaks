#!/usr/bin/env bash
set -e

mkdir -p ndn-traffic-generator
cd ndn-traffic-generator

../checkout.sh ndn-traffic-generator NTG

echo Building ndn-traffic-generator
./waf configure
./waf -j4 || ./waf -j1
