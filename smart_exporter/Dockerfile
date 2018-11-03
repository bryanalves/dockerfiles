FROM alexhaydock/smartctl:latest

MAINTAINER Bryan Alves <bryanalves@gmail.com>

ADD smartmon.sh /opt/bin/
ADD entrypoint.sh /opt/bin/

RUN apk add bash && mkdir /srv/smart

VOLUME "/srv/smart"
ENTRYPOINT ["/opt/bin/entrypoint.sh"]
