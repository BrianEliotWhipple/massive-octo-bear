# Demonstration Project for Deploying Micro-services in Docker

This project serves as example to build, deploy and test micro-services as Docker containers.
Also used to trial Mesos/Marathon for use as a cluster manager.

## Docker Environments

Vagrant is used to deploy Docker locally.  The project contains Vagrantfiles to deploy Docker
on Ubuntu, CentOS and CoreOS.

Run ```vagrant up``` under ```/vagrant/${platform}``` directories to deploy Docker.

### Installed Docker Images

The Vagrant boxes will install the following images using the Vagrant Docker provisioner:

* registry:0.9.1 - Docker registry
* google/cadvisor:latest - Google container monitoring tool
* debian:jessie - Base Debian image
* java:8 - Base Java image, can switch to Java 7
* cassandra:2.1 - Base Cassandra image, can switch to 2.0

Optionally, the Vagrant Docker provisioner will also run the Cassandra image,
name it *cassandra-1* and expose the CQL port 9042 on the local host.

Each of the different host OS virtual machines use a different private network:

 * CoreOS Vagrant box uses *192.168.10.100*
 * CentosOS and Ubuntu Vagrant boxes uses *192.168.12.100*

## Service Projects

Example micro-service projects can be found under ```/service/${language}``` directory.

### Java Echo Service

The Java Echo service found under ```/service/java/echo``` is a simple REST service that can
echo and log (persist to Cassandra) service requests.  The service uses the following tools:

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
* ```curl localhost:8080/echo``` should return a json response from the service

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

Use the following commands to build and run the Echo service as a Docker container:

* cd to ```/vagrant/centos``` or ```/vagrant/ubuntu```
* run ```vagrant up``` to start the Docker virtual machine.
* run ```vagrant ssh``` to log into the Docker virtual machine.
* cd to ```/services/java/echo```
* run ```docker_build.sh```
* ```sudo docker images``` should now list a ```/example/java-echo``` image with a 0.1 tag
* run ```docker_run.sh```
* ```sudo docker ps``` should list both the cassandra-1 and example-java-echo containers
* ```curl localhost:8080/echo``` should return json response from the service
* ```sudo docker logs example-java-echo``` will list the Echo service application log

#### Pushing and Pulling Images With Private Registry

A local private registry can be started on either the Ubuntu or CentOS Vagrant box with the
following command:

* ```sudo docker run -d --name=docker-registry -p 5000:5000 registry:0.9.1```

Note:  In order for Docker to support a private registry with HTTPS and valid certificate, the
Vagrant configuration will add ```--insecure-registry 192.168.0.0/16``` to the Docker daemon
startup configuration files.  This will enable http registry access for all registries on the
Vagrant private networks.

Once the private Docker registry is running, the service image can be published to the registry
with the following commands (first build the service as described above):

* ```sudo docker images``` and find the image id of the example/java-echo image.
* ```sudo docker tag ${example java echo image id}
  ${ip address of private registry host}:5000/example-java-echo``` 
* ```sudo docker push ${ip address of private registry host}:5000/example-java-echo```

Now other Docker hosts can pull the example/java-echo image with:

* ```sudo docker pull ${ip address of private registry host}:5000/example-java-echo```

And the service can be run (assuming that the Cassandra container is running):

* ```sudo docker run -d --name example-java-echo -p 8080:8080 -p 8081:8081 --link cassandra-1:cassandra \
           -e CASSANDRA_SEED_HOST=cassandra  ${ip address of private registry host}:5000/example-java-echo``` 

### Running Services With Mesos/Marathon

The Vagrantfile for both Centos and Ubuntu will install Mesos and Marathon on the Vagrant box.
Once the vagrant box is running, Casandara and the Java Echo service can be run by:

* ```cd /vagrant/ubuntu/mesos```
* ```./create_apps.sh```

After the Marathon apps have been created you can use the Echo service:

* ```curl localhost:30000/echo```

The port 30000 is used since Marathon is already using the port 8080.

## Tool Dependencies

This project has been tested with the following tools. Using alternate versions might result in
unexpected results.

### Workstation Host Platforms

* Windows 7 (with msysGit Git Bash shell)

### Local Virtual Machines

* Vagrant version 1.7.2
* VirtualBox version 4.3.28
 
### Java Services

* Java JDK version 8
