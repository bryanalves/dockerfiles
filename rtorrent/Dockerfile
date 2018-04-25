FROM debian:stretch

ADD rtorrent.rc /app/
ADD entrypoint.sh /app/

ENV TERM=xterm

RUN mkdir -p /app /data && \
    apt-get update && \
    apt-get install -y ca-certificates rtorrent rsync && \
    rm -rf /var/lib/apt/lists/* && \
    chmod +x /app/entrypoint.sh

EXPOSE 5000
EXPOSE 57778
EXPOSE 57779

VOLUME ["/data/rtorrent"]

WORKDIR /app

ENTRYPOINT ["/app/entrypoint.sh"]

CMD ["rtorrent", "-n", "-o", "import=/app/rtorrent.rc"]
