#!/usr/bin/env bash

PATCHSET=$1
if [[ -z $PATCHSET || $PATCHSET == 'master' ]]; then
  BRANCH=master
else
  GERRIT_CHANGE=$(echo $PATCHSET | cut -d, -f1)
  GERRIT_PATCHSET=$(echo $PATCHSET | cut -d, -f2)
  BRANCH=refs/changes/$(python -c "print('%02d' % (${GERRIT_CHANGE} % 100))")/${GERRIT_CHANGE}/${GERRIT_PATCHSET}
fi

cd $HOME

mkdir integration-tests
cd integration-tests
git init

# anonymous HTTP checkout

git fetch http://gerrit.named-data.net/NFD/integration-tests $BRANCH && git checkout FETCH_HEAD

cp ../multi-host.conf ./

