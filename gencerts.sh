#!/bin/sh

# Generate strong DH parameters, if they don't already exist.
if [ ! -f /etc/nginx/conf.d/dhparam.pem ]; then
   openssl dhparam -out /etc/nginx/conf.d/dhparam.pem 2048
fi

# Initial certificate request, but skip if cached
if [ ! -f /etc/letsencrypt/live/${DOMAIN}/fullchain.pem ]; then
  certbot certonly --webroot \
   --webroot-path=/usr/share/nginx/html \
   --domain ${DOMAIN} \
   --email "${EMAIL}" --agree-tos
else
  certbot renew
fi

sed -i "s/\<DOMAIN\>/${DOMAIN}/g" /etc/nginx/conf.d/default.conf
