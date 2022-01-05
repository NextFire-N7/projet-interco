#!/bin/bash
set -x

ip link set eth1 up
ip address flush dev eth1
ip address add 120.0.16.3/20 dev eth1

ip link set eth2 up
ip address flush dev eth2
ip address add 120.0.24.1/22 dev eth2

docker compose up -d --force-recreate --remove-orphans
