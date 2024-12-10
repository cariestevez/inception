#!/bin/bash

# Check if WordPress is installed
if [ ! -f /var/www/wordpress/wp-config.php ]; then
  echo "WordPress not installed. Proceeding with installation..."

  # Install WordPress using WP-CLI
  cd /var/www/wordpress
  wp core download --path=/var/www/wordpress

  # Generate wp-config.php with environment variables
  wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${MYSQL_HOST} --path=/var/www/wordpress
  # wp db create
  # Run WordPress installation
  wp core install --url=${URL} --title=${TITLE} --admin_user=${ADMIN_USER} --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL} --path=/var/www/wordpress

  # Create another user (non-admin)
  wp user create ${USER_NAME} ${USER_EMAIL} --role=subscriber --user_pass=${USER_PASSWORD} --path=/var/www/wordpress

  echo "WordPress installation and user creation complete."
else
  echo "WordPress already installed."
fi

# Start PHP-FPM
exec /usr/sbin/php-fpm7.4 -F