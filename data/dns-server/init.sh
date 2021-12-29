#!/bin/bash
# Debug : affiche commandes dans le terminal
set -x

# On lui donne une adresse IP dans la DMZ
ip flush dev eth0
ip link set eth0 down
ip addr add 120.0.16.21 dev eth0
ip link set eth0 up

# On lance le serveur
rc-update add unbound
rc-service unbound start
