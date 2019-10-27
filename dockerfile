FROM php:7.1-fpm

COPY php.ini "$PHP_INI_DIR/php.ini"

RUN apt-get update && apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxpm-dev \
    libvpx-dev \
    cron \
    git \
	&& docker-php-ext-configure gd \
    --with-freetype-dir=/usr/lib/x86_64-linux-gnu/ \
    --with-jpeg-dir=/usr/lib/x86_64-linux-gnu/ \
    --with-xpm-dir=/usr/lib/x86_64-linux-gnu/ \
    --with-vpx-dir=/usr/lib/x86_64-linux-gnu/ \
	&& docker-php-ext-install bcmath pdo_mysql gd zip exif

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp

RUN mkdir -p /tmp \
    && php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" \
    && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/bin --filename=composer  \
    && composer --no-interaction global require 'hirak/prestissimo' \
    && rm -rf /tmp/composer-setup.php /tmp/.htaccess

