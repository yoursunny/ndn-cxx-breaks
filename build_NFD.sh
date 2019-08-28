#!/usr/bin/env bash
set -e

mkdir -p NFD
cd NFD

../checkout.sh NFD

echo Building NFD
./waf configure --debug --with-tests --without-pch
./waf -j4 || ./waf -j1

echo Running NFD tests: core
build/unit-tests-core

echo Running NFD tests: daemon
build/unit-tests-daemon

echo Running NFD tests: rib
build/unit-tests-rib

echo Running NFD tests: tools
build/unit-tests-tools
