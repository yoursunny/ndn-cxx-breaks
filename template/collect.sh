#!/usr/bin/env bash

JOB=$1

LOGDIR=/proj/NDN-Routing/integ/results/$JOB
MYDIR=$LOGDIR/$(hostname -s)
mkdir -p $MYDIR

cd /home/integ
if [[ -f install.log ]]; then
  cp install.log $MYDIR/
fi
if [[ -f run.log ]]; then
  cp run.log $LOGDIR/
fi

cd integration-tests
tar cf - --ignore-failed-read $(git status -s -uall --porcelain --ignored | awk '$1!="D" && $2!~"\.pyc$"{print $2}') | tar xf - -C $MYDIR
