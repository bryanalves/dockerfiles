#!/bin/sh

while true; do
  /opt/bin/smartmon.sh > /srv/smart/smartmon.prom.$$ && \
    mv /srv/smart/smartmon.prom.$$ /srv/smart/smartmon.prom

  sleep 30;
done
