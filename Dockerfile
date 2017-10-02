FROM nginx:alpine
RUN apk update  \
    && apk add --no-cache certbot acme-client openssl ca-certificates \
    && rm -rf /var/cache/apk/*

ENV MAIL your@mail.addr
ENV DOMAIN server.tld

VOLUME /etc/letsencrypt
VOLUME /etc/nginx/conf.d

ADD default.conf /etc/nginx/conf.d/default.conf
ADD crontab /var/spool/cron/crontabs/certbot-renew
ADD gencerts.sh /gencerts.sh

EXPOSE 80 443
CMD nginx -g 'daemon off;'
