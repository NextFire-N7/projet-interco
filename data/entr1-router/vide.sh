#!/bin/bash
set -x
ip r r default via 120.0.24.2

# On flush tout
iptables -F
iptables -t nat -F

# On drop tout quand c'est pas dans les règles
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

# On NAT le traffic sortant
  # Traffic en arrivée du réseau local entreprise
iptables -t nat -A POSTROUTING -i 120.0.29.2 -o 120.0.24.3 -j MASQUERADE
iptables -t nat -A POSTROUTING -i 120.0.29.2 -o 120.0.28.2 -j MASQUERADE

  # Traffic en arrivée de l'extérieur
iptables -t nat -A POSTROUTING -i 120.0.24.3 -o 120.0.29.2 -j MASQUERADE
iptables -t nat -A POSTROUTING -i 120.0.24.3 -o 120.0.28.2 -j MASQUERADE

  # Traffic en arrivée du VPN ?

