#!/bin/sh

deisctl --tunnel=local3.deisapp.com config platform set sshPrivateKey=~/insecure_private_key
deisctl --tunnel=local3.deisapp.com config platform set domain=local3.deisapp.com
deisctl --tunnel=local3.deisapp.com refresh-units
deisctl --tunnel=local3.deisapp.com install platform
deisctl --tunnel=local3.deisapp.com start platform
