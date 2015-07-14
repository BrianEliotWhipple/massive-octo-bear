#!/bin/sh

curl -sSL http://deis.io/deis-cli/install.sh | sh
sudo ln -fs $PWD/deis /usr/local/bin/deis

curl -sSL http://deis.io/deisctl/install.sh | sudo sh -s 1.8.0
sudo ln -fs $PWD/deisctl /usr/local/bin/deisctl

cp /vagrant/insecure_private_key /home/vagrant/insecure_private_key
chown vagrant /home/vagrant/insecure_private_key
chgrp vagrant /home/vagrant/insecure_private_key
chmod 0600 /home/vagrant/insecure_private_key

cp /vagrant/deis/set_deis_profile.sh /home/vagrant/set_deis_profile.sh
chown vagrant /home/vagrant/set_deis_profile.sh
chgrp vagrant /home/vagrant/set_deis_profile.sh
chmod 0755 /home/vagrant/set_deis_profile.sh

echo "
source /home/vagrant/set_deis_profile.sh
" >> /home/vagrant/.bash_profile

