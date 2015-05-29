#!/bin/sh

# Setup
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
CODENAME=$(lsb_release -cs)

# Add the repository
echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | \
  sudo tee /etc/apt/sources.list.d/mesosphere.list
sudo apt-get -y update

sudo apt-get -y install mesos marathon

echo 'docker,mesos' > /etc/mesos-slave/containerizers
echo '5mins' > /etc/mesos-slave/executor_registration_timeout

sudo service zookeeper restart
sudo service mesos-master start
sudo service mesos-slave start
sudo service marathon start
