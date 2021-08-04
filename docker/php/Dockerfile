FROM php:8.0-fpm-buster
LABEL maintainer "Juri Matsuda <matsuda.juri@gmail.com>"
COPY ./docker/php/php.ini /usr/local/etc/php/

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin

#Composer install
#RUN cd /usr/bin && curl -s http://getcomposer.org/installer | php && ln -s /usr/bin/composer.phar /usr/bin/composer
COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y \
git \
zip \
unzip \
vim \
libicu-dev \
zlib1g-dev \
libzip-dev

RUN docker-php-ext-install pdo_mysql intl zip bcmath
RUN rm -rf /var/lib/apt/lists/*

#RUN pecl install xdebug \
#    && docker-php-ext-enable xdebug

WORKDIR /var/www/

RUN composer global require "laravel/installer"
