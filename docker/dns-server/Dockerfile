FROM base-alpine
RUN apk add --no-cache unbound tcpdump
# wireshark pour débug les datagrammes UDP qui arriveront (éventuellement)
# On vérifie si la config est OK
# Mais comment on sait que c'est bon à part visuellement? Faire un script qui exécute?
# Entrypoint: on affecte une IP statique et on lance le serveur
ENTRYPOINT /data/init.sh; unbound-checkconf /data/unbound.conf && exec unbound -c /data/unbound.conf
