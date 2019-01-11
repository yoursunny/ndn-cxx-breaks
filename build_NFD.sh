#!/usr/bin/env bash
set -e

mkdir -p NFD
cd NFD

../checkout.sh NFD NFD

echo Building NFD
./waf configure --debug --with-tests --without-pch
./waf -j4 || ./waf -j1

echo Running NFD tests: core
build/unit-tests-core -l test_suite

echo Running NFD tests: daemon
sudo setcap cap_net_raw,cap_net_admin=eip build/unit-tests-daemon || true
build/unit-tests-daemon -l test_suite

echo Running NFD tests: rib
build/unit-tests-rib -l test_suite
