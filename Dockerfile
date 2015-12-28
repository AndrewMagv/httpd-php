FROM php:5.6-apache
MAINTAINER YI-HUNG JEN <yihungjen@gmail.com>

# install composer
RUN curl -sSL https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin \
    --filename=composer

# install necessary pakcages and extension
RUN apt-get update && apt-get install -y \
    git \
    libmcrypt-dev \
    libssl-dev \
    libsasl2-dev \
    && docker-php-ext-install \
        mbstring \
        mcrypt \
        mysql \
        zip
