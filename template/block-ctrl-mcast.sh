#!/bin/bash

# block UdpMulticastFace on Emulab control NIC
CTRL_NIC=$(ip addr show to 155.98.0.0/16 | sed -n 's|.*: \(eth[0-9]\): <.*|\1|p')
CTRL_IP=$(ip addr show to 155.98.0.0/16 | sed -n 's|.*inet \([^/]*\)/.*|\1|p')

sudo iptables -I OUTPUT -o $CTRL_NIC -d 224.0.23.170 -j DROP

# EthernetFace cannot be blocked via iptables, because netfilter works on IP layer, while EthernetFace uses pcap

