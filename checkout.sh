#!/usr/bin/env bash
set -e
PROJVAR=$1
PROJ=$2
REPO=${3:-http://gerrit.named-data.net/$PROJ}

PATCHSETVAR=PATCHSET_${PROJVAR}
PATCHSET=${!PATCHSETVAR:-master}

GERRIT_CHANGE=$(echo $PATCHSET | cut -d, -f1)
GERRIT_PATCHSET=$(echo $PATCHSET | cut -d, -f2)
if [[ $GERRIT_CHANGE == 'master' ]]; then
  GERRIT_BRANCH=master
else
  GERRIT_BRANCH=refs/changes/$(python -c "print('%02d' % (${GERRIT_CHANGE} % 100))")/${GERRIT_CHANGE}/${GERRIT_PATCHSET}
fi

echo Checking out $REPO $GERRIT_BRANCH
git init
git fetch --depth=1 $REPO $GERRIT_BRANCH && git checkout FETCH_HEAD
git submodule update --init
