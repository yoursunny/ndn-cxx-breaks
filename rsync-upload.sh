#!/bin/bash
DIR=$(dirname "${BASH_SOURCE[0]}")
rsync -rlpv --delete --delete-excluded \
  --exclude '.cache' --exclude '.git' --exclude 'node_modules' \
  $DIR alwaysdata:ndn-cxx-breaks
