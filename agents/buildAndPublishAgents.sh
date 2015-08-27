#!/bin/sh

if [ "$1" != "" ]; then
    docker_registry_url="$1"
    echo "Publishing agents into docker registry: ${docker_registry_url}"
else
    echo "Docker registry url is required."
    exit 1
fi

# Java 8 Agent
docker build -t example/gocd-agent-java-8:0.1 -f Dockerfile.gocd-agent-java-8 .
docker tag -f example/gocd-agent-java-8:0.1 ${docker_registry_url}/example/gocd-agent-java-8:0.1
docker push ${docker_registry_url}/example/gocd-agent-java-8:0.1
docker rmi example/gocd-agent-java-8:0.1
docker rmi ${docker_registry_url}/example/gocd-agent-java-8:0.1

# Ruby 2.2 Agent
docker build -t example/gocd-agent-ruby-2.2:0.1 -f Dockerfile.gocd-agent-ruby-2.2 .
docker tag -f example/gocd-agent-ruby-2.2:0.1 ${docker_registry_url}/example/gocd-agent-ruby-2.2:0.1
docker push ${docker_registry_url}/example/gocd-agent-ruby-2.2:0.1
docker rmi example/gocd-agent-ruby-2.2:0.1
docker rmi ${docker_registry_url}/example/gocd-agent-ruby-2.2:0.1
