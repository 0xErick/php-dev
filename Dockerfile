From mileschou/phalcon:7.1-fpm

RUN  docker-php-ext-install pdo_mysql

RUN apt-get update

RUN \
    apt-get update  -y && \
    apt-get install ldap-utils libldb-dev libldap2-dev -y && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap