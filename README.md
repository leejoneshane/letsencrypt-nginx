# letsencrypt-nginx

This is a docker image, contained nginx with LET'S ENCRYPT SSL Certification base on Alpine.

# How to use

To get LET'S ENCRYPT SSL certificate, you need give below environment variables:
```
docker run -e DOMAIN=your.web.site.fqdn -e EMAIL=your.email ...... -d leejoneshane/letsnginx
```
The container will renew the SSL certificate automatic by cron job. If you want to change renew interval, please edit the file at /var/spool/cron/crontabs/certbot-renew.

If you need a reverse proxy for nextcloud + libreoffice online + draw.io, then you can copy the file in /etc/nginx/example/[nextcloud.conf]((https://github.com/leejoneshane/letsencrypt-nginx/blob/master/nextcloud.conf)) to /etc/nginx/conf.d/default.conf.

Or maybe you want to run openldap+openam with nginx reverse proxy, then you should copy the file in /etc/nginx/example/[openldap.conf]((https://github.com/leejoneshane/letsencrypt-nginx/blob/master/openldap.conf)) to /etc/nginx/conf.d/default.conf.
