#!/bin/sh

sudo echo DOCKER_OPTS=\"$DOCKER_OPTS --insecure-registry 10.0.0.0/8\" >> /etc/default/docker
