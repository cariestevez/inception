FROM debian:12.6

RUN apt-get update -y  && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends --no-install-suggests -y \
    ca-certificates \
    php-fpm \
    php-mysql \
    wget \
    tar && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz
  
# Set proper file permissions
#RUN chown -R www-data:www-data /var/www/html && \
#    find /var/www/html/ -type d -exec chmod 755 {} \; && \
#    find /var/www/html/ -type f -exec chmod 644 {} \;

# Create a custom PHP-FPM configuration (optional)
#COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf

# Copy a custom wp-config.php file (optional)
#COPY wp-config.php /var/www/html/wp-config.php

COPY www.conf /etc/php/7.x/fpm/pool.d/www.conf

COPY	tools/setup.sh /bin/
RUN	chmod +x /bin/setup.sh

EXPOSE 9000

CMD		["setup.sh", "php-fpm7.4", "--nodaemonize"]
#CMD ["php-fpm7.4", "-F"]: Runs PHP-FPM in the foreground (the -F flag) as the main process in the container.
