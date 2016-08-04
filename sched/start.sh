#!/usr/bin/env bash

JOB=$1
if [[ -z $JOB ]]; then
  echo Usage: ./start.sh JOB
  exit 2
fi

BATCH=true
if [[ $NO_BATCH -eq 1 ]]; then
  BATCH=false
fi

DIR=/proj/NDN-Routing/integ/jobs/$JOB
LOGDIR=/proj/NDN-Routing/integ/results/$JOB
EXP=integ$JOB

if [[ ! -f $DIR/job.conf ]]; then
  echo job.conf is missing
  exit 1
fi

cd $DIR
source job.conf
mkdir -p $LOGDIR

function run_exp {

/usr/testbed/bin/sslxmlrpc_client.py startexp proj=NDN-Routing exp=$EXP nsfilepath=$DIR/integ.ns batch=$BATCH description=NFD-integration-tests-$JOB idleswap=60 max_duration=240 wait=true
sleep 5
for WAIT in $(seq 24); do
  sleep 60
  if [[ $(/usr/testbed/bin/sslxmlrpc_client.py statewait proj=NDN-Routing exp=$EXP state=swapped timeout=600) == swapped ]]; then break; fi
done
sleep 5
/usr/testbed/bin/sslxmlrpc_client.py endexp proj=NDN-Routing exp=$EXP wait=true
sleep 5
cd $LOGDIR
cp $DIR/job.conf ./
tar czf ../$JOB.tgz *
cd "$( dirname "${BASH_SOURCE[0]}" )"
rm -rf $LOGDIR

if [[ -n $EMAIL ]]; then
  ./email.sh $JOB "$EMAIL"
fi

}

run_exp &>$LOGDIR/runexp.log &
