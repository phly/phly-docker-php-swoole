# DOCKER-VERSION        1.3.2

FROM php:7.2-cli

ARG SWOOLEVERSION
ENV SWOOLEPACKAGE swoole-$SWOOLEVERSION.tgz

# System dependencies
RUN apt-get update && \
  apt-get install -y git libbz2-dev libicu-dev libnghttp2-dev libtidy-dev libxslt1-dev procps zlib1g-dev && \
  rm -rf /var/lib/apt/lists/* && \
  docker-php-ext-install -j$(nproc) sockets

# Compile and install Swoole
RUN mkdir -p /tmp/swoole && \
    cd /tmp/swoole && \
    curl -s -o swoole.tgz https://pecl.php.net/get/$SWOOLEPACKAGE && \
    tar xzvf swoole.tgz --strip-components=1 && \
    phpize && \
    ./configure --enable-sockets --enable-http2 && \
    make && \
    make install && \
    cd /tmp && \
    rm -Rf swoole

# PHP configuration
COPY swoole.ini /usr/local/etc/php/conf.d/000-swoole.ini

# Install composer
COPY getcomposer.sh /usr/local/bin/
RUN /usr/local/bin/getcomposer.sh

# Project files
RUN mkdir -p /var/www/public
COPY index.php /var/www/public/
COPY entrypoint /usr/local/bin/

EXPOSE 9000
ENTRYPOINT ["entrypoint"]
