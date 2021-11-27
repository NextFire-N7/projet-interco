#!/bin/sh
set -x

ip r r default via 120.0.20.2

zebra -d
ospfd -d
