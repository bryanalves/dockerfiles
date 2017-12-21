#!/bin/sh

addgroup --gid $(stat -c %g /data/download) torrent && useradd --home-dir /app --shell /usr/sbin/nologin --gid torrent --uid $(stat -c %u /data/download) torrent

mkdir -p /data/rtorrent/session
mkdir -p /data/rtorrent/torrents

[ "${RTORRENT_BIND}" ] && {
    sed -i '/^network.bind_address.set =' /app/rtorrent.rc
    echo "network.bind_address.set = ${RTORRENT_BIND}" >> /app/rtorrent.rc
}

[ "${RTORRENT_LOCALADDR}" ] && {
    sed -i '/^network.local_address.set =' /app/rtorrent.rc
    echo "network.local_address.set = ${RTORRENT_LOCALADDR}" >> /app/rtorrent.rc
}

rm -f /data/rtorrent/session/rtorrent.lock

exec "$@"
