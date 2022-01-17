#!/bin/sh
set -x

ip r r default via 120.0.24.2
iptables -F
iptables --policy FORWARD DROP
iptables --policy INPUT DROP
iptables --policy OUTPUT DROP
iptables -t nat -p udp --dport 53 -j ACCEPT
iptables -A INPUT -m state -state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -m state -state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
iptables -t nat -p udp --dport 1194 -j ACCEPT

