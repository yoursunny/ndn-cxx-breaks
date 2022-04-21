#!/usr/bin/env bash
set -eo pipefail

mkdir -p ndn-traffic-generator
cd ndn-traffic-generator

../checkout_gerrit.sh ndn-traffic-generator

echo Building ndn-traffic-generator
./waf configure
./waf -j$(nproc) || ./waf -j1
