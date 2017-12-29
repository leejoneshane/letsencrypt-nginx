# letsencrypt-nginx

This is a docker image, contained nginx with LET'S ENCRYPT SSL Certification base on Alpine.

# How to use

To get LET'S ENCRYPT SSL certificate, you need to add DNS A or AAAA record for your website. Then you should expose 80 & 443 ports and give the environment variables DOMAIN & EMAIL, when you run the container, command like below:
```
docker run -e DOMAIN=your.web.site.fqdn -e EMAIL=your.email ...... -d leejoneshane/letsnginx
```

In first time running, the container will automatic get SSL certificate for you, then renew the SSL certificate automatic by cron job. If you want to change renew interval, please edit the file at /var/spool/cron/crontabs/certbot-renew.

To store the certificate and website files persistent, you need to mount host folders to the container volume.

* __/etc/nginx/conf.d/__ The nginx server or reserve proxy configure.
* __/etc/letsencrypt__ The SSL certificate files.
* __/usr/share/nginx/html__ The website root documents. 

If you need a reverse proxy for nextcloud + libreoffice online + draw.io, then you can copy the file in /etc/nginx/example/[nextcloud.conf](https://github.com/leejoneshane/letsencrypt-nginx/blob/master/nextcloud.conf) to /etc/nginx/conf.d/default.conf.

Or maybe you want to run openldap+openam with nginx reverse proxy, then you should copy the file in /etc/nginx/example/[openldap.conf](https://github.com/leejoneshane/letsencrypt-nginx/blob/master/openldap.conf) to /etc/nginx/conf.d/default.conf.
