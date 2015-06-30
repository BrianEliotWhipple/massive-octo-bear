#!/bin/sh

sudo sed -i 's/other_args=/other_args="--insecure-registry 172.17.8.0/24"/g' /etc/sysconfig/docker
sudo service docker restart
