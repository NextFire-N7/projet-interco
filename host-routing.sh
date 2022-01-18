#!/bin/sh
set -x

# Enable IPv4 forwarding
sysctl -w net.ipv4.ip_forward=1

# https://docs.docker.com/network/iptables/#docker-on-a-router
# Docker also sets the policy for the FORWARD chain to DROP.
# If your Docker host also acts as a router,
# this will result in that router not forwarding any traffic anymore.
# If you want your system to continue functioning as a router,
# you can add explicit ACCEPT rules to the DOCKER-USER chain to allow it:
iptables -C DOCKER-USER -j ACCEPT || iptables -I DOCKER-USER -j ACCEPT

# ip routes
## add table 1 to rules
ip rule del table 1
ip rule add table 1 priority 10 # before main rule

## add routes to table 1
## use `ip route show table 1` to check it
ip route flush table 1
ip route add table 1 120.0.16.0/20 via 120.0.16.2   # AS1

## AS routes
ip address add 120.2.0.10/24 dev eth1
ip route add table 1 120.0.32.0/20 via 120.2.0.20   # AS2
ip route add table 1 120.0.48.0/20 via 120.2.0.6    # AS3
ip route add table 1 120.0.64.0/20 via 120.2.0.7    # AS4
