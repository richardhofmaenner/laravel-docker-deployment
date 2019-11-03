FROM nginx:alpine

ADD deployment/vhost.conf /etc/nginx/conf.d/default.conf

COPY public /var/www/public
