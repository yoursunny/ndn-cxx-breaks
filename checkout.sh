#!/usr/bin/env bash
set -eo pipefail
PROJ=$1

PROJVAR=${PROJ//-}
PROJVAR=${PROJVAR^^}
PATCHSETVAR=PATCHSET_${PROJVAR}
PATCHSET=${!PATCHSETVAR:-master}
REPO=https://gerrit.named-data.net/$PROJ

if [[ ${PATCHSET} == master ]] || [[ ${PATCHSET} == skip ]]; then
  # use default branch
  GERRIT_BRANCH=
else
  GERRIT_CHANGE=${PATCHSET%,*}
  GERRIT_BRANCH=refs/changes/$(printf '%02d' $((GERRIT_CHANGE % 100)))/${GERRIT_CHANGE}/${PATCHSET#*,}
fi

echo "Checking out $REPO ${GERRIT_BRANCH:-(default branch)}"
git init --quiet
git fetch --quiet --depth=1 "$REPO" "$GERRIT_BRANCH"
git -c advice.detachedHead=no checkout FETCH_HEAD
git submodule update --init
