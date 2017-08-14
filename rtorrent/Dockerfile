FROM alpine:3.2

ADD rtorrent.rc /app/
ADD entrypoint.sh /app/

ENV TERM=xterm

RUN mkdir -p /app /data && \
    apk add --update ca-certificates rtorrent rsync && \
    chmod +x /app/entrypoint.sh

EXPOSE 5000
EXPOSE 7778
EXPOSE 7779

VOLUME ["/data/rtorrent", "/data/download", "/data/torrentwatch"]

WORKDIR /app

ENTRYPOINT ["/app/entrypoint.sh"]

CMD ["rtorrent", "-n", "-o", "import=/app/rtorrent.rc"]
