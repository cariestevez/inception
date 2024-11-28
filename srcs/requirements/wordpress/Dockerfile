FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php8.1 php8.1-fpm php8.1-mysql \
    curl wget unzip mariadb-client \
    && apt-get clean

# Download WordPress
# RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
#     tar -xvzf wordpress.tar.gz && \
#     mv wordpress /var/www/html && \
#     chown -R www-data:www-data /var/www/html

# # COPY ../tools/entrypoint.sh /entrypoint.sh
# COPY ../conf/wp-config.php /var/www/html/wordpress/wp-config.php
# RUN chmod +x /entrypoint.sh 

ENTRYPOINT ["php-fpm"]