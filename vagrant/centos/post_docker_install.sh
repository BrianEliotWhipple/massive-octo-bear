#!/bin/sh

sudo sed -i "s/# INSECURE_REGISTRY='--insecure-registry'/INSECURE_REGISTRY='--insecure-registry 172.17.8.0\/24'/g" /etc/sysconfig/docker
sudo service docker restart
