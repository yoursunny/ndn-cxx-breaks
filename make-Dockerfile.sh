#!/usr/bin/env bash

if [[ -z $DEPS ]]; then
  DEPS=$(sort -u *.deps)
else
  DEPS=$(sort -u ndn-cxx.deps $PROJECT.deps)
fi

export | grep PATCHSET > patchset.env
(
  echo FROM ubuntu:18.04
  echo WORKDIR /root
  echo 'RUN apt-get update -qq && apt-get install -qy' $DEPS
  echo 'ADD build_*.sh checkout.sh patchset.env /root/'
  echo 'RUN ["/bin/bash", "-c", "source patchset.env && ./build_ndn-cxx.sh"]'
) | tee Dockerfile
