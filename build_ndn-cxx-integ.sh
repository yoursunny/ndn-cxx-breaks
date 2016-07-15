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

cd repos/ndn-cxx/build

for F in $(find tests/integrated/ -type f -executable); do
  echo Running ndn-cxx $F
  $F -l test_suite
done
