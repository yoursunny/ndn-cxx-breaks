#!/usr/bin/env bash

cd $HOME
export PYTHONUNBUFFERED=1

cd integration-tests
./install_apps.py install_all &> ../install.log

