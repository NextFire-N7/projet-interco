#!/bin/sh
set -x
USER=vagrant
HOME=/home/$USER

docker compose up -d --build --force-recreate -V --remove-orphans
