# Etapa 1: Build do Tailwind (Node.js)
FROM node:20 AS frontend
WORKDIR /app
COPY . ./
RUN npm install
RUN npm run build

# Etapa 2: Build do Laravel (Composer)
FROM php:8.3-cli AS backend
WORKDIR /app

# Dependências do sistema + PHP
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev libpq-dev libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install zip gd

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY composer.* ./
COPY . .
RUN composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev


# Etapa final: Apache com PHP
FROM php:8.3-apache
WORKDIR /var/www/html

# Copiar frontend e backend prontos
COPY --from=frontend /app/public /var/www/html/public
COPY --from=backend /app /var/www/html

COPY Docker/script.sh /usr/local/bin/

# Habilitar Apache mod_rewrite
RUN a2enmod rewrite

# Ajustar permissões
# Configurar permissões
RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \; \
    && chmod +x /usr/local/bin/*.sh

# Expor portas
EXPOSE 80

# Rodar Apache
ENTRYPOINT ["/bin/bash", "-c", "/usr/local/bin/script.sh && apache2-foreground"]
