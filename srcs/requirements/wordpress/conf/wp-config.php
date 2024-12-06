<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', '${WORDPRESS_DB_NAME}');
define('DB_USER', '${WORDPRESS_DB_USER}');
define('DB_PASSWORD', '${WORDPRESS_DB_PASSWORD}');
define('DB_HOST', '${WORDPRESS_DB_HOST}');

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'hNk .__2,^!{MoXO)h)c^ZTFg.g75-R|K.V|FB{@X,ZiIj&zRpBd:g8~y- -U>b$');
define('SECURE_AUTH_KEY',  'Jcu3.{0d6=NTwzG3v/y0-GC,oQ^xj1v2r o)4]C+1?o}+WDb_Rm&Oms-%C%~--4{');
define('LOGGED_IN_KEY',    '73Wgd:yCg#N5HO3O.jV|SDgsl{GEMEOM1kI,$$~|</)|]#_.0Ae627K-OM+||2g|');
define('NONCE_KEY',        'q%L3_{cVxn7`k|i&):Ey|eO$v#c%_*+1n0=f6ZC/9UswPuXG[Ml-$Ify:[zK^vX>');
define('AUTH_SALT',        'j*_yXn#kS,@q35n}5%2i`Rz#X4]jj<r`I302%+>jQs|d(6Ku`Yp2F$ir2g2A6u-N');
define('SECURE_AUTH_SALT', 'lfZ)9ncTrw0zsNRAkDH+b +&+n?gtD(v-Bs$Pz+^6`4;$^!q,/sJG[WW|c2Vy%=;');
define('LOGGED_IN_SALT',   '9<W~4xAU|d0E*&BV89[vZDkC0o6,<>PU%cNN[BmQJ*-y;P`zT:uDtt-~T)u0PP8?');
define('NONCE_SALT',       'o7rmMh1Hr];UqY+i~W2lp SQe-eILI|B-u^i){?$Yx~_x-9Fp0U7pdRQ!RM>-viC');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 *
 * At the installation time, database tables are created with the specified prefix.
 * Changing this value after WordPress is installed will make your site think
 * it has not been installed.
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/#table-prefix
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
@ini_set( 'log_errors', 'Off' );
@ini_set( 'display_errors', 'On' );
define( 'WP_DISABLE_FATAL_ERROR_HANDLER', true );
// Enable WP_DEBUG mode
define( 'WP_DEBUG', true );
// Enable Debug logging to the /wp-content/debug.log file
define( 'WP_DEBUG_LOG', true );
// Disable display of errors and warnings
define( 'WP_DEBUG_DISPLAY', true );

/* Add any custom values between this line and the "stop editing" line. */

// define( 'WP_SITEURL', 'https://' . $_SERVER['HTTP_HOST'] . '/var/www/html/wordpress' );
// // or
// //define( 'WP_SITEURL', 'https://' . $_SERVER['SERVER_NAME'] . '/path/to/wordpress' );
// define( 'WP_HOME', 'https://' . $_SERVER['HTTP_HOST'] . '/path/to/wordpress' );


/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';