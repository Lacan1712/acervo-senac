#!/bin/bash

# Configurar o VirtualHost HTTP
echo "<VirtualHost *:80>
    ServerAlias qr.rr.sebrae.com.br
    ServerName qr.rr.sebrae.com.br
    DocumentRoot /var/www/html/public
    <Directory /var/www/html/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/000-default.conf

# Configurar o VirtualHost para HTTPS
echo "<VirtualHost *:443>
    ServerName qr.rr.sebrae.com.br
    DocumentRoot /var/www/html/public
    <Directory /var/www/html/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined

    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/ca-certificates.crt
    SSLCertificateKeyFile /etc/ssl/certs/tls.key
</VirtualHost>" > /etc/apache2/sites-available/default-ssl.conf

# Habilitar o site SSL
a2ensite default-ssl

# Habilitar módulos rewrite e ssl
a2enmod rewrite ssl

# Habilitar o site padrão
a2ensite 000-default