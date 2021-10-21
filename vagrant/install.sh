#!/bin/sh
set -x
USER=vagrant
HOME=/home/$USER

# DE install
pacman --noconfirm -R virtualbox-guest-utils-nox
pacman --noconfirm -S virtualbox-guest-utils xorg-server xorg-xinit lxqt noto-fonts
systemctl enable vboxservice
echo 'exec startlxqt' > $HOME/.xinitrc
echo 'if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then exec startx; fi' >> $HOME/.bash_profile

# Docker install
pacman --noconfirm -S docker docker-compose
systemctl enable docker
usermod -aG docker $USER
