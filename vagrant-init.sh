#!/bin/sh
set -x

# DE install
pacman --noconfirm -R virtualbox-guest-utils-nox
pacman --noconfirm -S virtualbox-guest-utils xorg-server xorg-xinit xorg-xhost lxqt noto-fonts
systemctl enable vboxservice
echo 'KEYMAP=fr' > /etc/vconsole.conf
echo 'setxkbmap fr; exec startlxqt' > /home/vagrant/.xinitrc
echo 'if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then exec startx; fi &> /dev/null' >> /home/vagrant/.bash_profile
echo 'xhost + &> /dev/null' >> /home/vagrant/.bashrc

# Docker install
pacman --noconfirm -S docker docker-compose
systemctl enable docker
usermod -aG docker vagrant
