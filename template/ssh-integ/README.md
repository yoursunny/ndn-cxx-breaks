# SSH keys for integ account

This directory contains SSH keys for integ account.

1. generate an SSH key pair `id_rsa` and `id_rsa.pub`
2. copy `id_rsa.pub` to `authorized_keys`
3. append your own SSH public keys to `authorized_keys`
   so you can `ssh integ@a.EXPID.PROJ.emulab.net`
