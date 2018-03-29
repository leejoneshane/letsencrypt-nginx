# letsencrypt-nginx

This is a docker image, contained nginx with LET'S ENCRYPT SSL Certification base on Alpine.

# How to use

To get LET'S ENCRYPT SSL certificate, you need to add DNS A or AAAA record for your website. Then you should expose 80 & 443 ports and give the environment variables DOMAIN & EMAIL, when you run the container, command like below:
```
docker run -e DOMAIN=your.web.site.fqdn -e EMAIL=your.email -p 80:80 -p 443:443...... -d leejoneshane/letsnginx
```

# Use Case 1

You already have a website, and the site is a docker container. You can link the site to this container instance, like below:
```
docker run -e DOMAIN=your.web.site.fqdn -e EMAIL=your.email --link website_container_id_or_name:upstream -p 80:80 -p 443:443...... -d leejoneshane/letsnginx
```

# Use Case 2

You already have a website, but the site is __not__ a docker container. You can add the extra host to /etc/hosts, like below:
```
docker run -e DOMAIN=your.web.site.fqdn -e EMAIL=your.email --add-host="website_ip:upstream" -p 80:80 -p 443:443...... -d leejoneshane/letsnginx
```

# Use Case 3

If Your website is static web pages wrote by HTML, the you should mount the static web directory to /usr/share/nginx/html。like below:
```
docker run -e DOMAIN=your.web.site.fqdn -e EMAIL=your.email -v static_dir:/usr/share/nginx/html -p 80:80 -p 443:443...... -d leejoneshane/letsnginx
```

If your website is run by PHP, Perl or other language, you can install these packages for this container instance. Enter the
console to install packages, use the command below:
```
docker exec -it container_name sh
apk add php7(or something)
```

# Custom configuration

In the first time running, the container will automatic get SSL certificate for you, and automatic renew the SSL certificate  by cron job. If you want to change the renew interval, please edit the file at /var/spool/cron/crontabs/certbot-renew.

To store the certificate and website files persistent, you need to mount host folders to the container volume.

* __/etc/nginx/conf.d/__ The nginx server or reserve proxy configure.
* __/etc/letsencrypt__ The SSL certificate files.
* __/usr/share/nginx/html__ The website root documents. 

If you need a reverse proxy for nextcloud + libreoffice online + draw.io, then you can copy the file in /etc/nginx/example/[nextcloud.conf](https://github.com/leejoneshane/letsencrypt-nginx/blob/master/nextcloud.conf) to /etc/nginx/conf.d/default.conf.

Or maybe you want to run openldap+openam with nginx reverse proxy, then you should copy the file in /etc/nginx/example/[openldap.conf](https://github.com/leejoneshane/letsencrypt-nginx/blob/master/openldap.conf) to /etc/nginx/conf.d/default.conf.
