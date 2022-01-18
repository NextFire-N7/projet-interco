#!/bin/sh
set -x

ip r r default via 120.0.24.2
#!/bin/bash
# Flushing all rules
iptables -F FORWARD
iptables -F INPUT
iptables -F OUTPUT
iptables -X
# Setting default filter policy
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
# Allow unlimited traffic on loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
# Accept inbound TCP packets
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# Allow incoming SSH
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -s 0.0.0.0/0 -j ACCEPT
# Allow incoming OpenVPN
iptables -A INPUT -p udp --dport 1194 -m state --state NEW -s 0.0.0.0/0 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -m state --state NEW -s 0.0.0.0/0 -j ACCEPT
# Accept outbound packets
iptables -I OUTPUT 1 -m state --state RELATED,ESTABLISHED -j ACCEPT
# Allow DNS outbound
iptables -A OUTPUT -p udp --dport 53 -m state --state NEW -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -m state --state NEW -j ACCEPT
# Allow HTTP outbound
iptables -A OUTPUT -p tcp --dport 80 -m state --state NEW -j ACCEPT
# Allow HTTPS outbound
iptables -A OUTPUT -p tcp --dport 443 -m state --state NEW -j ACCEPT
# Enable NAT for the VPN
iptables -t nat -A POSTROUTING -s 120.0.20.0/22 -o eth0 -j MASQUERADE
# Allow TUN interface connections to OpenVPN server
iptables -A INPUT -i tun0 -j ACCEPT
# Allow TUN interface connections to be forwarded through other interfaces
iptables -A FORWARD -i tun0 -j ACCEPT
iptables -A OUTPUT -o tun0 -j ACCEPT
iptables -A FORWARD -i tun0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0 -o tun+ -m state --state RELATED,ESTABLISHED -j ACCEPT
# Allow outbound access to all networks on the Internet from the VPN
iptables -A FORWARD -i tun0 -s 120.0.20.0/22 -d 0.0.0.0/0 -j ACCEPT
















