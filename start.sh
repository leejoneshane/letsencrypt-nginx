#!/bin/sh

# Generate strong DH parameters, if they don't already exist.
#if [ ! -f /etc/ssl/dhparams.pem ]; then
#  if [ -f /cache/dhparams.pem ]; then
#    cp /cache/dhparams.pem /etc/ssl/dhparams.pem
#  else
#    openssl dhparam -out /etc/ssl/dhparams.pem 2048
#    # Cache to a volume for next time?
#    if [ -d /cache ]; then
#      cp /etc/ssl/dhparams.pem /cache/dhparams.pem
#    fi
#  fi
#fi


# Initial certificate request, but skip if cached
if [ ! -f /etc/letsencrypt/live/${DOMAIN}/fullchain.pem ]; then
  certbot --nginx \
   --webroot --webroot-path=/usr/share/nginx/html \
   --domain ${DOMAIN} \
   --email "${EMAIL}" --agree-tos
fi

nginx -g daemon off;
