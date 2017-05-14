#!/bin/sh

# Generate strong DH parameters, if they don't already exist.
if [ ! -f /etc/ssl/dhparams.pem ]; then
   openssl dhparam -out /etc/ssl/dhparams.pem 2048
fi

# Initial certificate request, but skip if cached
if [ ! -f /etc/letsencrypt/live/${DOMAIN}/fullchain.pem ]; then
  certbot --nginx \
   --webroot --webroot-path=/usr/share/nginx/html \
   --domain ${DOMAIN} \
   --email "${EMAIL}" --agree-tos
fi

/usr/bin/sed -i "s/\<domain\>/${DOMAIN}/g" /etc/nginx/conf.d/default.conf

nginx -g daemon off;
