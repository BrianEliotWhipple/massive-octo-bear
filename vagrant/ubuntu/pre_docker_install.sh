#!/bin/sh

sudo echo DOCKER_OPTS=\"$DOCKER_OPTS --insecure-registry 172.17.8.0/24\" >> /etc/default/docker
