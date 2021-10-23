FROM alpine AS base
RUN apk add --no-cache font-noto wireshark
VOLUME /scripts
WORKDIR /scripts
ENTRYPOINT ./init.sh; sleep infinity

FROM base AS router
RUN apk add --no-cache wireguard-tools

FROM base AS client
RUN apk add --no-cache firefox
