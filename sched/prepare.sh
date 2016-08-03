#!/usr/bin/env bash

JOB=$1
if [[ -z $JOB ]]; then
  echo Usage: ./prepare.sh JOB
  exit 2
fi

TPLDIR=/proj/NDN-Routing/integ/template
DIR=/proj/NDN-Routing/integ/jobs/$JOB
EXP=integ$JOB

mkdir -p $DIR
cd $DIR

cp -r $TPLDIR/* ./

sed 's/JOB/'$JOB'/' $TPLDIR/integ.ns > ./integ.ns
sed 's/EXP/'$EXP'/' $TPLDIR/multi-host.conf > ./multi-host.conf
