FROM nginx:alpine

ENV MAIL your@mail.addr
ENV DOMAIN server.tld

ADD default.conf /etc/nginx/conf.d/default.conf
ADD openldap.conf /etc/nginx/example/openldap.conf
ADD nextcloud.conf /etc/nginx/example/nextcloud.conf
ADD crontab /var/spool/cron/crontabs/certbot-renew
ADD gencerts.sh /gencerts.sh

RUN apk update  \
    && apk add --no-cache certbot acme-client openssl ca-certificates \
    && rm -rf /var/cache/apk/* \
    && chmod 711 /gencerts.sh

VOLUME /etc/letsencrypt
VOLUME /etc/nginx/conf.d
EXPOSE 80 443
CMD nginx -g 'daemon off;'
