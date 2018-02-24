From mileschou/phalcon:7.1-fpm

RUN  apt-get update && apt-get install -y sudo

RUN  docker-php-ext-install pdo_mysql

# redis 扩展
RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini

# composer 
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" 
RUN php composer-setup.php 
RUN php -r "unlink('composer-setup.php');" 
RUN mv composer.phar /usr/local/bin/composer

#安装 node.js 8
RUN  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN  sudo apt-get install -y nodejs

#安装 laravel-echo-server
RUN  npm install -g laravel-echo-server

# 安装 pm2
RUN npm install -g pm2

#安装 ldap
RUN apt-get install git -y  
RUN apt-get install ldap-utils libldb-dev libldap2-dev -y
RUN rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu 
RUN docker-php-ext-install ldap 
RUN docker-php-ext-install pcntl