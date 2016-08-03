#!/usr/bin/env bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

./ipv6.sh

#install

./barrier.sh

#run

./barrier.sh

#collect
