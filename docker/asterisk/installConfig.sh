#!/bin/bash
# Vérification si on est bien connecté avec root
if [ "$(id -u)" != "0"]; then
  echo "Comme on doit installer des paquets nécessaires pour Asterisk, le script doit être utilisé en tant que root." 1>&2
  exit 1
fi

# Vérification niveau utilisateur si on est bien sûr de ce qu'on veut faire...
read -p "Ce script permet d'installer et de mettre en route la **dernière version** d'Asterisk, pour des systèmes de type **Debian**. Appuyez sur entrée pour le lancer." </dev/tty

# Téléchargement des paquets de dépendance
apt install --yes gcc g++ libedit-dev uuid-dev libxml2-dev libsqlite3-dev libssl-dev make patch wget
apt upgrade

# On change de répertoire et on se place dans l'endroit où Asterisk devra se trouver
cd /usr/src

# On télécharge les fichiers Asterisk
wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-18-current.tar.gz
tar -xzf asterisk-18-current.tar.gz
rm -rf asterisk-18-current.tar.gz

# On ajoute "usr/sbin" dans les variables PATH, c'est nécessaire pour installer
echo "export PATH=$PATH:usr/sbin" >> ~/.bashrc

# Pour ne pas à avoir à redémarrer
source ~/.bashrc

# On va installer Asterisk /!\ ATTENTION ICI LA VERSION PEUT CHANGER /!\
# La version a changé donc j'ai modifié ici
cd asterisk-18.9.0/
./configure --with-jansson-bundled
make && make all && make install

# Pas nécessaire
# make samples
make config

# Activation d'Asterisk
systemctl enable asterisk
systemctl start asterisk

# Vérification de la bonne installation en affichant la version installée
asterisk -V
