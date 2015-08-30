#!/bin/sh

# Add the repository
sudo rpm -Uvh http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm

sudo yum -y install mesos marathon

sudo rpm -Uvh http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/cloudera-cdh-4-0.x86_64.rpm
sudo yum -y install zookeeper

sudo zookeeper-server-initialize --myid=1
sed 's/localhost/10.245.1.101/' -i /etc/mesos/zk

echo 'docker,mesos' > /etc/mesos-slave/containerizers
echo '5mins' > /etc/mesos-slave/executor_registration_timeout
echo 'ports(*):[5000-10000, 31000-32000]' > /etc/mesos-slave/resources
echo '10.245.1.101' > /etc/mesos-master/hostname
echo '10.245.1.101' > /etc/mesos-master/ip
echo '10.245.1.101' > /etc/mesos-slave/hostname

sudo mkdir -p /etc/marathon/conf
echo '10.245.1.101' > /etc/marathon/conf/hostname
sudo cp /etc/mesos/zk /etc/marathon/conf/master
sudo cp /etc/marathon/conf/master /etc/marathon/conf/zk
sed 's/mesos/marathon/' -i /etc/marathon/conf/zk

sudo zookeeper-server restart
sudo service mesos-master restart
sudo service mesos-slave restart
sudo service marathon restart

curl -sSfL http://downloads.mesosphere.io/chronos/chronos-2.1.0_mesos-0.14.0-rc4.tgz --output chronos.tgz
tar xzf chronos.tgz && cd chronos
./bin/start-chronos.bash --master zk://10.245.1.101:2181/mesos --zk_hosts zk://10.245.1.101:2181/mesos --http_port 8081 </dev/null &>/dev/null &
