<?php

declare(strict_types=1);

// Enable CORS
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Content-Type: application/json');

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Load configuration and classes
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/Database.php';
require_once __DIR__ . '/BaseGateway.php';
require_once __DIR__ . '/OAuth.php';

// Autoload gateway classes
spl_autoload_register(function ($className) {
    $file = __DIR__ . '/gateways/' . $className . '.php';
    if (file_exists($file)) {
        require_once $file;
    }
});

// Handle OAuth token endpoint
if ($_SERVER['REQUEST_URI'] === '/oauth/token' || strpos($_SERVER['REQUEST_URI'], '/oauth/token') !== false) {
    OAuth::handleTokenRequest();
    exit;
}

// Validate OAuth token for all other endpoints
if (!OAuth::validateToken()) {
    exit;
}

// Parse the request
$requestMethod = $_SERVER['REQUEST_METHOD'];
$requestUri = $_SERVER['REQUEST_URI'];

// Remove query string
$uriParts = explode('?', $requestUri);
$path = $uriParts[0];

// Remove leading/trailing slashes and split into segments
$segments = array_filter(explode('/', trim($path, '/')));
$segments = array_values($segments);

// Route mapping: table name => Gateway class
$routeMap = [
    'attendee' => 'AttendeeGateway',
    'attendee_seloption' => 'AttendeeSeloptionGateway',
    'attendee_seloption_extrainfo' => 'AttendeeSeloptionExtrainfoGateway',
    'attendeereg_couponcode' => 'AttendeeregCouponcodeGateway',
    'attendeereg_demog_answer' => 'AttendeeregDemogAnswerGateway',
    'attendeereg_demog_answersub' => 'AttendeeregDemogAnswersubGateway',
    'attendeereg_demog_question' => 'AttendeeregDemogQuestionGateway',
    'attendeereg_option' => 'AttendeeregOptionGateway',
    'attendeereg_optiongroup' => 'AttendeeregOptiongroupGateway',
    'booth' => 'BoothGateway',
    'boothapp' => 'BoothappGateway',
    'boothapp_selection' => 'BoothappSelectionGateway',
    'client' => 'ClientGateway',
    'event' => 'EventGateway',
    'event_badgetemplate' => 'EventBadgetemplateGateway',
    'event_checkin_cfg' => 'EventCheckinCfgGateway',
    'event_gate' => 'EventGateGateway',
    'event_gate_log' => 'EventGateLogGateway',
    'exhibitor' => 'ExhibitorGateway',
    'exhibitor_invite' => 'ExhibitorInviteGateway',
    'exhibitor_invoice' => 'ExhibitorInvoiceGateway',
    'exhibitor_product' => 'ExhibitorProductGateway',
    'exhibitor_productcat' => 'ExhibitorProductcatGateway',
    'linker_exhibitor_product' => 'LinkerExhibitorProductGateway',
    'lookup_attendeecompany' => 'LookupAttendeecompanyGateway',
    'lookup_attendeecompany_import' => 'LookupAttendeecompanyImportGateway',
    'lookup_country' => 'LookupCountryGateway',
    'lookup_state' => 'LookupStateGateway',
    'redirecturl' => 'RedirecturlGateway',
    'sponsorship' => 'SponsorshipGateway',
    'sponsorship_purchase' => 'SponsorshipPurchaseGateway',
    'trackresendreceiptemail' => 'TrackresendreceiptemailGateway',
    'trackroutingcode_codes' => 'TrackroutingcodeCodesGateway',
    'trackroutingcode_usage' => 'TrackroutingcodeUsageGateway',
    'transaction' => 'TransactionGateway'
];

