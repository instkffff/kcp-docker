# Shadowsocks Server with KCPTUN support Dockerfile
FROM alpine:3.7

ENV KCP_VER 20180316

RUN \
    apk add --no-cache --virtual .build-deps curl \
    && curl -fSL https://github.com/xtaci/kcptun/releases/download/v$KCP_VER/kcptun-linux-amd64-$KCP_VER.tar.gz | tar xz -C /usr/local/bin server_linux_amd64 \
    && apk del .build-deps \
    && apk add --no-cache supervisor

COPY config.json /etc/config.json

RUN   \
     ./usr/local/bin/server_linux_amd64 -c /etc/config.json

EXPOSE 4000/udp

ENTRYPOINT ["/usr/bin/supervisord"]

