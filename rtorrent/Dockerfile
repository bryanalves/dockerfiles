FROM debian:bullseye

ENV TERM=xterm

RUN mkdir -p /app /data && \
    apt-get update && \
    apt-get install -y ca-certificates rtorrent rsync && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 5000
EXPOSE 57778
EXPOSE 57779

VOLUME ["/data"]
VOLUME ["/app/config"]

WORKDIR /app

CMD ["rtorrent", "-n", "-o", "import=/app/rtorrent.rc"]
