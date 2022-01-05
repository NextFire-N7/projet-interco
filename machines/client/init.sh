#!/bin/bash
set -x

ip link set eth1 up
ip address flush dev eth1

pacman --no-confirm -S dhcpcd firefox irssi
systemctl start dhcpcd@eth1