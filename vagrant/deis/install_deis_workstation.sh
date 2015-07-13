#!/bin/sh

curl -sSL http://deis.io/deis-cli/install.sh | sh
sudo ln -fs $PWD/deis /usr/local/bin/deis

curl -sSL http://deis.io/deisctl/install.sh | sudo sh -s 1.7.3
sudo ln -fs $PWD/deisctl /usr/local/bin/deisctl

cp /vagrant/insecure_private_key /home/vagrant/insecure_private_key
chown vagrant /home/vagrant/insecure_private_key
chgrp vagrant /home/vagrant/insecure_private_key
chmod 0600 /home/vagrant/insecure_private_key


