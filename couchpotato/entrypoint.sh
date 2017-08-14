#!/bin/sh

addgroup -g $(stat -c %g /data/download) couchpotato && adduser -h /app -s /bin/sh -G couchpotato -D -u $(stat -c %u /data/download) couchpotato
chown -R couchpotato:couchpotato /app
chown -R couchpotato:couchpotato /config

exec "$@"
