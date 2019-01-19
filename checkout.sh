#!/usr/bin/env bash
set -e

PROJ=$1
PROJVAR=$2
if [[ -z ${PROJVAR} ]]; then
  PROJVAR=${PROJ//-}
  PROJVAR=${PROJVAR^^}
fi
REPO=${3:-https://gerrit.named-data.net/$PROJ}

PATCHSETVAR=PATCHSET_${PROJVAR}
PATCHSET=${!PATCHSETVAR:-master}

if [[ ${PATCHSET} == master ]]; then
  GERRIT_BRANCH=master
else
  GERRIT_CHANGE=${PATCHSET%,*}
  GERRIT_BRANCH=refs/changes/$(printf '%02d' $((GERRIT_CHANGE % 100)))/${GERRIT_CHANGE}/${PATCHSET#*,}
fi

echo Checking out $REPO $GERRIT_BRANCH
git init --quiet
git fetch --quiet --depth=1 $REPO $GERRIT_BRANCH
git -c advice.detachedHead=no checkout FETCH_HEAD
git submodule update --init
