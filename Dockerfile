# base stage
FROM alpine AS base
RUN apk add --no-cache font-noto wireshark

# router stage
FROM base AS router
RUN apk add --no-cache frr openvpn
COPY docker/frr/daemons /etc/frr/daemons
COPY docker/frr/docker-start /usr/lib/frr/docker-start
COPY docker/frr/frr-save /usr/local/bin/frr-save
RUN mkdir -p /run/frr && chown -R frr:frr /run/frr
ENTRYPOINT /scripts/init.sh; exec /usr/lib/frr/docker-start

# client stage
FROM base AS client
RUN apk add --no-cache firefox dhclient
ENTRYPOINT /scripts/init.sh; exec sleep infinity

# ISP box with dhcp
FROM router AS box
RUN apk add --no-cache dhcp
COPY docker/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf