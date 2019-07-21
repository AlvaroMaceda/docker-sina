#FROM php:7.2.7-fpm-alpine3.7
# El blog de sina no funciona con php7
FROM php:5.6-fpm-alpine
RUN apk update; \
    apk upgrade;
RUN docker-php-ext-install mysqli
