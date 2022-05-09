#!/bin/bash

## Set the server user
chown -R www-data: /var/www/wordpress-site
chown -R phpmyadmin: /var/www/phpmyadmin

## Set general folder and file permissions
find /var/www -type d -exec chmod 755 '{}' \;
find /var/www -type f -exec chmod 644 '{}' \;

## Allow dev user rw permissions on wordpress-site
# setfacl -R -m u:dev:rw /var/www/wordpress-site