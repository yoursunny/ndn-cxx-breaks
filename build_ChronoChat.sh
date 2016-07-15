#!/usr/bin/env bash
set -e

rm -rf repos/ChronoChat
cd repos/

echo Cloning from GitHub: ChronoChat master
git clone --depth=1 --recursive git://github.com/named-data/ChronoChat
# checkout from Gerrit won't work because submodule is relative
cd ChronoChat

echo Building ChronoSync
cd ChronoSync
./waf configure
./waf -j4 || ./waf -j1
sudo ./waf install
cd ..

echo Building ChronoChat
./waf configure --with-tests --debug
./waf -j4 || ./waf -j1

echo Running ChronoChat tests
build/unit-tests -l test_suite
