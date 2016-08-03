#!/usr/bin/env bash
# run IGMP querier (host B only)

IGMPPROXY=$(pwd)/igmpproxy
source ./multi-host.conf

sudo ip tap add dev tapIGMP mode tap
sudo ip addr add 10.4.73.145 dev tapIGMP

NIC_B1=$(ip addr show to $IP4_B1 | grep qdisc | cut -d: -f2 | cut -c2-)
NIC_ALL=$(ip addr | grep qdisc | cut -d: -f2 | cut -c2-)

> igmpproxy.conf
echo phyint tapIGMP upstream ratelimit 0 threshold 1 >> igmpproxy.conf
echo phyint $NIC_B1 downstream ratelimit 0 threshold 1 >> igmpproxy.conf
for NIC in $NIC_ALL
do
  if [[ $NIC != 'tapIGMP' ]] && [[ $NIC != $NIC_B1 ]]
  then
    echo phyint $NIC disabled >> igmpproxy.conf
  fi
done

sudo $IGMPPROXY -v igmpproxy.conf &

