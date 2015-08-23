#!/bin/sh

if [ "$1" != "" ]; then
    go_server_host="$1"
    echo "Running Go agents for Go server at: ${go_server_host}"
else
    echo "Go server host is required."
    exit 1
fi

if [ "$2" != "" ]; then
    docker_registry_url="$2"
    echo "Pulling docker images from: ${docker_registry_url}"
else
    echo "Docker registry url is required."
    exit 1
fi

docker run -d -e GO_SERVER=${go_server_host} --name gocd-agent-java-8 ${docker_registry_url}/example/gocd-agent-java-8:0.1
docker run -d -e GO_SERVER=${go_server_host} --name gocd-agent-ruby ${docker_registry_url}/example/gocd-agent-ruby:0.1
