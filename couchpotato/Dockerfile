FROM alpine:3.5
LABEL version 0.1

MAINTAINER Bryan Alves <bryanalves@gmail.com>

ADD entrypoint.sh /

RUN apk --update add \
    git \
    tzdata \
    python \
    unrar \
    zip \
    libxslt \
    py-pip \
    py-lxml \
    && apk --update add --virtual deps \
    python-dev \
    libxml2-dev \
    libxslt-dev \
    && pip install \
    cheetah \
    && git clone -b master --single-branch https://github.com/CouchPotato/CouchPotatoServer.git /app \
    && mkdir -p /config /data/download /data/processed \
    && chmod +x /entrypoint.sh \
    && apk del deps \
    && rm -rf /var/cache/apk/*

EXPOSE 8082

VOLUME /config /data/download /data/processed

ENTRYPOINT ["/entrypoint.sh"]

CMD ["su", "-l", "-c", "/usr/bin/env python2 /app/CouchPotato.py --data_dir=/config", "couchpotato"]
