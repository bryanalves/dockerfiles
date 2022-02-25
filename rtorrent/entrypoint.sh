#!/bin/sh

addgroup --gid $(stat -c %g /data) torrent && useradd --home-dir /app --shell /usr/sbin/nologin --gid torrent --uid $(stat -c %u /data) torrent

mkdir -p /app/config/session
mkdir -p /app/config/torrents

rm -f /app/config/session/rtorrent.lock

exec "$@"
