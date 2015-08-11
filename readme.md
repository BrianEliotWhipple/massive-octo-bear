# Demonstration Deployment Pipeline for Micro-Services using GoCD, Docker and Mesos

This project serves as example deployment pipeline to build, deploy and test micro-services as Docker containers in
an Apache Mesos cluster.

## Deployment Pipeline

From the project's ```/vagrant``` directory run ```vagrant up```.  This command will start three virtual machines:

* *mesos_master* Apache Mesos will be installed and the vm configured as a Mesos master node.
* *mesos_slave* Apache Mesos will be installed and the vm configured as a Mesos slave node.
* *gocd* GoCD server, a local GoCD agent, and Docker private registry will be installed on this vm.

Once all virtual machines have been started, the following applications are available:

* [GoCD Server](http://172.17.8.12:8153)
* [Apache Mesos](http://172.17.8.10:5050) Mesos should have two slave nodes: 172.17.8.10 and 172.17.8.11
* [Apache Mesos Marathon Framework](http://172.17.8.10:8080)
* [Apache Mesos Chronos Framework](http://172.17.8.10:8081)

*Note* running all three virtual machines will consume 4G physical memory per virtual machine.  If you want to reduce
the memory footprint, edit the ```/vagrant/vm-config.yml``` file and set the memory for each virtual machine.
Running the examples with less memory may introduce errors.

### Build GoCD Agents

Before the example service projects can be built and deployed, several GoCD agents will need to be built and
registered as agents.  These agents are deployed as Docker containers on the GoCD virtual machine.

Log into the [GoCD server](http://http://172.17.8.12:8153) and run the *Agent Pipeline.*  After these jobs complete,
there should be GoCD agents with labels:

  * *Java8* This agent can be used for building projects that use Java version 8.
  * *Cucumber* This agent can be used for BDD test execution.
  * *Docker* This agent is not a Docker container but deployed directly on the GoCD vm.  It can be used to build
    or publish Docker images.

### Build and Deploy Micro-Services in Mesos

Once all the GoCD agents are built and registered then the *BuildEchoService* pipeline can be executed.
The pipeline will:

1. Build the example Java Echo Service application.
2. Assemble the Echo Service into a Docker image and publish the image into the private Docker registry.
3. Deploy the service and its dependent backing service Cassandra into Mesos via a Marathon Application Group.

*TODO* Add automated tests for the Echo service pipeline.

### Docker Monitoring with cAdvisor

All three virtual machines with Docker installed can be monitored with [cAdvisor](https://github.com/google/cadvisor).
Once the virtual machines have been started, cAdvisor will be available at these URLs:

* [GoCD Server cAdvisor](172.17.8.12:9999)
* [Mesos Master cAdvisor](172.17.8.10:9999)
* [Mesos Slave cAdvisor](172.17.8.11:9999)

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

## Tool Dependencies

This project has been tested with the following tools. Using alternate versions might result in
unexpected results.

### Workstation Host Platforms

* Windows 7 (with msysGit Bash shell)
* Linux Ubuntu 15.04

### Local Virtual Machines

* Vagrant version 1.7.2
* VirtualBox version 4.3.28
 
### Java Services

* Java JDK version 8
