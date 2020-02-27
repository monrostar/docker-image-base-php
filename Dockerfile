FROM debian:9.12

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt -y install lsb-release apt-transport-https ca-certificates wget
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt update
RUN apt-get -y install \
      php7.4 \
      php7.4-common \
      php7.4-fpm \
      php7.4-cli \
      php7.4-bcmath \
      php7.4-gd \
      php7.4-intl \
      php7.4-zip \
      php7.4-json \
      php7.4-ldap \
      php7.4-mbstring \
      php7.4-opcache \
      php7.4-redis \
      php7.4-xml \
      php7.4-xmlrpc \
      php7.4-gmp \
      php7.4-posix \
      php7.4-pdo \
      php7.4-mysqlnd \
      nginx \
      cron \
      supervisor

COPY --from=composer:1.9.3 /usr/bin/composer /usr/bin/composer
