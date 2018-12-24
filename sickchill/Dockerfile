FROM python:2.7-alpine
MAINTAINER Bryan Alves <bryanalves@gmail.com>

ENV PYTHONIOENCODING="UTF-8"

ADD entrypoint.sh /

RUN apk add --update \
  git \
  mediainfo \
  nodejs \
  unrar \
  tzdata \
  && git clone -b master --single-branch https://github.com/SickChill/SickChill.git /app \
  && mkdir -p /config /data/download /data/processed /var/run/sickchill \
  && chmod +x /entrypoint.sh \
  && rm -rf /var/cache/apk/*

WORKDIR /app

VOLUME /config /data/download /data/processed

ENTRYPOINT ["/entrypoint.sh"]

CMD ["su", "-l", "-c", "/usr/bin/env python2 /app/SickBeard.py --datadir=/config --nolaunch -q --port 8081", "sickchill"]

EXPOSE 8081
