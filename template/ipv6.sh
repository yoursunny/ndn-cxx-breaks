#!/usr/bin/env bash

source ./multi-host.conf
IP6PREFIXLEN=64

for NIC in A1 B1 C1 A2 R1 R2 D1
do
  IP4VAR='IP4_'$NIC
  L1=$(ip addr show to ${!IP4VAR} | grep state)
  if [[ -n $L1 ]]
  then
    IFNAME=$(echo $L1 | cut -d' ' -f2 | sed -e 's/://')
    IP6VAR='IP6_'$NIC
    sudo ip addr add ${!IP6VAR}/$IP6PREFIXLEN dev $IFNAME
  fi
done

for ROUTER in r
do
  if [[ $(hostname -s) == $ROUTER ]]
  then
    echo 1 | sudo tee /proc/sys/net/ipv6/conf/all/forwarding >/dev/null
  fi
done

if [[ $(hostname -s) == 'a' ]]
then
  sudo ip -6 route add $IP6_D1/$IP6PREFIXLEN via $IP6_R1
fi

if [[ $(hostname -s) == 'd' ]]
then
  sudo ip -6 route add $IP6_A2/$IP6PREFIXLEN via $IP6_R2
fi

