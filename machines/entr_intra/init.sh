#!/bin/bash
set -x

ip link set eth1 up
ip address flush dev eth1
ip address add 120.0.29.2/22 dev eth1
