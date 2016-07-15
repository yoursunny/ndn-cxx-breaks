#!/usr/bin/env bash
set -e

mkdir -p repos/ndn-tools
cd repos/ndn-tools

../../checkout.sh NDNTOOLS ndn-tools

echo Building ndn-tools
./waf configure --debug
./waf -j4 || ./waf -j1
