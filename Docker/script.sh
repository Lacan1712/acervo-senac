#!/bin/bash

# Configurar o VirtualHost para Laravel
echo "<VirtualHost *:80>
    ServerAlias localhost
    DocumentRoot /var/www/html/public
    <Directory /var/www/html/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/000-default.conf

a2enmod rewrite