# Usa una imagen base de PHP
FROM php:8.3-fpm

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libzip-dev unzip git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

# Instalación de extensiones necesarias para PostgreSQL
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql


# Establece el directorio de trabajo
WORKDIR /var/www

# Copia los archivos de la aplicación al contenedor
COPY . /var/www

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Instala dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

# Establece permisos adecuados para Laravel
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Expone el puerto 9000
EXPOSE 9000

# Ejecuta el servidor PHP
CMD ["php-fpm"]
