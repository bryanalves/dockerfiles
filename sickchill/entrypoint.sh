#!/bin/sh

addgroup -g $(stat -c %g /data/download) sickchill && adduser -h /app -s /bin/sh -G sickchill -D -u $(stat -c %u /data/download) sickchill
chown -R sickchill:sickchill /app
chown -R sickchill:sickchill /config

exec "$@"
