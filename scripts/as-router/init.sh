#!/bin/sh
set -x
ip r r default via 120.0.16.1 # (this one should already be set)
ip r a 120.0.20.0/22 via 120.0.16.4
ip r a 120.0.24.0/21 via 120.0.16.3
