# eLand Registration API - Construction Instructions

This document provides step-by-step instructions for replicating the construction of the eLand Registration RESTful API.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Database Preparation](#database-preparation)
3. [Directory Structure Setup](#directory-structure-setup)
4. [Core Files Creation](#core-files-creation)
5. [Gateway Classes Creation](#gateway-classes-creation)
6. [Testing the API](#testing-the-api)
7. [Security Considerations](#security-considerations)

---

## Prerequisites

### Server Requirements
- **PHP Version**: 7.4.33
- **MySQL Version**: 5.x
- **Web Server**: IIS with URL Rewrite module or Apache with mod_rewrite
- **PHP Extensions**: 
  - PDO
  - PDO_MySQL
  - JSON
  - OpenSSL

### Database Access
- Host: `127.0.0.1`
- Port: `3306`
- Database: `elandus_registration`
- Username: `devRoot`
- Password: `devPass$_2023`

---

## Database Preparation

### Step 1: Apply Soft Delete Migration

Before using the API, you must add the soft delete functionality to all database tables.

1. Open the SQL script: `soft_delete_migration.sql`
2. Review the script to ensure it matches your database structure
3. Execute the script against the `elandus_registration` database:

```bash
mysql -u devRoot -p elandus_registration < soft_delete_migration.sql
```

Or use a GUI tool like MySQL Workbench, phpMyAdmin, or HeidiSQL.

4. Verify the migration by running:

```sql
SELECT TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'elandus_registration'
AND COLUMN_NAME = 'deleted_at'
ORDER BY TABLE_NAME;
```

You should see 35 rows (one for each table).

---

## Directory Structure Setup

### Step 2: Create Directory Structure

Create the following directory structure in `C:\inetpub\wwwroot\api.elandregistration.com\html`:

```
html/
├── index.php                    # Main router/entry point
├── config.php                   # Configuration file
├── Database.php                 # Database connection class
├── BaseGateway.php             # Base CRUD operations class
├── OAuth.php                    # OAuth 2.0 authentication handler
├── .htaccess                    # URL rewrite rules (if using Apache)
├── web.config                   # URL rewrite rules (if using IIS)
├── soft_delete_migration.sql   # Database migration script
├── gateways/                    # Directory for gateway classes
│   ├── AttendeeGateway.php
│   ├── AttendeeSeloptionGateway.php
│   ├── AttendeeSeloptionExtrainfoGateway.php
│   ├── AttendeeregCouponcodeGateway.php
│   ├── AttendeeregDemogAnswerGateway.php
│   ├── AttendeeregDemogAnswersubGateway.php
│   ├── AttendeeregDemogQuestionGateway.php
│   ├── AttendeeregOptionGateway.php
│   ├── AttendeeregOptiongroupGateway.php
│   ├── BoothGateway.php
│   ├── BoothappGateway.php
│   ├── BoothappSelectionGateway.php
│   ├── ClientGateway.php
│   ├── EventGateway.php
│   ├── EventBadgetemplateGateway.php
│   ├── EventCheckinCfgGateway.php
│   ├── EventGateGateway.php
│   ├── EventGateLogGateway.php
│   ├── ExhibitorGateway.php
│   ├── ExhibitorInviteGateway.php
│   ├── ExhibitorInvoiceGateway.php
│   ├── ExhibitorProductGateway.php
│   ├── ExhibitorProductcatGateway.php
│   ├── LinkerExhibitorProductGateway.php
│   ├── LookupAttendeecompanyGateway.php
│   ├── LookupAttendeecompanyImportGateway.php
│   ├── LookupCountryGateway.php
│   ├── LookupStateGateway.php
│   ├── RedirecturlGateway.php
│   ├── SponsorshipGateway.php
│   ├── SponsorshipPurchaseGateway.php
│   ├── TrackresendreceiptemailGateway.php
│   ├── TrackroutingcodeCodesGateway.php
│   ├── TrackroutingcodeUsageGateway.php
│   └── TransactionGateway.php
└── logs/                        # Directory for error logs (create manually)
    └── php_errors.log
```

### Step 3: Create Logs Directory

```bash
mkdir C:\inetpub\wwwroot\api.elandregistration.com\html\logs
```

Ensure the web server has write permissions to this directory.

---

## Core Files Creation

### Step 4: Create config.php

This file contains database credentials and OAuth configuration.

**Key Configuration Items:**
- Database connection details
- OAuth client credentials (hardcoded for initial setup)
- Token expiration time (default: 1 hour)
- Timezone settings

**Security Note:** In production, move this file outside the web root or restrict access via web server configuration.

### Step 5: Create Database.php

This class handles the PDO database connection with:
- PDO with prepared statements (SQL injection prevention)
- Error handling with try-catch blocks
- Connection settings optimized for MySQL 5.x

### Step 6: Create BaseGateway.php

This abstract class provides:
- `getAll()` - Retrieve multiple records with filtering, pagination, and soft delete filtering
- `getById()` - Retrieve single record by ID
- `create()` - Insert new record with automatic timestamp
- `update()` - Update existing record with automatic timestamp
- `delete()` - Soft delete (sets deleted_at timestamp)
- `getCount()` - Get total count for pagination

### Step 7: Create OAuth.php

This class implements OAuth 2.0 Client Credentials Flow:
- `handleTokenRequest()` - Issue access tokens
- `validateToken()` - Validate Bearer tokens on API requests
- Token generation using cryptographically secure random bytes

---

## Gateway Classes Creation

### Step 8: Create Individual Gateway Classes

For each of the 35 database tables, create a Gateway class that extends `BaseGateway`.

**Template:**
```php
<?php

declare(strict_types=1);

class TableNameGateway extends BaseGateway
{
    protected string $table = 'table_name';
    protected string $primaryKey = 'ID';
}
```

**List of Gateway Classes:**
1. AttendeeGateway
2. AttendeeSeloptionGateway
3. AttendeeSeloptionExtrainfoGateway
4. AttendeeregCouponcodeGateway
5. AttendeeregDemogAnswerGateway
6. AttendeeregDemogAnswersubGateway
7. AttendeeregDemogQuestionGateway
8. AttendeeregOptionGateway
9. AttendeeregOptiongroupGateway
10. BoothGateway
11. BoothappGateway
12. BoothappSelectionGateway
13. ClientGateway
14. EventGateway
15. EventBadgetemplateGateway
16. EventCheckinCfgGateway
17. EventGateGateway
18. EventGateLogGateway
19. ExhibitorGateway
20. ExhibitorInviteGateway
21. ExhibitorInvoiceGateway
22. ExhibitorProductGateway
23. ExhibitorProductcatGateway
24. LinkerExhibitorProductGateway
25. LookupAttendeecompanyGateway
26. LookupAttendeecompanyImportGateway
27. LookupCountryGateway
28. LookupStateGateway
29. RedirecturlGateway
30. SponsorshipGateway
31. SponsorshipPurchaseGateway
32. TrackresendreceiptemailGateway
33. TrackroutingcodeCodesGateway
34. TrackroutingcodeUsageGateway
35. TransactionGateway

### Step 9: Create index.php (Main Router)

This is the main entry point that:
- Handles CORS headers
- Routes OAuth token requests to `OAuth::handleTokenRequest()`
- Validates Bearer tokens for all other requests
- Routes requests to appropriate Gateway classes
- Handles HTTP methods (GET, POST, PUT, DELETE)
- Returns JSON responses with appropriate HTTP status codes

### Step 10: Create .htaccess (Apache) or web.config (IIS)

**For IIS (web.config):**
Create a URL rewrite rule to route all requests to index.php.

**For Apache (.htaccess):**
Already created with mod_rewrite rules.

---

## Testing the API

### Step 11: Obtain an Access Token

```bash
POST http://api.elandregistration.com/oauth/token
Content-Type: application/x-www-form-urlencoded

grant_type=client_credentials&client_id=client_id_001&client_secret=secret_key_12345_CHANGE_IN_PRODUCTION
```

**Response:**
```json
{
  "access_token": "abc123...",
  "token_type": "Bearer",
  "expires_in": 3600,
  "scope": "read write"
}
```

### Step 12: Test API Endpoints

**Get All Attendees:**
```bash
GET http://api.elandregistration.com/attendee
Authorization: Bearer YOUR_ACCESS_TOKEN
```

**Get Single Attendee:**
```bash
GET http://api.elandregistration.com/attendee/123
Authorization: Bearer YOUR_ACCESS_TOKEN
```

**Create Attendee:**
```bash
POST http://api.elandregistration.com/attendee
Authorization: Bearer YOUR_ACCESS_TOKEN
Content-Type: application/json

{
  "fname": "John",
  "lname": "Doe",
  "email": "john.doe@example.com",
  "event": 1
}
```

**Update Attendee:**
```bash
PUT http://api.elandregistration.com/attendee/123
Authorization: Bearer YOUR_ACCESS_TOKEN
Content-Type: application/json

{
  "fname": "Jane",
  "lname": "Smith"
}
```

**Delete Attendee (Soft Delete):**
```bash
DELETE http://api.elandregistration.com/attendee/123
Authorization: Bearer YOUR_ACCESS_TOKEN
```

---

## Security Considerations

### For Production Deployment:

1. **Change OAuth Client Credentials**
   - Update `OAUTH_CLIENTS` in `config.php` with secure credentials
   - Use environment variables instead of hardcoding

2. **Disable Error Display**
   - Already configured in `config.php`: `ini_set('display_errors', '0')`

3. **Enable HTTPS**
   - Configure SSL certificate on IIS
   - Force HTTPS redirects

4. **Implement Token Storage**
   - Replace in-memory token storage with Redis or database
   - Add token expiration validation

5. **Add Rate Limiting**
   - Implement request throttling per client

6. **Database User Permissions**
   - Create a dedicated database user with limited permissions
   - Do not use root credentials in production

7. **File Permissions**
   - Restrict access to `config.php`
   - Ensure logs directory is not web-accessible

8. **Input Validation**
   - Add additional validation for input data
   - Implement field-level validation rules

9. **Audit Logging**
   - Log all API access attempts
   - Track who created/modified/deleted records

10. **CORS Configuration**
    - Restrict `Access-Control-Allow-Origin` to specific domains
    - Currently set to `*` for development

---

## Architecture Overview

### Request Flow:

1. **Client Request** → Web Server (IIS/Apache)
2. **URL Rewrite** → Routes to `index.php`
3. **OAuth Validation** → Validates Bearer token
4. **Router** → Determines resource and method
5. **Gateway Class** → Executes CRUD operation
6. **Database** → PDO executes prepared statement
7. **Response** → JSON returned to client

### Key Design Patterns:

- **Gateway Pattern**: Each table has a Gateway class for data access
- **Dependency Injection**: Database connection injected into gateways
- **Repository Pattern**: BaseGateway provides reusable CRUD operations
- **Single Responsibility**: Each class has one clear purpose

### PHP 7.4 Features Used:

- **Typed Properties**: Classes use type declarations (e.g., `protected string $table`)
- **Strict Types**: All files use `declare(strict_types=1);`
- **Null Coalescing**: Used for safe default values
- **Arrow Functions**: Used in array mapping operations

---

## Troubleshooting

### Common Issues:

1. **Database Connection Failed**
   - Verify MySQL service is running
   - Check credentials in `config.php`
   - Ensure database exists

2. **404 Not Found**
   - Verify URL rewrite is configured
   - Check IIS URL Rewrite module is installed
   - Review web server error logs

3. **401 Unauthorized**
   - Verify Bearer token is included in Authorization header
   - Check token hasn't expired
   - Ensure OAuth endpoint is accessible

4. **500 Internal Server Error**
   - Check `logs/php_errors.log` for details
   - Verify file permissions
   - Ensure all required PHP extensions are loaded

5. **JSON Parse Error**
   - Verify request body is valid JSON
   - Check Content-Type header is set to `application/json`

---

## Next Steps

1. **Convert to Stored Procedures**: Replace inline SQL with stored procedures for better performance and security
2. **Implement Scoped Access**: Add client-specific access controls
3. **Add Validation Rules**: Implement field-level validation for each table
4. **Create Admin Interface**: Build administrative tools for managing OAuth clients
5. **Add Monitoring**: Implement logging and monitoring solutions
6. **Performance Optimization**: Add caching layer (Redis/Memcached)
7. **API Documentation**: Generate interactive API documentation (Swagger/OpenAPI)

---

## Maintenance

### Regular Tasks:

- Monitor `logs/php_errors.log` for errors
- Review access patterns and optimize slow queries
- Rotate access tokens periodically
- Keep PHP and MySQL updated
- Backup database regularly

### Updates:

When adding new tables:
1. Run migration to add `deleted_at` column
2. Create corresponding Gateway class
3. Add route mapping in `index.php`
4. Update documentation

---

**Construction Date:** March 30, 2026  
**API Version:** v1  
**PHP Version:** 7.4.33  
**Database:** MySQL 5.x
