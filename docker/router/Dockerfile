FROM base-alpine
RUN apk add --no-cache frr
COPY frr/daemons /etc/frr/daemons
COPY frr/docker-start /usr/lib/frr/docker-start
COPY frr/frr-save /usr/local/bin/frr-save
RUN mkdir -p /run/frr && chown -R frr:frr /run/frr
ENTRYPOINT /data/init.sh; exec /usr/lib/frr/docker-start
