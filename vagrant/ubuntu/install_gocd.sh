#!/bin/sh


echo "deb http://dl.bintray.com/gocd/gocd-deb/ /" > /etc/apt/sources.list.d/gocd.list
wget --quiet -O - "https://bintray.com/user/downloadSubjectPublicKey?username=gocd" | sudo apt-key add -
apt-get update

apt-get install git

apt-get install -y go-server

sudo cp /vagrant/gocd/cruise-config.xml /etc/go/cruise-config.xml
chown go /etc/go/cruise-config.xml
chgrp go /etc/go/cruise-config.xml

sudo service go-server restart

apt-get install -y go-agent

echo "Setting up autoregister file"

sudo cp /vagrant/gocd/docker-agent.autoregister.properties /var/lib/go-agent/config/autoregister.properties
sudo chown go /var/lib/go-agent/config/autoregister.properties
sudo chgrp go /var/lib/go-agent/config/autoregister.properties

sudo usermod -a -G docker go
sudo service docker restart

sudo service go-agent start
