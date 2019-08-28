#!/usr/bin/env bash
set -e

mkdir -p repo-ng
cd repo-ng

../checkout.sh repo-ng

echo Building repo-ng
./waf configure --with-tests --with-examples --debug
./waf -j4 || ./waf -j1

echo Running repo-ng tests
build/unit-tests
