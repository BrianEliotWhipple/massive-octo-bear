#!/bin/sh

curl -sSL http://deis.io/deis-cli/install.sh | sh
sudo ln -fs $PWD/deis /usr/local/bin/deis

curl -sSL http://deis.io/deisctl/install.sh | sudo sh -s 1.6.1
sudo ln -fs $PWD/deisctl /usr/local/bin/deisctl

cp /vagrant/insecure_private_key ~
chmod 0600 ~/insecure_private_key
eval `ssh-agent -s`
ssh-add ~/insecure_private_key


