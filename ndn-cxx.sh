#!/usr/bin/env bash
set -eo pipefail

mkdir -p ndn-cxx
cd ndn-cxx

../checkout_gerrit.sh ndn-cxx

./waf configure --debug
./waf -j$(nproc) || ./waf -j1
sudo ./waf install
sudo ldconfig

ndnsec key-gen /operator >/dev/null
