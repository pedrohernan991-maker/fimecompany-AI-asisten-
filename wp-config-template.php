<?php
/**
 * Configuración de WordPress para FimeCompany
 * 
 * Este archivo contiene las configuraciones básicas de WordPress.
 * 
 * @package FimeCompany
 * @version 1.0.0
 */

// ** Configuración de la base de datos ** //
define('DB_NAME', 'fimecompany_db');
define('DB_USER', 'fimecompany_user');
define('DB_PASSWORD', 'password_seguro_aqui');
define('DB_HOST', 'localhost');
define('DB_CHARSET', 'utf8mb4');
define('DB_COLLATE', '');

// ** Claves únicas de autenticación ** //
define('AUTH_KEY',         'clave_auth_unica_aqui');
define('SECURE_AUTH_KEY',  'clave_secure_auth_unica_aqui');
define('LOGGED_IN_KEY',    'clave_logged_in_unica_aqui');
define('NONCE_KEY',        'clave_nonce_unica_aqui');
define('AUTH_SALT',        'salt_auth_unico_aqui');
define('SECURE_AUTH_SALT', 'salt_secure_auth_unico_aqui');
define('LOGGED_IN_SALT',   'salt_logged_in_unico_aqui');
define('NONCE_SALT',       'salt_nonce_unico_aqui');

// ** Configuración de URLs ** //
define('WP_HOME', 'https://fimecompany.com');
define('WP_SITEURL', 'https://fimecompany.com');

// ** Configuración de seguridad ** //
define('DISALLOW_FILE_EDIT', true);
define('WP_DEBUG', false);
define('WP_DEBUG_LOG', false);
define('WP_DEBUG_DISPLAY', false);

// ** Configuración de memoria ** //
define('WP_MEMORY_LIMIT', '256M');

// ** Configuración de archivos ** //
define('FS_METHOD', 'direct');

// ** Configuración de cache ** //
define('WP_CACHE', true);

// ** Configuración de SSL ** //
define('FORCE_SSL_ADMIN', true);

// ** Configuración de actualizaciones automáticas ** //
define('WP_AUTO_UPDATE_CORE', 'minor');

// ** Configuración de compresión ** //
define('COMPRESS_CSS', true);
define('COMPRESS_SCRIPTS', true);

// ** Configuración de base de datos ** //
$table_prefix = 'wp_';

// ** Configuración de WordPress ** //
if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

require_once ABSPATH . 'wp-settings.php';
