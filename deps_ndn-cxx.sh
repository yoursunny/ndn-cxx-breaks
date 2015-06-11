#!/usr/bin/env bash
set -e

mkdir -p repos

if [[ $WANT_BOOST_155 -ne 0 ]]; then
  sudo apt-get install -qq python-software-properties
  sudo add-apt-repository -y ppa:boost-latest/ppa
  BOOST_PKG=libboost1.55-all-dev
  echo '--boost-libs=/usr/lib/x86_64-linux-gnu' > repos/boost-libs.option
else
  BOOST_PKG=libboost1.48-all-dev
  echo '' > repos/boost-libs.option
fi

sudo apt-get update
sudo apt-get install -qq $BOOST_PKG libcrypto++-dev libsqlite3-dev pkg-config
