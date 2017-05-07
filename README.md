# ndn-cxx-breaks webapp

## Installation

1. `ssh-keygen -t ecdsa -N '' -C 'ndn-cxx-breaks_deploy' -f sshkey`, add public key as a deploy key on GitHub and grant write access
2. `composer install`
3. `brunch build --production`
4. On server: `ssh -oStrictHostKeyChecking=no git@github.com`
