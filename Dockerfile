# base stage on alpine
FROM alpine AS alpine-base
RUN apk add --no-cache font-noto wireshark

# base stage on ubuntu
FROM ubuntu AS ubuntu-base
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y --no-install-recommends iproute2 wireshark firefox irssi

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

FROM ubuntu-base AS client
# Linphone est un logiciel de VoIP qui fonctionne comme Skype
RUN apt install -y --no-install-recommends linphone
ENTRYPOINT /data/init.sh; exec sleep infinity
