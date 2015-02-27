#!/usr/bin/env bash
set -e

./deps_ChronoSync.sh
sudo apt-get install -qq qt4-dev-tools libqt4-sql-sqlite
