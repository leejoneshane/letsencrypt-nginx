FROM nginx:alpine
RUN apk update  \
    && apk add --no-cache certbot acme-client \
    && rm -rf /var/cache/apk/*

ENV MAIL your@mail.addr
ENV DOMAIN sever.tld

VOLUME /etc/letsencrypt

ADD crontab /var/spool/cron/crontabs/certbot-renew
ADD start.sh /start.sh
EXPOSE 80 443
ENTRYPOINT ["/start.sh"]
