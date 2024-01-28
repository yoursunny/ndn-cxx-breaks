#!/usr/bin/env bash
set -eo pipefail

PROJ=$1
PROJVAR=${PROJ//-/}
PROJVAR=${PROJVAR^^}
PATCHSETVAR=PATCHSET_${PROJVAR}
PATCHSET=${!PATCHSETVAR:-master}
if [[ ${PROJ} != */* ]]; then
  PROJ=named-data/${PROJ}
fi
REPO=https://github.com/${PROJ}.git

if [[ ${PATCHSET} == master ]] || [[ ${PATCHSET} == skip ]]; then
  # use default branch
  BRANCH=
else
  BRANCH=pull/${PATCHSET}/head
fi

echo "Checking out $REPO ${BRANCH:-(default branch)}"
git init --quiet
git fetch --quiet --depth=1 "$REPO" "$BRANCH"
git switch --detach FETCH_HEAD
git submodule --quiet update --init
