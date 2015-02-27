#!/usr/bin/env bash
set -e

BOOST_LIBS=$(cat repos/boost-libs.option)

rm -rf repos/ChronoChat
cd repos/

echo Cloning from GitHub: ChronoChat master
git clone --depth=1 --recursive git://github.com/named-data/ChronoChat
# checkout from Gerrit won't work because submodule is relative
cd ChronoChat

echo Building ChronoSync
cd ChronoSync
./waf configure $BOOST_LIBS
./waf -j4
sudo ./waf install
cd ..

echo Building ChronoChat
# ./waf configure --with-tests --debug $BOOST_LIBS
# unit tests are broken as of 20150226
./waf configure --debug $BOOST_LIBS
./waf -j4

# echo Running ChronoChat tests
# build/unit-tests -l test_suite
