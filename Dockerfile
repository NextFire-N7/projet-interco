# base stage
FROM alpine AS base
RUN apk add --no-cache font-noto wireshark
VOLUME /scripts
WORKDIR /scripts
ENTRYPOINT ./init.sh; sleep infinity

# router stage, "extends" the base one
FROM base AS router
RUN apk add --no-cache openvpn

# client stage, "extends" the base one
FROM base AS client
RUN apk add --no-cache firefox
