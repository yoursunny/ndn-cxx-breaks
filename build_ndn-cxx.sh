#!/usr/bin/env bash
set -e

mkdir -p ndn-cxx
cd ndn-cxx

../checkout.sh NDNCXX ndn-cxx

EXTRA=
if [[ $PROJECT == ndn-cxx-integ ]]; then
  EXTRA='--with-tests --with-examples'
fi

echo Building ndn-cxx
./waf configure --debug --without-pch $EXTRA
./waf -j4 || ./waf -j1
./waf install
ldconfig

ndnsec-keygen /operator | ndnsec-install-cert -
