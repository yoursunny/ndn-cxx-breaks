#!/usr/bin/env bash
set -eo pipefail

mkdir -p ndn-traffic-generator
cd ndn-traffic-generator

../checkout.sh ndn-traffic-generator

echo Building ndn-traffic-generator
./waf configure
./waf -j$(nproc) || ./waf -j1
