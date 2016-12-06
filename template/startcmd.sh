#!/usr/bin/env bash

cd "$( dirname "${BASH_SOURCE[0]}" )"
source job.conf

./ipv6.sh

sudo ./adduser.sh integ $RANDOM
sudo mkdir /home/integ/.ssh
sudo chown $(whoami) /home/integ/.ssh
cp ssh-integ/* /home/integ/.ssh/
sudo chown integ:integ /home/integ/.ssh /home/integ/.ssh/*

sudo cp -t /home/integ/ clone.sh change-commit.sh install.sh run.sh multi-host.conf
HOME=/home/integ sudo -u integ /home/integ/clone.sh $PATCHSET_INTEG

if [[ $PATCHSET_NDNCXX != 'master' ]]; then
  sudo -u integ /home/integ/change-commit.sh ndn-cxx $PATCHSET_NDNCXX /home/integ/integration-tests/install_helpers/install_ndncxx.py
fi
if [[ $PATCHSET_NFD != 'master' ]]; then
  sudo -u integ /home/integ/change-commit.sh NFD $PATCHSET_NFD /home/integ/integration-tests/install_helpers/install_NFD.py
fi
if [[ $PATCHSET_NDNTOOLS != 'master' ]]; then
  sudo -u integ /home/integ/change-commit.sh ndn-tools $PATCHSET_NDNTOOLS /home/integ/integration-tests/install_helpers/install_ndntools.py
fi
if [[ $PATCHSET_TRAFFICGEN != 'master' ]]; then
  sudo -u integ /home/integ/change-commit.sh ndn-traffic-generator $PATCHSET_TRAFFICGEN /home/integ/integration-tests/install_helpers/install_ndntraffic.py
fi

HOME=/home/integ sudo -u integ /home/integ/install.sh

if [[ $(hostname -s) == 'b' ]]; then
  ./igmp.sh
fi

./block-ctrl-mcast.sh

./barrier.sh

if [[ $(hostname -s) == 'a' ]]; then
  HOME=/home/integ sudo -u integ /home/integ/run.sh
fi

./barrier.sh

./collect.sh $JOB
