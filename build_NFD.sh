#!/usr/bin/env bash
set -e

mkdir -p repos/NFD
cd repos/NFD

echo Checking out from Gerrit: NFD master
git init
git fetch --depth=1 http://gerrit.named-data.net/NFD && git checkout FETCH_HEAD
git submodule update --init

echo Building NFD
./waf configure --with-tests --debug --without-pch
./waf -j4

echo Running NFD tests: core
build/unit-tests-core -l test_suite

echo Running NFD tests: daemon
sudo setcap cap_net_raw,cap_net_admin=eip build/unit-tests-daemon || true
build/unit-tests-daemon -l test_suite

echo Running NFD tests: rib
build/unit-tests-rib -l test_suite
