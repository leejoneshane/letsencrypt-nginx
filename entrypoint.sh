#!/bin/sh

# Generate strong DH parameters, if they don't already exist.
if [ ! -f /etc/letsencrypt/dhparam.pem ]; then
   openssl dhparam -out /etc/letsencrypt/dhparam.pem 2048
fi

# Initial certificate request, but skip if cached
if [[ "${NOSSL}" == "no" ]]; then
   if [ ! -f /etc/letsencrypt/live/${DOMAIN}/fullchain.pem ]; then
      certbot certonly --webroot \
      --webroot-path=/usr/share/nginx/html \
      --domain ${DOMAIN} \
      --email "${EMAIL}" --agree-tos
   
      cd /etc/letsencrypt
      ln -s live/${DOMAIN}/cert.pem cert.pem
      ln -s live/${DOMAIN}/chain.pem chain.pem
      ln -s live/${DOMAIN}/fullchain.pem fullchain.pem
      ln -s live/${DOMAIN}/privkey.pem privkey.pem  
   else
      crontab /etc/certbot-renew
   fi
fi

sed -i "s/\<DOMAIN\>/${DOMAIN}/g" /etc/nginx/conf.d/default.conf
sed -i "s/\<DOMAIN\>/${DOMAIN}/g" /etc/nginx/example/nextcloud.conf
sed -i "s/\<DOMAIN\>/${DOMAIN}/g" /etc/nginx/example/openldap.conf
nginx -g 'daemon off;'
