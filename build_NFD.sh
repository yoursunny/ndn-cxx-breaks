#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

mkdir -p repos/NFD
cd repos/NFD

../../checkout.sh NFD NFD

# note: building both ndn-cxx and NFD in debug mode would exceed TravisCI memory limit,
#       so we have to build both ndn-cxx(debug)+NFD(release) and ndn-cxx(release)+NFD(debug)
#       in order to catch most problems.
DEBUG_FLAG=--debug
if [[ ${NFD_DEBUG=1} -eq 0 ]]; then
  DEBUG_FLAG=
fi

echo Building NFD
./waf configure --with-tests $DEBUG_FLAG --without-pch $BOOST_LIBS
./waf -j4 || ./waf -j1

echo Running NFD tests: core
build/unit-tests-core -l test_suite

echo Running NFD tests: daemon
#sudo setcap cap_net_raw,cap_net_admin=eip build/unit-tests-daemon || true
sudo build/unit-tests-daemon -l test_suite

echo Running NFD tests: rib
build/unit-tests-rib -l test_suite
