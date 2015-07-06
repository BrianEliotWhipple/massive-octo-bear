#!/bin/sh

echo "
[gocd]
name            = GoCD YUM Repository
baseurl         = http://dl.bintray.com/gocd/gocd-rpm
enabled         = 1
gpgcheck        = 0
" > /etc/yum.repos.d/thoughtworks-go.repo

yum install -y git
yum install -y java-1.7.0-openjdk

yum install -y go-server

sudo cp /vagrant/gocd/cruise-config.xml /etc/go/cruise-config.xml
chown go /etc/go/cruise-config.xml
chgrp go /etc/go/cruise-config.xml

sudo service go-server restart

yum install -y go-agent

echo "Setting up autoregister file"

sudo mkdir -p /var/lib/go-agent/config
sudo chown go /var/lib/go-agent/config
sudo chgrp go /var/lib/go-agent/config

sudo cp /vagrant/gocd/docker-agent.autoregister.properties /var/lib/go-agent/config/autoregister.properties
sudo chown go /var/lib/go-agent/config/autoregister.properties
sudo chgrp go /var/lib/go-agent/config/autoregister.properties
sudo chmod 0644  /var/lib/go-agent/config/autoregister.properties

sudo usermod -a -G docker go
sudo service docker restart

sudo service go-agent start
