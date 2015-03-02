#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

mkdir -p repos/NFD
cd repos/NFD

echo Checking out from Gerrit: NFD master
git init
git fetch --depth=1 http://gerrit.named-data.net/NFD && git checkout FETCH_HEAD
git submodule update --init

echo Building NFD
# ./waf configure --with-tests --debug --without-pch $BOOST_LIBS
./waf configure --with-tests --without-pch $BOOST_LIBS
./waf -j4 || ./waf -j1

echo Running NFD tests: core
build/unit-tests-core -l test_suite

echo Running NFD tests: daemon
#sudo setcap cap_net_raw,cap_net_admin=eip build/unit-tests-daemon || true
sudo build/unit-tests-daemon -l test_suite

echo Running NFD tests: rib
build/unit-tests-rib -l test_suite
