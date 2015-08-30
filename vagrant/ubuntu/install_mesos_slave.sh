#!/bin/sh

# Setup
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
CODENAME=$(lsb_release -cs)

# Add the repository
echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | \
  sudo tee /etc/apt/sources.list.d/mesosphere.list
sudo apt-get -y update

sudo apt-get -y install mesos

sudo service zookeeper stop
sudo sh -c "echo manual > /etc/init/zookeeper.override"

sudo service mesos-master stop
sudo sh -c "echo manual > /etc/init/mesos-master.override"

echo 'docker,mesos' > /etc/mesos-slave/containerizers
echo '5mins' > /etc/mesos-slave/executor_registration_timeout
echo 'ports(*):[5000-10000, 31000-32000]' > /etc/mesos-slave/resources
echo '10.245.1.102' > /etc/mesos-slave/hostname
echo '10.245.1.102' > /etc/mesos-slave/ip

sed 's/localhost/10.245.1.101/' -i /etc/mesos/zk

sudo service mesos-slave restart
