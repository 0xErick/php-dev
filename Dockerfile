From mileschou/phalcon:7.1-fpm

RUN  docker-php-ext-install pdo_mysql

RUN apt-get update

RUN \
    apt-get update  -y && \
    apt-get install git \
    apt-get install ldap-utils libldb-dev libldap2-dev -y && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap \
    docker-php-ext-install pcntl
RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini

#安装 node.js 6
RUN  apt-get update && apt-get install -y sudo
RUN  curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN  sudo apt-get install -y nodejs

#安装 laravel-echo-server
RUN  npm install -g laravel-echo-server

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" 
RUN php composer-setup.php 
RUN php -r "unlink('composer-setup.php');" 
RUN mv composer.phar /usr/local/bin/composer