# DOCKER-VERSION        1.3.2

FROM php:7.2-cli

# System dependencies
RUN apt-get update && \
  apt-get install -y procps git libbz2-dev libicu-dev libtidy-dev libxslt1-dev zlib1g-dev && \
  rm -rf /var/lib/apt/lists/*

# PHP configuration
COPY swoole.ini /usr/local/etc/php/conf.d/000-swoole.ini

# Install Swoole
RUN pecl install swoole-4.2.5 && docker-php-ext-enable swoole && rm -rf /tmp/pear

# Install composer
COPY getcomposer.sh /usr/local/bin/
RUN /usr/local/bin/getcomposer.sh

# Project files
RUN mkdir -p /var/www/public
COPY index.php /var/www/public/
COPY entrypoint /usr/local/bin/

EXPOSE 9000
ENTRYPOINT ["entrypoint"]
