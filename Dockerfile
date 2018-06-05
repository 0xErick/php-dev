From mileschou/phalcon:7.1-fpm

RUN  apt-get update && apt-get install -y sudo

# 常用工具
RUN apt-get install vim -y
RUN apt install wget -y

# composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

#安装 node.js 8
RUN  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN  sudo apt-get install -y nodejs

# 安装 pm2
RUN npm install -g pm2

#php扩展  gd zip ldap pcntl redis pdo_mysql
RUN apt-get install -y libpng-dev  && apt-get install -y zlib1g-dev 
RUN docker-php-ext-install gd
RUN docker-php-ext-install zip
RUN apt-get install git -y
RUN apt-get install ldap-utils libldb-dev libldap2-dev -y
RUN rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu
RUN docker-php-ext-install ldap
RUN docker-php-ext-install pcntl
RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini
RUN  docker-php-ext-install pdo_mysql

#php扩展 mongo
RUN cd /usr/local/src/ && wget http://pecl.php.net/get/mongodb-1.4.3.tgz && tar -zxvf mongodb-1.4.3.tgz
RUN cd /usr/local/src/mongodb-1.4.3 &&  apt-get update && sudo apt install -y libssl-dev  && phpize && ./configure && make && make install

#启用扩展
RUN docker-php-ext-enable  gd zip ldap pcntl redis pdo_mysql mongodb phalcon

WORKDIR /www/code