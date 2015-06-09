#!/bin/sh

# Add the repository
sudo rpm -Uvh http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm

sudo yum -y install mesos marathon

sudo rpm -Uvh http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/cloudera-cdh-4-0.x86_64.rpm
sudo yum -y install zookeeper

sudo zookeeper-server-initialize --myid=1

echo 'docker,mesos' > /etc/mesos-slave/containerizers
echo '5mins' > /etc/mesos-slave/executor_registration_timeout
echo 'ports(*):[5000-10000, 31000-32000]' > /etc/mesos-slave/resources
echo '192.168.12.100' > /etc/mesos-slave/hostname

sudo zookeeper-server start
sudo service mesos-master start
sudo service mesos-slave start
sudo service marathon start

curl -sSfL http://downloads.mesosphere.io/chronos/chronos-2.1.0_mesos-0.14.0-rc4.tgz --output chronos.tgz
tar xzf chronos.tgz && cd chronos
./bin/start-chronos.bash --master zk://localhost:2181/mesos --zk_hosts zk://localhost:2181/mesos --http_port 8081 </dev/null &>/dev/null &
