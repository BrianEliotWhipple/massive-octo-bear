#!/bin/sh

echo "
[gocd]
name            = GoCD YUM Repository
baseurl         = http://dl.bintray.com/gocd/gocd-rpm
enabled         = 1
gpgcheck        = 0
" > /etc/yum.repos.d/thoughtworks-go.repo

yum install -y git

# Install Oracle Java - GoCD artifact uploading fails if not using Oracle Java and server and agent
cd /opt
sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; \
  oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz"
sudo tar xvf jdk-7u80-linux-x64.tar.gz
sudo chown -R root: jdk1.7.0_80/
sudo alternatives --install /usr/bin/java java /opt/jdk1.7.0_80/bin/java 1
sudo alternatives --install /usr/bin/javac javac /opt/jdk1.7.0_80/bin/javac 1
sudo alternatives --install /usr/bin/jar jar /opt/jdk1.7.0_80/bin/jar 1
sudo sh -c "echo export JAVA_HOME=/opt/jdk1.7.0_80 >> /etc/environment"

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

# Install kubernetes cli
cd /opt
sudo wget https://github.com/kubernetes/kubernetes/releases/download/v1.1.0-alpha.1/kubernetes.tar.gz
sudo tar xvf kubernetes.tar.gz
sudo sh -c "echo export PATH=/opt/kubernetes/cluster:$PATH > /etc/profile.d/kubectl_path.sh && chmod 755 /etc/profile.d/kubectl_path.sh"
sudo mkdir -p /var/go/.kube
sudo chown go /var/go/.kube
sudo chgrp go /var/go/.kube
sudo cp /vagrant/kube.config /var/go/.kube/config
chown go /var/go/.kube/config
chgrp go /var/go/.kube/config

sudo service go-agent start
