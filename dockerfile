FROM centos:7.5.1804

RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash - && \
        yum clean all && yum makecache fast && \
        yum install -y gcc-c++ make && \
        yum install -y nodejs

RUN yum -y update && \
    # Sysvmsg; msgmax = 8MB; msgmnb = 16MB;
    # sysctl -w kernel.msgmax=8388608 && \
    # sysctl -w kernel.msgmnb=16777216 && \
    yum -y install zip unzip gcc gcc-c++ make openssl-devel linux-headers libevent-devel git

RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs --nogpgcheck install epel-release zip unzip && \
    yum -y --setopt=tsflags=nodocs --nogpgcheck install https://centos7.iuscommunity.org/ius-release.rpm && \
    yum -y --setopt=tsflags=nodocs --nogpgcheck install php72u-common \
        php72u-fpm \
        php72u-devel \
        php72u-cli \
        php72u-bcmath \
        php72u-gd \
        php72u-intl \
        php72u-zip \
        php72u-json \
        php72u-ldap  \
        php72u-mbstring \
        php72u-opcache \
        php72u-pecl-redis \
        php72u-xml \
        php72u-xmlrpc \
        php72u-gmp \
        php72u-posix \
        php72u-pdo \
        php72u-mysqlnd \
        git \
        python2-pip \
        pip install supervisor \
        nginx \
        cronie \
        yum clean all;

RUN mkdir -p /tmp \
    && php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" \
    && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/bin --filename=composer  \
    && composer --no-interaction global require 'hirak/prestissimo' \
    && rm -rf /tmp/composer-setup.php /tmp/.htaccess
