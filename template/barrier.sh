#!/usr/bin/env bash

if [[ $(hostname -s) == 'a' ]]
then
  /usr/testbed/bin/emulab-sync -i 4
else
  /usr/testbed/bin/emulab-sync
fi

