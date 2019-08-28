#!/usr/bin/env bash
set -e

mkdir -p ChronoSync
cd ChronoSync

../checkout.sh ChronoSync

echo Building ChronoSync
./waf configure --debug $([[ -z $1 ]] && echo --with-tests)
./waf -j4 || ./waf -j1

if [[ $1 == install ]]; then
  sudo ./waf install
  sudo ldconfig
  exit 0
fi

echo Running ChronoSync tests
LD_LIBRARY_PATH=build build/unit-tests -l test_suite
