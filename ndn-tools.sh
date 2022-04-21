#!/usr/bin/env bash
set -eo pipefail

mkdir -p ndn-tools
cd ndn-tools

../checkout_gerrit.sh ndn-tools

echo Building ndn-tools
./waf configure --debug --with-tests
./waf -j$(nproc) || ./waf -j1

echo Running ndn-tools tests
build/unit-tests
