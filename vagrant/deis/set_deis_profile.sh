#!/bin/sh

if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval "$(ssh-agent -s)"
  ssh-add /home/vagrant/insecure_private_key
fi

export DEISCTL_TUNNEL=local3.deisapp.com
