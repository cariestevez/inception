#!/bin/bash
# setup.sh

DB_NAME=${WORDPRESS_DB_NAME:-wordpress}
DB_USER=${WORDPRESS_DB_USER:-wp_user}
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_HOST=${WORDPRESS_DB_HOST:-mariadb:3306}
DB_PREFIX=${WORDPRESS_DB_PREFIX:-wp_}
DB_CHARSET=${WORDPRESS_DB_CHARSET:-utf8}
DB_COLLATE=${WORDPRESS_DB_COLLATE:-}
#SECRET_KEY=$(cat /run/secrets/wp_secret_key)
AUTH_KEY=${WP_AUTH_KEY}
SECURE_AUTH_KEY=${WP_SECURE_AUTH_KEY}
LOGGED_IN_KEY=${WP_LOGGED_IN_KEY}
NONCE_KEY=${WP_NONCE_KEY}
AUTH_SALT=${WP_AUTH_SALT}
SECURE_AUTH_SALT=${WP_SECURE_AUTH_SALT}
LOGGED_IN_SALT=${WP_LOGGED_IN_SALT}
NONCE_SALT=${WP_NONCE_SALT}


# Check if wp-config.php exists, if not, create it
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating wp-config.php..."

    # Create the wp-config.php file
    cat > /var/www/html/wp-config.php <<EOF
<?php
define( 'DB_NAME', '${DB_NAME}' );
define( 'DB_USER', '${DB_USER}' );
define( 'DB_PASSWORD', '${DB_PASSWORD}' );
define( 'DB_HOST', '${DB_HOST}' );
define( 'DB_CHARSET', '${DB_CHARSET}' );
define( 'DB_COLLATE', '${DB_COLLATE}' );
\$table_prefix = '${DB_PREFIX}';

define( 'AUTH_KEY', '${AUTH_KEY}' );
define( 'SECURE_AUTH_KEY', '${SECURE_AUTH_KEY}' );
define( 'LOGGED_IN_KEY', '${LOGGED_IN_KEY}' );
define( 'NONCE_KEY', '${NONCE_KEY}' );
define( 'AUTH_SALT', '${AUTH_SALT}' );
define( 'SECURE_AUTH_SALT', '${SECURE_AUTH_SALT}' );
define( 'LOGGED_IN_SALT', '${LOGGED_IN_SALT}' );
define( 'NONCE_SALT', '${NONCE_SALT}' );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
EOF
    echo "wp-config.php created."
fi

# Set appropriate file permissions for WordPress
chown -R www-data:www-data /var/www/html
find /var/www/html/ -type d -exec chmod 755 {} \;
find /var/www/html/ -type f -exec chmod 644 {} \;

# Start PHP-FPM
echo "Starting PHP-FPM..."
exec "$@"

