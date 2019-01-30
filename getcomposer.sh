#!/bin/sh

EXPECTED_SIGNATURE=$(curl -s https://composer.github.io/installer.sig)
curl -s -o composer-setup.php https://getcomposer.org/installer
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid composer installer signature'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet
RESULT=$?
rm composer-setup.php

if [ "$?" != "0" ]
then
    >&2 echo 'ERROR: composer installer encountered an error'
    exit 1
fi

mv composer.phar /usr/local/bin/composer

exit 0
