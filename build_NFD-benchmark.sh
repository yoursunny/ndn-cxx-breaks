#!/usr/bin/env bash
set -e

mkdir -p repos/NFD
cd repos/NFD

../../checkout.sh NFD NFD

echo Building NFD
./waf configure --with-tests --with-other-tests --without-pch
./waf -j4 || ./waf -j1

echo Running CS benchmark
build/cs-benchmark -l test_suite

echo Running PIT-FIB benchmark
build/pit-fib-benchmark -l test_suite
