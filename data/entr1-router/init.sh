#!/bin/sh
set -x

ip r r default via 120.0.24.2
iptables --policy FORWARD DROP
iptables --policy INPUT ACCEPT
iptables --policy FORWARD ACCEPT
iptables -A INPUT -s  192.168.255.0/255.255.255.0 -j ACCEPT
iptables -A INPUT -s 120.0.28.0/24 -j ACCEPT 
