#!/bin/sh
set -x

ip r r default via 120.0.20.2

touch /var/lib/dhcp/dhcpd.leases

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
