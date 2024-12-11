#!/bin/bash
# setup.sh

DB_NAME=${DB_NAME}
DB_USER=${DB_USER}
DB_PASSWORD=${DB_PASSWORD}
DB_HOST=${WP_DB_HOST:-mariadb:3306}
DB_PREFIX=${WP_DB_PREFIX:-wp_}
DB_CHARSET=${WP_DB_CHARSET:-utf8}
DB_COLLATE=${WP_DB_COLLATE:-}
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

# Run the WordPress CLI to set up the site if it hasn't been set up already
if ! $(wp core is-installed --allow-root); then
    wp core install --url="${DOMAIN_NAME}" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --allow-root

    # Create an additional user if needed
    wp user create ${WP_USER} ${WP_USER_EMAIL} --role=author --user_pass=${WP_USER_PASSWORD} --allow-root
fi

# Start PHP-FPM
echo "Starting PHP-FPM..."
exec "$@"

