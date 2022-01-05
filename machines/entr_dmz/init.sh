#!/bin/bash
set -x

ip link set eth1 up
ip address flush dev eth1
ip address add 120.0.28.2/24 dev eth1

docker compose up -d --force-recreate --remove-orphans
