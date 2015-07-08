#!/bin/sh

if [ "$1" != "" ]; then
    docker_registry_url="$1"
    echo "Publishing agents into docker registry: ${docker_registry_url}"
else
    echo "Docker registry url is required."
    exit 1
fi

full_image_name="example/java-echo:0.1"

docker tag -f ${full_image_name} ${docker_registry_url}/${full_image_name}

docker push ${docker_registry_url}/${full_image_name}

docker rmi ${full_image_name}
docker rmi ${docker_registry_url}/${full_image_name}
