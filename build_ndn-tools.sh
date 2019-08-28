#!/usr/bin/env bash
set -e

mkdir -p ndn-tools
cd ndn-tools

../checkout.sh ndn-tools

echo Building ndn-tools
./waf configure --debug --with-tests
./waf -j4 || ./waf -j1

echo Running ndn-tools tests
build/unit-tests
