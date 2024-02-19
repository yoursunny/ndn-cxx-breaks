#!/usr/bin/env bash
set -eo pipefail

mkdir -p NFD
cd NFD

../checkout_gerrit.sh NFD

echo Building NFD
./waf configure --debug --with-tests --without-pch
./waf -j$(nproc) || ./waf -j1

echo Running NFD tests: core
build/unit-tests-core

echo Running NFD tests: daemon
build/unit-tests-daemon

echo Running NFD tests: tools
build/unit-tests-tools
