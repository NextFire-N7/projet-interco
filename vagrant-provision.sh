#!/bin/sh
set -x

# Install tools
pacman -Sy
pacman --noconfirm -S docker docker-compose
systemctl restart docker

# Docker cleaning
docker rm -f $(docker ps -a -q)
docker system prune -f -a --volumes

# Compose up
docker compose up -d
