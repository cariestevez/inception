FROM	debian:12.6

RUN	apt-get update -y  && \
    	apt-get upgrade -y && \
    	apt-get install --no-install-recommends --no-install-suggests -y \
    	ca-certificates \
    	php \
    	php-fpm \
    	php-mysql \
    	wget \
    	tar \
    	curl \
    	mariadb-client && \
    	rm -rf /var/lib/apt/lists/*

WORKDIR	/var/www/html

RUN	wget https://wordpress.org/wordpress-6.6.1.tar.gz && \
	tar -xzf wordpress-6.6.1.tar.gz && \
	rm wordpress-6.6.1.tar.gz
    	#mv wordpress /var/www/html

# Set proper file permissions to write on mounted volume
RUN	chown -R www-data:www-data /var/www/html
#RUN	chown -R root:root /var/www/wordpress
#    find /var/www/html/ -type d -exec chmod 755 {} \; && \
#    find /var/www/html/ -type f -exec chmod 644 {} \;

# Create a custom PHP-FPM configuration (optional)
#COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf


COPY	/conf/www.conf /etc/php-fpm.d/www.conf
COPY	/conf/wp-config.php /var/www/html/wp-config.php

COPY	tools/setup.sh /bin/
RUN	chmod +x /bin/setup.sh

EXPOSE	9000

CMD	["setup.sh", "php-fpm", "--nodaemonize"]
#CMD ["php-fpm7.4", "-F"]: Runs PHP-FPM in the foreground (the -F flag) as the main process in the container.
