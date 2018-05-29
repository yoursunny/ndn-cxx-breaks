#!/bin/bash

(
  echo FROM ubuntu:18.04
  echo WORKDIR /root
  echo 'RUN apt-get update && apt-get install -qq' $(sort -u ndn-cxx.deps $PROJECT.deps)
  export | grep PATCHSET > patchset.env
  echo 'ADD build_*.sh checkout.sh patchset.env /root/'
  echo 'RUN ["/bin/bash", "-c", "source patchset.env; ./build_ndn-cxx.sh"]'
  echo 'RUN ["/bin/bash", "-c", "source patchset.env; ./build_'$PROJECT'.sh"]'
) > Dockerfile
