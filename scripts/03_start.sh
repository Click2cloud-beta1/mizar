#!/bin/bash

ifname=$(netstat -i | grep '^e' | awk '{print $1}' | grep -v 'lo\|eth-host')

/etc/init.d/rpcbind restart
/etc/init.d/rsyslog restart
/etc/init.d/openvswitch-switch restart
ip link set dev $ifname up mtu 9000

cp /home/ubuntu/mizar/etc/transit.service /etc/systemd/system/

sudo systemctl daemon-reload
systemctl start transit
systemctl enable transit
