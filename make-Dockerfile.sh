#!/bin/bash
if [[ -z $DEPS ]]; then
  DEPS=$(sort -u *.deps)
else
  DEPS=$(sort -u ndn-cxx.deps $PROJECT.deps)
fi

(
  echo FROM ubuntu:18.04
  echo WORKDIR /root
  echo 'RUN apt-get update && apt-get install -qq' $DEPS
  export | grep PATCHSET > patchset.env
  echo 'ADD build_*.sh checkout.sh patchset.env /root/'
  echo 'RUN ["/bin/bash", "-c", "source patchset.env; ./build_ndn-cxx.sh"]'
) | tee Dockerfile
