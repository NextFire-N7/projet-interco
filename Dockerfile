# base stage
FROM alpine AS alpine-base
RUN apk add --no-cache font-noto wireshark firefox irssi

# router stage
FROM alpine-base AS router
RUN apk add --no-cache frr openvpn
COPY docker/frr/daemons /etc/frr/daemons
COPY docker/frr/docker-start /usr/lib/frr/docker-start
COPY docker/frr/frr-save /usr/local/bin/frr-save
RUN mkdir -p /run/frr && chown -R frr:frr /run/frr
ENTRYPOINT /data/init.sh; exec /usr/lib/frr/docker-start

# ISP box with dhcp
FROM router AS box
RUN apk add --no-cache dhcp
COPY docker/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf

# Clients avec client Asterisk
FROM ubuntu AS client
ENV DEBIAN_FRONTEND=noninteractive
# Linphone est un logiciel de VoIP qui fonctionne comme Skype
RUN apt update && apt install -y --no-install-recommends linphone
ENTRYPOINT /data/init.sh; exec sleep infinity
