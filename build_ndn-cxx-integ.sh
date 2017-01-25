#!/usr/bin/env bash
set -e

mkdir -p repos/NFD
cd repos/NFD

../../checkout.sh NFD NFD

echo Building NFD
./waf configure
./waf -j4 || ./waf -j1
sudo ./waf install

cd ../..

echo Starting NFD
sudo cp /usr/local/etc/ndn/nfd.conf.sample /usr/local/etc/ndn/nfd.conf
nfd-start &>/dev/null

sleep 15

cd repos/ndn-cxx/build

echo Running face integ
tests/integrated/face -l test_suite
