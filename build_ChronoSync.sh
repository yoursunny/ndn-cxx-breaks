#!/usr/bin/env bash
set -e

mkdir -p ChronoSync
cd ChronoSync

../checkout.sh ChronoSync

echo Building ChronoSync
./waf configure --with-tests --debug
./waf -j4 || ./waf -j1

if [[ -n DEP_CHRONOSYNC ]]; then
  sudo ./waf install
  sudo ldconfig
  exit 0
fi

echo Running ChronoSync tests
LD_LIBRARY_PATH=build build/unit-tests -l test_suite
