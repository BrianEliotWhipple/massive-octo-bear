#/bin/sh

nmcli connection reload
systemctl restart network.service

groupadd -f docker
