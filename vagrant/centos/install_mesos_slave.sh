#!/bin/sh

# Add the repository
sudo rpm -Uvh http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm

sudo yum -y install mesos

echo 'docker,mesos' > /etc/mesos-slave/containerizers
echo '5mins' > /etc/mesos-slave/executor_registration_timeout
echo 'ports(*):[5000-10000, 31000-32000]' > /etc/mesos-slave/resources
echo '10.245.1.102' > /etc/mesos-slave/hostname
echo '10.245.1.102' > /etc/mesos-slave/ip

sed 's/localhost/10.245.1.101/' -i /etc/mesos/zk

sudo systemctl stop mesos-master.service
sudo systemctl disable mesos-master.service

sudo service mesos-slave restart
