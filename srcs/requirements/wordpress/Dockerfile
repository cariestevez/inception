FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php php-fpm curl \
    php-mysql \
    default-mysql-client \
    && apt-get clean

RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xvzf wordpress.tar.gz && \
    mkdir -p /var/www/wordpress && \
    mv wordpress/* /var/www/wordpress && \
    chown -R www-data:www-data /var/www/wordpress && \
    chmod -R 755 /var/www/wordpress && \
    #chmod -R 644 /var/www/wordpress/* && \
    mkdir -p var/run/php/ && cd var/run/php/ && touch php7.4-fpm.pid

COPY ../conf/wp-config.php /var/www/wordpress/
COPY ../conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN chmod 644 /var/www/wordpress/wp-config.php

#ENTRYPOINT ["bin/sh", "-c", "while true; do sleep 1000; done"]
ENTRYPOINT [ "/usr/sbin/php-fpm7.4", "-F" ]