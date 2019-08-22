#!/usr/bin/env bash
set -e

mkdir -p ndn-cxx
cd ndn-cxx

../checkout.sh ndn-cxx

echo Building ndn-cxx
./waf configure --debug --without-pch
./waf -j4 || ./waf -j1
sudo ./waf install
sudo ldconfig

ndnsec-keygen /operator | ndnsec-install-cert -
