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
    	apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
    
WORKDIR	/var/www/html

RUN	wget https://wordpress.org/wordpress-6.6.1.tar.gz && \
	tar -xzf wordpress-6.6.1.tar.gz && \
	rm wordpress-6.6.1.tar.gz

# Set proper file permissions to write on mounted volume
RUN	chown -R www-data:www-data /var/www/html \
	&& chmod -R 755 /var/www/html

COPY	/conf/www.conf /etc/php-fpm.d/www.conf

COPY	tools/setup.sh /usr/local/bin/setup.sh
RUN	chmod +x /usr/local/bin/setup.sh

# Make PHP-FPM listen on all IPs
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/' /usr/local/etc/php-fpm.d/zz-docker.conf

EXPOSE	9000

ENTRYPOINT ["/usr/local/bin/setup.sh"]

CMD ["php-fpm"]
