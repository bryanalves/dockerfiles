FROM alpine:3.5

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
    && git clone -b master --single-branch https://github.com/SickRage/SickRage.git /app \
    && mkdir -p /config /data/download /data/processed \
    && chmod +x /entrypoint.sh \
    && apk del deps \
    && rm -rf /var/cache/apk/*

EXPOSE 8081

VOLUME /config /data/download /data/processed

WORKDIR /sickrage

ENTRYPOINT ["/entrypoint.sh"]

CMD ["su", "-l", "-c", "/usr/bin/env python2 /app/SickBeard.py --datadir=/config --nolaunch", "sickrage"]
