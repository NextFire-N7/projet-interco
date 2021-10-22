FROM alpine

RUN apk add --no-cache \
    font-noto \
    wireshark \
    wireguard-tools

ENTRYPOINT /scripts/init.sh; sleep infinity
