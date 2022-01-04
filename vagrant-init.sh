#!/bin/sh
set -x

# Update
pacman --noconfirm -Sy archlinux-keyring && pacman --noconfirm -Su

# Desktop environment
pacman --noconfirm -R virtualbox-guest-utils-nox
pacman --noconfirm -S virtualbox-guest-utils xorg-server xorg-xinit xorg-xhost lxqt noto-fonts oxygen-icons
systemctl enable vboxservice
echo 'KEYMAP=fr' > /etc/vconsole.conf
echo 'setxkbmap fr; exec startlxqt' > /home/vagrant/.xinitrc

# Docker
pacman --noconfirm -S docker docker-compose
systemctl enable docker
usermod -aG docker vagrant

# Other tools
pacman --noconfirm -S wireshark-qt
