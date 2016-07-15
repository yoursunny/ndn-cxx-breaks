#!/usr/bin/env bash
set -e

mkdir -p repos

sudo apt-get update
sudo apt-get install -qq libboost-all-dev libcrypto++-dev libsqlite3-dev pkg-config
