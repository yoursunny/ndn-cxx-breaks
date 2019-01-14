#!/bin/bash
DIR=$(dirname "${BASH_SOURCE[0]}")

VERB=$1
shift

SSH_AGENT_PID=0

if [[ $VERB = 'clone' ]] || [[ $VERB = 'push' ]]; then
  eval $(ssh-agent -s)
  chmod 0600 $DIR/sshkey
  ssh-add $DIR/sshkey
fi

if [[ $VERB = 'clone' ]]; then
  EXTRA='--depth=1'
fi

git $VERB $EXTRA "$@"

if [[ $SSH_AGENT_PID -ne 0 ]]; then
  kill $SSH_AGENT_PID
fi
