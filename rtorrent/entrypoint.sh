#!/bin/sh

addgroup --gid $(stat -c %g /data/download) torrent && useradd --home-dir /app --shell /usr/sbin/nologin --gid torrent --uid $(stat -c %u /data/download) torrent

mkdir -p /data/rtorrent/session
mkdir -p /data/rtorrent/torrents

rm -f /data/rtorrent/session/rtorrent.lock

exec "$@"
