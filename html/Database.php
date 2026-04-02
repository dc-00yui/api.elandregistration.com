<?php

declare(strict_types=1);

class Database
{
    private ?PDO $connection = null;

    public function __construct()
    {
        $config = DB_CONFIG;
        
        $dsn = sprintf(
            'mysql:host=%s;port=%s;dbname=%s;charset=%s',
            $config['host'],
            $config['port'],
            $config['db'],
            $config['charset']
        );

        try {
            $this->connection = new PDO($dsn, $config['user'], $config['pass'], [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
                PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4"
            ]);
        } catch (PDOException $e) {
            error_log('Database connection failed: ' . $e->getMessage());
            http_response_code(500);
            echo json_encode([
                'error' => 'Database connection failed',
                'message' => 'Unable to connect to the database server'
            ]);
            exit;
        }
    }

    public function getConnection(): PDO
    {
        return $this->connection;
    }

    public function disconnect(): void
    {
        $this->connection = null;
    }
}
