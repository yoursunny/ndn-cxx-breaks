#!/usr/bin/env bash
set -e

mkdir -p ndn-tools
cd ndn-tools

../checkout.sh NDNTOOLS ndn-tools

echo Building ndn-tools
./waf configure --debug --with-tests
./waf -j4 || ./waf -j1

echo Running ndn-tools tests
build/unit-tests -l test_suite
