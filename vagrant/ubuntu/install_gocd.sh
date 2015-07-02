#!/bin/sh


echo "deb http://dl.bintray.com/gocd/gocd-deb/ /" > /etc/apt/sources.list.d/gocd.list
wget --quiet -O - "https://bintray.com/user/downloadSubjectPublicKey?username=gocd" | sudo apt-key add -
apt-get update

apt-get install git

apt-get install -y go-server

sudo cp /vagrant/cruise-config.xml /etc/go/cruise-config.xml
chown go /etc/go/cruise-config.xml
chgrp go /etc/go/cruise-config.xml

sudo service go-server restart

apt-get install -y go-agent

echo "Setting up autoregister file"

sudo touch /var/lib/go-agent/config/autoregister.properties
sudo chown vagrant /var/lib/go-agent/config/autoregister.properties

cat <<EOL >/var/lib/go-agent/config/autoregister.properties
agent.auto.register.key=123abc123abc123abc
agent.auto.register.resources=docker
#agent.auto.register.environments=
#agent.auto.register.hostname=
EOL

sudo chown go /var/lib/go-agent/config/autoregister.properties
sudo chgrp go /var/lib/go-agent/config/autoregister.properties

sudo usermod -a -G docker go
sudo service docker restart

sudo service go-agent start
