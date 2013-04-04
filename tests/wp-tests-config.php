<?php
/* Path to the WordPress codebase you'd like to test. Add a backslash in the end. */
define( 'ABSPATH', 'D:/Dropbox/Code/_Tools/UniformServer/www/wordpress.dev/public_html/wp_3.5.1/' );

/* The name of the database for running the tests. Make sure this is a database just for testing as it's created and trashed during tests. */
define( 'DB_NAME', 'wp_unit_test' );

/* The usual credentials for a local database. */ 
define( 'DB_USER', 'root' );
define( 'DB_PASSWORD', 'root' );
define( 'DB_HOST', 'localhost' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

define( 'WPLANG', '' );
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_DISPLAY', true );

define( 'WP_TESTS_DOMAIN', 'wordpress.dev' );
define( 'WP_TESTS_EMAIL', 'artstorm@gmail.com' );
define( 'WP_TESTS_TITLE', 'Test Blog' );

/* Not worried about testing networks or subdomains, so setting to false. */ 
define( 'WP_TESTS_NETWORK_TITLE', 'Test Network' );
define( 'WP_TESTS_SUBDOMAIN_INSTALL', false );
$base = '/';

/* Cron tries to make an HTTP request to the blog, which always fails, because tests are run in CLI mode only */
if (!defined('DISABLE_WP_CRON')) {
    // define( 'DISABLE_WP_CRON', true );
}

define('WP_PLUGIN_DIR', 'D:\Dropbox\Code\WordPress');


/* Also not interested in testing multisite for this project, so setting to false. */ 
define( 'WP_ALLOW_MULTISITE', false );
if ( WP_ALLOW_MULTISITE ) {
    define( 'WP_TESTS_BLOGS', 'first,second,third,fourth' );
}
if ( WP_ALLOW_MULTISITE && !defined('WP_INSTALLING') ) {
    define( 'SUBDOMAIN_INSTALL', WP_TESTS_SUBDOMAIN_INSTALL );
    define( 'MULTISITE', true );
    define( 'DOMAIN_CURRENT_SITE', WP_TESTS_DOMAIN );
    define( 'PATH_CURRENT_SITE', '/' );
    define( 'SITE_ID_CURRENT_SITE', 1);
    define( 'BLOG_ID_CURRENT_SITE', 1);
    //define( 'SUNRISE', TRUE );
}

$table_prefix  = 'wp_';

define( 'WP_PHP_BINARY', 'php' );
