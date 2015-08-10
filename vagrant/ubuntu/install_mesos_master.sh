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

sed 's/localhost/172.17.8.10/' -i /etc/mesos/zk

echo 'docker,mesos' > /etc/mesos-slave/containerizers
echo '5mins' > /etc/mesos-slave/executor_registration_timeout
echo 'ports(*):[5000-10000, 31000-32000]' > /etc/mesos-slave/resources
echo '172.17.8.10' > /etc/mesos-master/hostname
echo '172.17.8.10' > /etc/mesos-master/ip
echo '172.17.8.10' > /etc/mesos-slave/hostname

sudo mkdir -p /etc/marathon/conf
echo '172.17.8.10' > /etc/marathon/conf/hostname
sudo cp /etc/mesos/zk /etc/marathon/conf/master
sudo cp /etc/marathon/conf/master /etc/marathon/conf/zk
sed 's/mesos/marathon/' -i /etc/marathon/conf/zk

sudo service zookeeper restart
sudo service mesos-master start
sudo service mesos-slave start
sudo service marathon start

curl -sSfL http://downloads.mesosphere.io/chronos/chronos-2.1.0_mesos-0.14.0-rc4.tgz --output chronos.tgz
tar xzf chronos.tgz && cd chronos
./bin/start-chronos.bash --master zk://172.17.8.10:2181/mesos --zk_hosts zk://172.17.8.10:2181/mesos --http_port 8081  &>/dev/null &

