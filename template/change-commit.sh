#!/usr/bin/env bash

PROJ=$1
INSTALLSCRIPT=$3
REPOSITORY=http://gerrit.named-data.net/$1
PATCHSET=$2

GERRIT_CHANGE=$(echo $PATCHSET | cut -d, -f1)
GERRIT_PATCHSET=$(echo $PATCHSET | cut -d, -f2)
if [[ $GERRIT_CHANGE == 'master' ]]; then
  BRANCH=master
else
  BRANCH=refs/changes/$(python -c "print('%02d' % (${GERRIT_CHANGE} % 100))")/${GERRIT_CHANGE}/${GERRIT_PATCHSET}
fi

awk '
BEGIN {
  FS = "    "
  OFS = "    "
  found = 0
}
found == 0 && $2 ~ "os\.system\(" {
  next
}
found == 0 && $2 ~ "os\.chdir\(" {
  found = 1
  print "", "os.system(\"mkdir -p '$PROJ'\")"
  print
  print "", "os.system(\"git init\")"
  print "", "os.system(\"git fetch --depth=1 '$REPOSITORY' '$BRANCH' && git checkout FETCH_HEAD\")"
  print "", "os.system(\"git submodule update --init\")"
  next
}
$2 !~ "os\.system\(\"git" {
  print
}
' $INSTALLSCRIPT > $INSTALLSCRIPT.new
mv $INSTALLSCRIPT.new $INSTALLSCRIPT
