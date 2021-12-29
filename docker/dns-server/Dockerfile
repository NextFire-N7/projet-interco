FROM alpine:3
RUN apk add --no-cache unbound wireshark
  # wireshark pour débug les datagrammes UDP qui arriveront (éventuellement)
# Copie de la configuration
COPY unbound.conf /etc/unbound/unbound.conf
# On vérifie si la config est OK
# Mais comment on sait que c'est bon à part visuellement? Faire un script qui exécute?
CMD ["/usr/sbin/unbound-checkconf"]
# Entrypoint: on affecte une IP statique et on lance le serveur
ENTRYPOINT /data/dns-server/init.sh
