FROM php:7.2-fpm

# Copy scripts to be available globally
COPY ./docker/php-fpm/scripts /usr/local/bin
#RUN add-apt-repository ppa:openjdk-r/ppa
# Install docker extensions and set script permissions
RUN mkdir -p /usr/share/man/man1
RUN apt-get update && \
 apt-get install -y zlib1g-dev && \
    docker-php-ext-install pdo pdo_mysql zip 
RUN apt-get clean

# Install composer
RUN curl --silent --show-error https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

WORKDIR /var/www