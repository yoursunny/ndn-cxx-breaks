#!/bin/bash

# block UDP multicast with iptables
CTRL_NIC=$(ip addr show to 155.98.0.0/16 | sed -n 's|.*: \(eth[0-9]\): <.*|\1|p')
CTRL_IP=$(ip addr show to 155.98.0.0/16 | sed -n 's|.*inet \([^/]*\)/.*|\1|p')

sudo iptables -I OUTPUT -o $CTRL_NIC -d 224.0.23.170 -j DROP

# block Ethernet multicast via NFD configuration
sudo infoedit -f /usr/local/etc/ndn/nfd.conf.sample -s face_system.ether.blacklist.subnet -v 155.98.0.0/16
sudo cp /usr/local/etc/ndn/nfd.conf.sample /usr/local/etc/ndn/nfd.conf
