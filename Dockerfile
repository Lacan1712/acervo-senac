# Etapa 1: Build do Tailwind (Node.js)
FROM node:20 AS frontend
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY resources/ resources/
COPY tailwind.config.js vite.config.js ./
RUN npm run build

# Etapa 2: Build do Laravel (Composer)
FROM php:8.3-cli AS backend
WORKDIR /app

# Dependências do sistema + PHP
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev libpq-dev libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install zip pdo_pgsql gd

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY composer.* ./
RUN composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev

COPY . .

# Etapa final: Apache com PHP
FROM php:8.3-apache
WORKDIR /var/www/html

# Copiar frontend e backend prontos
COPY --from=frontend /app/public /var/www/html/public
COPY --from=backend /app /var/www/html

# Habilitar Apache mod_rewrite
RUN a2enmod rewrite

# Ajustar permissões
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Expor portas
EXPOSE 80

# Rodar Apache
CMD ["apache2-foreground"]