// Simple router
try {
    // API info endpoint
    if (empty($segments) || $segments[0] === '') {
        http_response_code(200);
        echo json_encode([
            'api' => 'eLand Registration API',
            'version' => API_VERSION,
            'status' => 'active',
            'endpoints' => array_keys($routeMap),
            'authentication' => 'OAuth 2.0 Client Credentials',
            'documentation' => 'See README.md for details'
        ]);
        exit;
    }

    $resource = $segments[0] ?? null;
    $id = isset($segments[1]) ? (int) $segments[1] : null;

    // Check if resource exists
    if (!isset($routeMap[$resource])) {
        http_response_code(404);
        echo json_encode([
            'error' => 'Resource not found',
            'message' => "The resource '{$resource}' does not exist"
        ]);
        exit;
    }

    $gatewayClass = $routeMap[$resource];
    $database = new Database();
    $gateway = new $gatewayClass($database);

    // Handle different HTTP methods
    switch ($requestMethod) {
        case 'GET':
            if ($id !== null) {
                // GET single record by ID
                $result = $gateway->getById($id);
                if ($result === null) {
                    http_response_code(404);
                    echo json_encode([
                        'error' => 'Not found',
                        'message' => "Record with ID {$id} not found"
                    ]);
                } else {
                    http_response_code(200);
                    echo json_encode($result);
                }
            } else {
                // GET all records with optional filtering
                $filters = [];
                $limit = isset($_GET['limit']) ? (int) $_GET['limit'] : 1000;
                $offset = isset($_GET['offset']) ? (int) $_GET['offset'] : 0;

                // Build filters from query parameters
                foreach ($_GET as $key => $value) {
                    if (!in_array($key, ['limit', 'offset'])) {
                        $filters[$key] = $value;
                    }
                }

                $results = $gateway->getAll($filters, $limit, $offset);
                $total = $gateway->getCount($filters);

                http_response_code(200);
                echo json_encode([
                    'data' => $results,
                    'total' => $total,
                    'limit' => $limit,
                    'offset' => $offset
                ]);
            }
            break;

        case 'POST':
            // CREATE new record
            $input = json_decode(file_get_contents('php://input'), true);
            
            if (json_last_error() !== JSON_ERROR_NONE) {
                http_response_code(400);
                echo json_encode([
                    'error' => 'Invalid JSON',
                    'message' => 'Request body must be valid JSON'
                ]);
                break;
            }

            if (empty($input)) {
                http_response_code(400);
                echo json_encode([
                    'error' => 'Empty payload',
                    'message' => 'Request body cannot be empty'
                ]);
                break;
            }

            $newId = $gateway->create($input);
            $newRecord = $gateway->getById($newId);

            http_response_code(201);
            echo json_encode([
                'message' => 'Record created successfully',
                'id' => $newId,
                'data' => $newRecord
            ]);
            break;

        case 'PUT':
            // UPDATE existing record
            if ($id === null) {
                http_response_code(400);
                echo json_encode([
                    'error' => 'Bad request',
                    'message' => 'ID is required for update'
                ]);
                break;
            }

            $input = json_decode(file_get_contents('php://input'), true);
            
            if (json_last_error() !== JSON_ERROR_NONE) {
                http_response_code(400);
                echo json_encode([
                    'error' => 'Invalid JSON',
                    'message' => 'Request body must be valid JSON'
                ]);
                break;
            }

            if (empty($input)) {
                http_response_code(400);
                echo json_encode([
                    'error' => 'Empty payload',
                    'message' => 'Request body cannot be empty'
                ]);
                break;
            }

            $updated = $gateway->update($id, $input);
            
            if ($updated) {
                $updatedRecord = $gateway->getById($id);
                http_response_code(200);
                echo json_encode([
                    'message' => 'Record updated successfully',
                    'id' => $id,
                    'data' => $updatedRecord
                ]);
            } else {
                http_response_code(404);
                echo json_encode([
                    'error' => 'Not found',
                    'message' => "Record with ID {$id} not found or no changes made"
                ]);
            }
            break;

        case 'DELETE':
            // SOFT DELETE record
            if ($id === null) {
                http_response_code(400);
                echo json_encode([
                    'error' => 'Bad request',
                    'message' => 'ID is required for delete'
                ]);
                break;
            }

            $deleted = $gateway->delete($id);
            
            if ($deleted) {
                http_response_code(200);
                echo json_encode([
                    'message' => 'Record deleted successfully',
                    'id' => $id
                ]);
            } else {
                http_response_code(404);
                echo json_encode([
                    'error' => 'Not found',
                    'message' => "Record with ID {$id} not found"
                ]);
            }
            break;

        default:
            http_response_code(405);
            echo json_encode([
                'error' => 'Method not allowed',
                'message' => "HTTP method {$requestMethod} is not supported"
            ]);
            break;
    }

} catch (PDOException $e) {
    error_log('Database error: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'error' => 'Database error',
        'message' => 'An error occurred while processing your request'
    ]);
} catch (Exception $e) {
    error_log('General error: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'error' => 'Internal server error',
        'message' => 'An unexpected error occurred'
    ]);
}
