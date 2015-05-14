# Demonstration Project for Deploying Micro-services in Docker

This project serves as example to build, deploy and test micro-services as Docker containers.

## Docker Environments

Vagrant is used to deploy Docker locally.  The project contains Vagrantfiles to deploy Docker
on Ubuntu, CentOS and CoreOS.

Run ```vagrant up``` under ```/vagrant/${platform}``` directories to deploy Docker.

### Installed Docker Images

The Vagrant boxes will install the following images using the Vagrant Docker provisioner:

* registry:2.0 - Docker registry
* google/cadvisor:latest - Google container monitoring tool
* debian:jessie - Base Debian image
* java:8 - Base Java image, can switch to Java 7
* cassandra:2.1 - Base Cassandra image, can switch to 2.1

The Vagrant Docker provisioner will also run the Cassandra image, name it *cassandra-1* and
expose the CQL port 9042 on the local host.

Each of the different host OS virtual machines use a different private network:

 * CoreOS Vagrant box uses *192.168.10.100*
 * CentosOS Vagrant box uses *192.168.11.100*
 * Ubuntu Vagrant box uses *192.168.12.100* 

## Service Projects

Example micro-service projects can be found under ```/service/${language}``` directory.

### Java Echo Service

The Java Echo service found under ```/service/java/echo``` is a simple REST service that can
echo and log (persist) service requests.  The service uses the following tools:

* Dropwizard REST service framework: http://www.dropwizard.io/
* Google Dagger 2.0 Dependency Injection: http://google.github.io/dagger/
* Apache Cassandra Database: http://cassandra.apache.org/
* Gradle Build tool: https://gradle.org/  

To build the service:

* cd to ```/service/java/echo```
* run ```./gradlew shadowJar```

This will assemble an all inclusive shadow jar under ```/service/java/echo/build/libs```.

#### Running Service Outside of Docker
 
The service can be run locally if a Cassandra database is available.  You will need the hostname or
IP address of a Cassandra host in the Cassandra cluster.  This hostname or IP address will be
injected into the service configuration via the CASSANDRA_SEED_HOST environment variable.

* cd to ```/service/java/echo```
* Run ```export CASSANDRA_SEED_HOSTS=${your cassandra seed host or ip address}```
* Run ```java -jar ./build/libs/echo-0.1-all.jar server echo-service.yml```  

If you have started one of the Vagrant Docker boxes described above, by default they will run and
expose Cassandra CQL port and its private network IP address can be used as the CASSANDRA_SEED_HOST.

#### Building and Running Service as Docker Container

Running the service as a Docker container requires the service is built as Docker container and run
so that it can connect to the Cassandra database.

Both the CentOS and Ubuntu Vagrant boxes mount the ```/services``` directory as a shared drive and
the ```/services/java/echo/docker_build.sh``` can be used to build a Docker images for the Echo
service.

The script ```/services/java/echo/docker_run.sh``` can be used to run the Echo service.  The run
script requires that Cassandra is running as a Docker container named ```cassandra-1```.

TODO docker push echo image to private registry
TODO docker pull from private registry - for CoreOS

## Tool Dependencies

This project has been tested with the following tools. Using alternate version might result in
unexpected results.

### Workstation Host Platforms

* Windows 7

### Local Virtual Machines

* Vagrant version 1.6.3
* VirtualBox version 4.3.20
 
### Java Services

* Java JDK version 8

