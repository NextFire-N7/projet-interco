#!/bin/sh
set -x

ip r r default via 120.0.16.2

zebra -d
ospfd -d
