<?php

declare(strict_types=1);

// Database Configuration
define('DB_CONFIG', [
    'host'   => '127.0.0.1',
    'db'     => 'elandus_registration',
    'user'   => 'devRoot',
    'pass'   => 'devPass$_2023',
    'port'   => '3306',
    'charset'=> 'utf8mb4'
]);

// OAuth 2.0 Configuration - Client Credentials
define('OAUTH_CLIENTS', [
    'client_id_001' => [
        'client_secret' => 'secret_key_12345_CHANGE_IN_PRODUCTION',
        'grant_types' => ['client_credentials'],
        'scope' => 'read write'
    ]
]);

// Token expiration time (in seconds) - 1 hour
define('TOKEN_EXPIRATION', 3600);

// API Configuration
define('API_VERSION', 'v1');
define('TIMEZONE', 'America/New_York');

// Set timezone
date_default_timezone_set(TIMEZONE);

// Error reporting (disable in production)
error_reporting(E_ALL);
ini_set('display_errors', '0');
ini_set('log_errors', '1');
ini_set('error_log', __DIR__ . '/logs/php_errors.log');
