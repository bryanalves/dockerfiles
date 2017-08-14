#!/bin/sh

addgroup -g $(stat -c %g /data/download) sickrage && adduser -h /app -s /bin/sh -G sickrage -D -u $(stat -c %u /data/download) sickrage
chown -R sickrage:sickrage /app
chown -R sickrage:sickrage /config

exec "$@"
