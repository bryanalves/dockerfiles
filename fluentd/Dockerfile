FROM fluent/fluentd:v1.2-onbuild
MAINTAINER Bryan Alves <bryanalves@gmail.com>

RUN apk add --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo gem install \
        fluent-plugin-secure-forward \
        fluent-plugin-prometheus \
        fluent-plugin-retag \
        fluent-plugin-rewrite-tag-filter \
        fluent-plugin-route \
        fluent-plugin-elasticsearch \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /home/fluent/.gem/ruby/2.3.0/cache/*.gem

EXPOSE 24284
