#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

if [[ -f PATCHSET ]]; then
  export PATCHSET_NDNCXX=$(cat PATCHSET)
fi

mkdir -p repos/ndn-cxx
cd repos/ndn-cxx

../../checkout.sh NDNCXX ndn-cxx

DEBUG_FLAG=--debug
if [[ ${NDNCXX_DEBUG=1} -eq 0 ]]; then
  DEBUG_FLAG=
fi

echo Building ndn-cxx
./waf configure $DEBUG_FLAG --without-pch --enable-shared --disable-static $BOOST_LIBS
./waf -j4 || ./waf -j1
sudo ./waf install
sudo ldconfig
