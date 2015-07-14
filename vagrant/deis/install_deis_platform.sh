#!/bin/sh

deisctl config platform set sshPrivateKey=~/insecure_private_key
deisctl config platform set domain=local3.deisapp.com
deisctl refresh-units
deisctl install platform
deisctl start platform

