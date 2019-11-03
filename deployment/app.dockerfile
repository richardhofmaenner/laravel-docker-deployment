FROM php:fpm

COPY composer.lock composer.json /var/www/

COPY database /var/www/database

WORKDIR /var/www

RUN apt-get update && apt-get -y install git zip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php composer-setup.php \
&& php -r "unlink('composer-setup.php');" \
&& php composer.phar install --no-scripts \
&& rm -rf composer.phar

COPY . /var/www

RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

RUN apt-get install -y libmcrypt-dev libmagickwand-dev --no-install-recommends && pecl install mcrypt-1.0.2 && docker-php-ext-install pdo_mysql && docker-php-ext-enable mcrypt

RUN mv .env.prod .env

#RUN php artisan optimize
