FROM php:8.0.11-alpine as build-composer-stage
LABEL maintainer="Leandro Henrique <emtudo@gmail.com>"

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

WORKDIR /app
COPY . .

# INSTALL
RUN echo -e "\n # ---> Installing Composer Dependencies \n" && \
  composer install \
    --no-interaction \
    --no-progress \
    --prefer-dist \
    --no-autoloader \
    --no-scripts \
    --optimize-autoloader \
    --no-dev \
    --ignore-platform-reqs

RUN composer dump-autoload

# OPTIMIZE
RUN php artisan optimize


FROM phpswoole/swoole:4.8-php8.0-alpine as production-stage

LABEL name="Base php with Swoole" \
  description="Base php with Swoole" \
  vcs.url="https://github.com/ciareis/php-swoole-alpine"

WORKDIR /app
# pdo_pgsql
RUN set -ex \
	&& apk --no-cache add postgresql-libs postgresql-dev \
	&& docker-php-ext-install pgsql pdo_pgsql pcntl \
	&& apk del postgresql-dev
# extensoes disponíveis
# bcmath bz2 calendar ctype curl dba dom enchant exif ffi fileinfo filter ftp gd gettext gmp hash iconv imap intl json ldap mbstring mysqli oci8 odbc opcache pcntl pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix pspell readline reflection session shmop simplexml snmp soap sockets sodium spl standard sysvmsg sysvsem sysvshm tidy tokenizer xml xmlreader xmlwriter xsl zend_test zip

# RUN rm -rf /var/cache/apk/*
# COPY SOURCE
COPY --from=build-composer-stage /app /app
# RUN php artisan config:cache && php artisan route:cache && php artisan view:cache

EXPOSE 80

# especificar trabalhadores
# --workers=4
# Especificar a quantidade de trabalhadores de tarefas
# --task-workers=6
# limitar quantidade de requisições por trabalhado para evitar vazamento de memória
# --max-requests=250
CMD ["php", "artisan", "octane:start", "--host=0.0.0.0", "--port=80", "--workers=2"]
