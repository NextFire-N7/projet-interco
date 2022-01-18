#!/bin/bash
set -x
ip r r default via 120.0.24.2

# On flush tout
iptables -F
iptables -t nat -F

# On drop tout quand c'est pas dans les règles
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# On NAT le traffic sortant
  # Traffic en arrivée du réseau local entreprise
iptables -t nat -A POSTROUTING -i 120.0.29.2 -o 120.0.24.3 -j MASQUERADE
iptables -t nat -A POSTROUTING -i 120.0.29.2 -o 120.0.28.2 -j MASQUERADE

  # Traffic en arrivée de l'extérieur
iptables -t nat -A POSTROUTING -i 120.0.24.3 -o 120.0.29.2 -j MASQUERADE
iptables -t nat -A POSTROUTING -i 120.0.24.3 -o 120.0.28.2 -j MASQUERADE

  # Traffic DNS
iptables -A FORWARD -i 120.0.24.3 -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -i 120.0.28.2 -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -i 120.0.29.2 -p udp --dport 53 -j ACCEPT

  # Drop les pings en arrivée en INPUT sur le pare-feu
iptables -A INPUT -p icmp --icmp-type 8 -j DROP

###############################################################################

# Allow unlimited traffic on loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow HTTP outbound
iptables -A OUTPUT -p tcp --dport 80 -m state --state NEW -j ACCEPT

# Allow HTTPS outbound
iptables -A OUTPUT -p tcp --dport 443 -m state --state NEW -j ACCEPT


# Allow TUN interface connections to OpenVPN server
iptables -A INPUT -i tun0 -j ACCEPT

# Allow TUN interface connections to be forwarded through other interfaces
iptables -A FORWARD -i tun0 -j ACCEPT
iptables -A OUTPUT -o tun0 -j ACCEPT
iptables -A FORWARD -i tun0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0 -o tun+ -m state --state RELATED,ESTABLISHED -j ACCEPT

# Allow outbound access to all networks on the Internet from the VPN
iptables -A FORWARD -i tun0 -s 120.0.20.0/22 -d 0.0.0.0/0 -j ACCEPT

