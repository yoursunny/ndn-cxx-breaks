#!/usr/bin/env bash
set -e

if [[ -f PATCHSET ]]; then
  export PATCHSET_NDNCXX=$(cat PATCHSET)
fi

mkdir -p repos/ndn-cxx
cd repos/ndn-cxx

../../checkout.sh NDNCXX ndn-cxx

echo Building ndn-cxx
./waf configure --debug --without-pch --enable-shared --disable-static
./waf -j4 || ./waf -j1
sudo ./waf install
sudo ldconfig
