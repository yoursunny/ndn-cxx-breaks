#!/usr/bin/env bash
# run tests (host A only)

cd $HOME
export PYTHONUNBUFFERED=1

cd integration-tests

./run_tests.py test_all &> ../run.log

