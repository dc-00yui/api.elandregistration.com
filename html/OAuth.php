<?php

declare(strict_types=1);

class OAuth
{
    private static array $tokens = [];

    /**
     * Handle OAuth 2.0 Token Request (Client Credentials Flow)
     */
    public static function handleTokenRequest(): void
    {
        header('Content-Type: application/json');

        $grantType = $_POST['grant_type'] ?? '';
        $clientId = $_POST['client_id'] ?? '';
        $clientSecret = $_POST['client_secret'] ?? '';

        if ($grantType !== 'client_credentials') {
            http_response_code(400);
            echo json_encode([
                'error' => 'unsupported_grant_type',
                'error_description' => 'Only client_credentials grant type is supported'
            ]);
            return;
        }

        if (!isset(OAUTH_CLIENTS[$clientId])) {
            http_response_code(401);
            echo json_encode([
                'error' => 'invalid_client',
                'error_description' => 'Client authentication failed'
            ]);
            return;
        }

        $client = OAUTH_CLIENTS[$clientId];

        if ($client['client_secret'] !== $clientSecret) {
            http_response_code(401);
            echo json_encode([
                'error' => 'invalid_client',
                'error_description' => 'Client authentication failed'
            ]);
            return;
        }

        // Generate access token
        $accessToken = self::generateToken();
        $expiresIn = TOKEN_EXPIRATION;

        // Store token in memory (in production, use Redis or database)
        self::$tokens[$accessToken] = [
            'client_id' => $clientId,
            'scope' => $client['scope'],
            'expires_at' => time() + $expiresIn
        ];

        http_response_code(200);
        echo json_encode([
            'access_token' => $accessToken,
            'token_type' => 'Bearer',
            'expires_in' => $expiresIn,
            'scope' => $client['scope']
        ]);
    }

    /**
     * Validate Bearer Token
     */
    public static function validateToken(): bool
    {
        $authHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? '';

        if (empty($authHeader)) {
            self::sendUnauthorized('Missing authorization header');
            return false;
        }

        if (!preg_match('/Bearer\s+(.*)$/i', $authHeader, $matches)) {
            self::sendUnauthorized('Invalid authorization header format');
            return false;
        }

        $token = $matches[1];

        // In production, validate against database or Redis
        // For now, we'll accept any token that matches our pattern
        if (strlen($token) < 32) {
            self::sendUnauthorized('Invalid token');
            return false;
        }

        return true;
    }

    /**
     * Generate a random access token
     */
    private static function generateToken(): string
    {
        return bin2hex(random_bytes(32));
    }

    /**
     * Send unauthorized response
     */
    private static function sendUnauthorized(string $message): void
    {
        http_response_code(401);
        header('Content-Type: application/json');
        echo json_encode([
            'error' => 'unauthorized',
            'message' => $message
        ]);
        exit;
    }
}
