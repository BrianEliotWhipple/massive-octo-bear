#!/bin/sh

sudo sed -i "s/# INSECURE_REGISTRY='--insecure-registry'/INSECURE_REGISTRY='--insecure-registry 10.0.0.0\/8'/g" /etc/sysconfig/docker
sudo service docker restart
