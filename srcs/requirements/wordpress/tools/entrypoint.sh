#!/bin/bash

# Check if WordPress is installed
if [ ! -f /var/www/wordpress/wp-config.php ]; then
  echo "WordPress not installed. Proceeding with installation..."

  # Install WordPress using WP-CLI
  # cd /var/www/wordpress
  wp core download --path=/var/www/wordpress --allow-root

  # Generate wp-config.php with environment variables
  wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${MYSQL_HOST} --path=/var/www/wordpress --allow-root
  # wp db create
  # Run WordPress installation
  wp core install --url=${URL} --title=${TITLE} --admin_user=${ADMIN_USER} --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL} --path=/var/www/wordpress --allow-root

  # Create another user (non-admin)
  wp user create ${USER_NAME} ${USER_EMAIL} --role=subscriber --user_pass=${USER_PASSWORD} --path=/var/www/wordpress --allow-root

  echo "WordPress installation and user creation complete."
else
  echo "WordPress already installed."
fi

# Start PHP-FPM
exec /usr/sbin/php-fpm7.4 -F

# #!/bin/bash

# set -e
# set -x

# # Wait for the database to be ready
# until mysqladmin ping -h"$DB_HOST" --silent; do
#     echo "Waiting for database connection..."
#     sleep 3
# done

# # Check if WordPress is installed
# if [ ! -f /var/www/wordpress/wp-config.php ]; then
#     echo "WordPress not installed. Proceeding with installation..."

#     # Download WordPress
#     wp core download --path=/var/www/wordpress --allow-root

#     # Generate wp-config.php
#     wp config create \
#         --dbname="${DB_NAME}" \
#         --dbuser="${DB_USER}" \
#         --dbpass="${DB_PASSWORD}" \
#         --dbhost="${DB_HOST}" \
#         --path=/var/www/wordpress \
#         --allow-root

#     # Run the WordPress installation
#     wp core install \
#         --url="${URL}" \
#         --title="${TITLE}" \
#         --admin_user="${ADMIN_USER}" \
#         --admin_password="${ADMIN_PASSWORD}" \
#         --admin_email="${ADMIN_EMAIL}" \
#         --path=/var/www/wordpress \
#         --allow-root

#     # Create an additional user
#     wp user create \
#         "${USER_NAME}" "${USER_EMAIL}" \
#         --role=subscriber \
#         --user_pass="${USER_PASSWORD}" \
#         --path=/var/www/wordpress \
#         --allow-root

#     echo "WordPress installation complete."
# else
#     echo "WordPress already installed."
# fi

# # Start PHP-FPM
# exec /usr/sbin/php-fpm7.4 -F
