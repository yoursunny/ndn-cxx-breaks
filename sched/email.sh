#!/usr/bin/env bash

JOB=$1
EMAIL=$2
if [[ -z $JOB || -z $EMAIL ]]; then
  echo Usage: ./email.sh JOB someone@example.com
  exit 2
fi
LOGFILE=/proj/NDN-Routing/integ/results/$JOB.tgz

if [[ ! -f $LOGFILE ]]; then
  echo log file is missing
  exit 1
fi

BOUNDARY=`echo $RANDOM | md5`
(
  echo 'To: '$EMAIL
  echo 'From: ndn-cxx-breaks <'$(whoami)'@ops.emulab.net>'
  echo 'Reply-To: '$(cat /proj/NDN-Routing/integ/sched/email-reply.txt)
  echo 'MIME-Version: 1.0'
  echo 'Content-Type: multipart/mixed; boundary="'$BOUNDARY'"'
  echo 'Subject: ndn-cxx-breaks integration-tests '$JOB
  echo ''
  echo '--'$BOUNDARY
  echo 'Content-Type: text/plain; charset="us-ascii"'
  echo ''
  tar xzf $LOGFILE -O job.conf
  echo ''
  echo ''
  tar xzf $LOGFILE -O run.log
  echo ''
  echo ''
  echo '--'
  sort --sort=random /proj/NDN-Routing/integ/sched/fortune.txt | head -1
  echo ''
  echo '--'$BOUNDARY
  echo 'Content-Type: application/x-gtar; name="'$JOB'.tgz"'
  echo 'Content-Transfer-Encoding: base64'
  echo ''
  openssl base64 < $LOGFILE
) | sendmail -t -i
