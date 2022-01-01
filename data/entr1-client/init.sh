#!/bin/sh
set -x

ip r r default via 120.0.29.2
echo 'nameserver 120.0.28.10' > /etc/resolv.conf
