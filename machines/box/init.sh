#!/bin/bash
set -x

ip link set eth1 up
ip address flush dev eth1
ip address add 120.0.20.2/22 dev eth1

ip link set eth2 up
ip address flush dev eth2
ip address add 192.168.0.1/24 dev eth2

docker-compose up -d --force-recreate --remove-orphans
