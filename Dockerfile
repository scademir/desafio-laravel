FROM php:7.4-fpm-alpine3.12
RUN apk add --no-cache openssl bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql


ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz


WORKDIR /var/www
RUN rm -rf /var/www/html 

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# PARA EVITAR O COPY, E FAZER O COMPOSER INSTALL CORRETAMENTE,
# O COMPOSER INSTALL FOI COLOCADO NO ARQUIVO ENTRYPOINT.SH
#
#
#COPY . /var/www
#RUN composer install && \
#             cp .env.example .env && \
#             php artisan key:generate && \
#             php artisan config:cache


RUN ln -s public html

#RUN usermod -u 1000 www-data
#USER www-data

EXPOSE 9000
ENTRYPOINT ["php-fpm"]
