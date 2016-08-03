#!/bin/sh
# adduser.sh newuser pw

newuser=$1
pw=$2

groupadd $newuser
useradd -g $newuser -m -d /home/${newuser} -s /bin/bash $newuser
echo "${newuser}:${pw}" | chpasswd
cp /etc/skel/.profile /home/${newuser}
cp /etc/skel/.bashrc /home/${newuser}

cp /etc/sudoers /tmp/adduser.sudoers
chmod 640 /tmp/adduser.sudoers
echo $newuser ALL=NOPASSWD:ALL >> /tmp/adduser.sudoers
chmod 640 /etc/sudoers
mv /tmp/adduser.sudoers /etc/sudoers
chmod 440 /etc/sudoers
chown root:root /etc/sudoers

