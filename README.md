# projet-interco

## Getting Started

Launching the project essentially consists in `make && docker compose up` on a Linux desktop.

A [`Vagrantfile`](./Vagrantfile) is provided to easily setup an Arch Linux VM with LXQt and Docker and mounting the project inside it with [Vagrant](https://www.vagrantup.com).

### Set up the Arch Linux VM

First install [Vagrant](https://www.vagrantup.com) and [VirtualBox](https://www.virtualbox.org) then open a terminal in the project folder and run `vagrant up`. It will setup the VM in VirtualBox, install and configure all the tools automatically. This step can take a while.

When it is done you can access the VM by SSH (`vagrant ssh`) or use the desktop with the VirtualBox window which have automatically opened up (login/password: `vagrant/vagrant`).

The project folder is mounted at `/vagrant`, modifications are synced on both host and guest.

Useful Vagrant commands:

- `up`, `destroy` to create/start and destroy the VM
- `ssh` to access guest terminal from the host
- `suspend`, `resume`
- `halt`, `reload`

Arch Linux packages are installed with `pacman -S <pkg>`, the ones installed on the setup phase are declared in [`vagrant-init.sh`](./vagrant-init.sh).

## Develop the project

The project uses [Docker](https://www.docker.com) containers to virtualize all the hosts and networks of the AS and [Docker Compose](https://docs.docker.com/compose/) to manage them.

### Define containers

Services (containers of a Compose project) and networks are all defined in the [docker-compose.yml](./docker-compose.yml) file. They use Docker images all defined in Dockerfiles in the subdirectories of [docker/](./docker/) and built with the [Makefile](./Makefile).

At start, all containers using the defined base image (or one of its subimages) will run the `/data/init.sh` script.

### Run/stop containers

`docker compose up` will update/create all containers to their latest configuration defined in the [docker-compose.yml](./docker-compose.yml)) but will not update the networks if they are already created.

To destroy all containers and networks of the project, run `docker compose down`.

You can use other `docker/docker compose` commands to manage any container individually.

### Access containers

To open a shell or execute any command one one of the container you can use `docker exec`. For example:

```console
$ cd /vagrant/
$ docker compose exec as-router sh
/data #
```

This will open a shell (`sh`) on the container associated with the `as-router` service in the [docker-compose.yml](./docker-compose.yml)).

X11 forwarding is enabled on containers with the `DISPLAY` env variable and `/tmp/.X11-unix` socket mount, so you can freely execute Wireshark, Firefox or any other graphical application inside them.

## Host routing

Run [`host-routing.sh`](./host-routing.sh) on host as root to setup forwarding and iptables to access the Docker network from the host and outside.
