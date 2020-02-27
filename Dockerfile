FROM centos:7.7.1908

RUN yum -y --setopt=tsflags=nodocs update \
    && yum -y --setopt=tsflags=nodocs --nogpgcheck install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum -y --setopt=tsflags=nodocs --nogpgcheck install https://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && yum -y --setopt=tsflags=nodocs --nogpgcheck --enablerepo=remi-php74 install \
        php \
        php-common \
        php-fpm \
        php-devel \
        php-cli \
        php-bcmath \
        php-gd \
        php-intl \
        php-zip \
        php-json \
        php-ldap  \
        php-mbstring \
        php-opcache \
        php-pecl-redis \
        php-xml \
        php-xmlrpc \
        php-gmp \
        php-posix \
        php-pdo \
        php-mysqlnd \
    && yum -y --setopt=tsflags=nodocs --nogpgcheck install \
        zip \
        unzip \
        php-zip \
        git \
        python2-pip \
        pip install supervisor \
        nginx \
        cronie \
        yum clean all;

COPY --from=composer:1.9.3 /usr/bin/composer /usr/bin/composer
