#!/bin/bash
# Print commands and arguments for debugging
set -e
set -x

# Download and configure WordPress if not installed yet
if [ ! -f /var/www/wordpress/wp-config.php ]; then
  echo "WordPress not installed. Proceeding with installation..."

  wp core download --path=/var/www/wordpress --allow-root

  # Generate wp-config.php
  mv /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
  wp config set DB_NAME $DB_NAME --allow-root --path=/var/www/wordpress/
  wp config set DB_USER $DB_USER --allow-root --path=/var/www/wordpress/
  wp config set DB_PASSWORD $DB_PASSWORD --allow-root --path=/var/www/wordpress/
  wp config set DB_HOST $DB_HOST --allow-root --path=/var/www/wordpress/

  # Run installation and create admin user
  wp core install --url=$URL --title=$TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --path=/var/www/wordpress --allow-root

  # Create another (non-admin) user
  wp user create $USER_NAME $USER_EMAIL --role=subscriber --user_pass=$USER_PASSWORD --path=/var/www/wordpress --allow-root

  # Personalize appearance and content
  #wp theme install twentytwentyfour --activate --allow-root --path=/var/www/wordpress
  wp option update blogdescription "Welcome! :)" --allow-root --path=/var/www/wordpress
  wp post create --post_type=post --post_title='Dear 42 fellow' --post_content='All you have to do is enjoy my explanation and click yes on the evaluation sheet. I am happy to answer all your questions' --post_status=publish --allow-root --path=/var/www/wordpress


  echo "WordPress installation and user creation complete."
else
  echo "WordPress already installed."
fi

exec /usr/sbin/php-fpm7.4 -F