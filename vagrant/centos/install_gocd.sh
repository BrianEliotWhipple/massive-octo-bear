#!/bin/sh

echo "
[gocd]
name            = GoCD YUM Repository
baseurl         = http://dl.bintray.com/gocd/gocd-rpm
enabled         = 1
gpgcheck        = 0
" > /etc/yum.repos.d/thoughtworks-go.repo

yum install -y java-1.7.0-openjdk
yum install -y go-server
yum install -y go-agent
