# projet-interco

## Getting Started

First clone the repo: `git clone git@github.com:NextFire/projet-interco.git`

### With Vagrant

Install [Vagrant](https://www.vagrantup.com) first, then simply `vagrant up` in the cloned directory. It will automatically setup a Arch Linux VM with all the tools needed and start the Docker project inside it.

### Directly on host

Install [Docker and Docker Compose](https://www.docker.com) then `docker compose up` to setup the AS network. You are responsible of setting up the host to act as a router between the dockerized networks and the exterior (other ASNs).
