#!/usr/bin/env bash
set -e

PROJVAR=$1
PROJ=$2
REPO=${3:-https://gerrit.named-data.net/$PROJ}

PATCHSETVAR=PATCHSET_${PROJVAR}
PATCHSET=${!PATCHSETVAR:-master}

GERRIT_CHANGE=${PATCHSET%,*}
if [[ ${GERRIT_CHANGE} == master ]]; then
  GERRIT_BRANCH=master
else
  GERRIT_BRANCH=refs/changes/$(printf '%02d' $((GERRIT_CHANGE % 100)))/${GERRIT_CHANGE}/${PATCHSET#*,}
fi

echo Checking out $REPO $GERRIT_BRANCH
git init --quiet
git fetch --quiet --depth=1 $REPO $GERRIT_BRANCH
git -c advice.detachedHead=no checkout FETCH_HEAD
git submodule update --init
