#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

mkdir -p repos/ns-3
cd repos/ns-3

echo Checking out from GitHub: ns-3-dev-ndnSIM
git init
git fetch --depth=1 https://github.com/cawka/ns-3-dev-ndnSIM.git && git checkout FETCH_HEAD
git submodule update --init

mkdir -p src/ndnSIM
cd src/ndnSIM

echo Checking out from GitHub: ndnSIM
git init
git fetch --depth=1 https://github.com/named-data/ndnSIM.git && git checkout FETCH_HEAD
git submodule update --init

cd ../../

echo Building ndnSIM
./waf configure --disable-python --enable-tests --enable-examples $BOOST_LIBS
./waf -j4

echo Running ndnSIM tests: ndn-test
NS_LOG=ndn.Consumer ./waf --run ndn-test

