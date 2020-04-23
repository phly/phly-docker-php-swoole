# phly-docker-php-swoole

This repository provides tools for building and pushing the following Docker
images:

- **mwop/phly-docker-php-swoole:7.4**: an image based on php:7.4-cli that
  includes [Composer](https://getcomposer.org), the hirak/prestissimo Composer
  plugin, and the [Swoole](https://swoole.co.uk) extension.

- **mwop/phly-docker-php-swoole:7.4-alpine**: an image based on
  php:7.3-cli-alpine that includes [Composer](https://getcomposer.org), the
  hirak/prestissimo Composer plugin, and the [Swoole](https://swoole.co.uk)
  extension.

Each creates the directory `/var/www/public`, and the entrypoint
`/usr/local/bin/entrypoint`, which will run the application. By default, this
assumes a file `/var/www/public/index.php`, and the entrypoint will execute this
using the PHP binary.

## Extending the image

As an example of extending the image, consider the following, which builds and
runs an [Expressive](https://getexpressive.org) application:

```Dockerfile
# DOCKER-VERSION        1.3.2

FROM mwop/phly-docker-php-swoole:7.4

# PHP Extensions
RUN docker-php-ext-install -j$(nproc) bcmath bz2 intl opcache zip

# Overwrite entrypoint
COPY etc/bin/php-entrypoint /usr/local/bin/entrypoint

# Project files
COPY bin /var/www/bin
COPY composer.json /var/www/
COPY composer.lock /var/www/
COPY templates /var/www/templates
COPY config /var/www/config
COPY src /var/www/src
COPY data /var/www/data
COPY public /var/www/public

# Build project
WORKDIR /var/www
RUN composer install --quiet --no-ansi --no-dev --no-interaction --no-progress --no-scripts --no-plugins --optimize-autoloader && \
  composer docker:site
```

where `php-entrypoint` looks like the following:

```php
#!/bin/sh
/usr/bin/env php public/index.php start
```
