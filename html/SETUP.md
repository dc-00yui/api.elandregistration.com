# ⚠️ IMPORTANT: Before Using the API

## Critical Setup Steps

### 1. Run Database Migration (REQUIRED)

The API will not work correctly until you run the soft delete migration script.

**Action Required:**
```sql
-- Execute this file against your database:
-- File: soft_delete_migration.sql
```

**Using MySQL Command Line:**
```bash
mysql -u devRoot -p elandus_registration < soft_delete_migration.sql
```

**Using MySQL Workbench:**
1. Open MySQL Workbench
2. Connect to your database server
3. File → Run SQL Script
4. Select: `soft_delete_migration.sql`
5. Execute

**What this does:**
- Adds `deleted_at` column to all 35 tables
- Creates indexes for better performance
- Enables soft delete functionality

---

### 2. Verify IIS Configuration

**Ensure URL Rewrite Module is Installed:**

1. Open IIS Manager
2. Select your website: `api.elandregistration.com`
3. Look for "URL Rewrite" icon
4. If missing, install from: https://www.iis.net/downloads/microsoft/url-rewrite

**Verify web.config:**
- Located at: `C:\inetpub\wwwroot\api.elandregistration.com\html\web.config`
- URL rewrite rules should route all requests to index.php

---

### 3. Set File Permissions

**Logs Directory:**
```
Path: C:\inetpub\wwwroot\api.elandregistration.com\html\logs
Permissions: IIS_IUSRS needs Write access
```

**PowerShell Command:**
```powershell
$path = "C:\inetpub\wwwroot\api.elandregistration.com\html\logs"
$acl = Get-Acl $path
$permission = "IIS_IUSRS","Write","Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
Set-Acl $path $acl
```

---

### 4. Verify PHP Configuration

**Required PHP Extensions:**
- ✅ PDO
- ✅ PDO_MySQL
- ✅ JSON
- ✅ OpenSSL

**Check in PowerShell:**
```powershell
php -m | Select-String -Pattern "PDO|json|openssl"
```

**Expected Output:**
```
PDO
pdo_mysql
json
openssl
```

---

### 5. Test Database Connection

Create a test file: `test_db.php`

```php
<?php
require_once 'config.php';
require_once 'Database.php';

try {
    $db = new Database();
    $conn = $db->getConnection();
    echo "✅ Database connection successful!\n";
    
    // Test query
    $stmt = $conn->query("SELECT COUNT(*) as count FROM attendee");
    $result = $stmt->fetch();
    echo "✅ Total attendees: " . $result['count'] . "\n";
    
} catch (Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}
```

Run in command line:
```bash
php test_db.php
```

---

## Quick Start Checklist

- [ ] Database migration script executed
- [ ] IIS URL Rewrite module installed
- [ ] Logs directory has write permissions
- [ ] PHP extensions verified
- [ ] Database connection tested
- [ ] OAuth credentials reviewed (change in production!)

---

## Test the API

### 1. Get Access Token

**Using PowerShell:**
```powershell
$body = @{
    grant_type = "client_credentials"
    client_id = "client_id_001"
    client_secret = "secret_key_12345_CHANGE_IN_PRODUCTION"
}

$response = Invoke-RestMethod `
    -Uri "http://api.elandregistration.com/oauth/token" `
    -Method Post `
    -Body $body `
    -ContentType "application/x-www-form-urlencoded"

$token = $response.access_token
Write-Host "Token: $token"
```

### 2. Test API Endpoint

```powershell
$headers = @{
    Authorization = "Bearer $token"
}

$result = Invoke-RestMethod `
    -Uri "http://api.elandregistration.com/" `
    -Method Get `
    -Headers $headers

$result | ConvertTo-Json
```

**Expected Response:**
```json
{
  "api": "eLand Registration API",
  "version": "v1",
  "status": "active",
  "endpoints": [...],
  "authentication": "OAuth 2.0 Client Credentials"
}
```

---

## Production Deployment Checklist

Before deploying to production:

### Security
- [ ] Change OAuth client credentials in `config.php`
- [ ] Enable HTTPS/SSL certificate
- [ ] Restrict CORS origins (change `*` to specific domains)
- [ ] Move `config.php` outside web root
- [ ] Use environment variables for sensitive data
- [ ] Disable error display (already configured)
- [ ] Review file permissions

### Database
- [ ] Create dedicated database user (not root)
- [ ] Grant only necessary permissions
- [ ] Enable database connection encryption
- [ ] Set up regular backups

### Monitoring
- [ ] Set up log rotation for `logs/php_errors.log`
- [ ] Implement monitoring alerts
- [ ] Track API usage and performance
- [ ] Monitor disk space

### Performance
- [ ] Consider implementing Redis for token storage
- [ ] Add database query caching
- [ ] Optimize indexes for common queries
- [ ] Consider CDN for static assets

---

## Common Issues & Solutions

### Issue: "Database connection failed"
**Solution:** 
1. Verify MySQL service is running
2. Check credentials in config.php
3. Test connection with MySQL client

### Issue: "404 Not Found" for all endpoints
**Solution:**
1. Verify URL Rewrite module is installed
2. Check web.config is in the correct location
3. Test if index.php loads directly

### Issue: "401 Unauthorized" 
**Solution:**
1. Verify Authorization header format: `Bearer TOKEN`
2. Confirm token hasn't expired
3. Request new token from `/oauth/token`

### Issue: "500 Internal Server Error"
**Solution:**
1. Check `logs/php_errors.log`
2. Verify logs directory permissions
3. Check PHP error log in Event Viewer

---

## File Structure Overview

```
html/
├── config.php              ← Database & OAuth credentials
├── Database.php            ← PDO connection handler
├── BaseGateway.php         ← Base CRUD operations
├── OAuth.php               ← OAuth 2.0 authentication
├── index.php               ← Main router (entry point)
├── web.config              ← IIS URL rewrite rules
├── .htaccess               ← Apache URL rewrite (alternative)
├── soft_delete_migration.sql  ← ⚠️ RUN THIS FIRST
├── README.md               ← API documentation
├── Instructions.md         ← Construction guide
├── TESTING.md              ← Testing scripts
├── gateways/               ← 35 Gateway classes
│   ├── AttendeeGateway.php
│   ├── EventGateway.php
│   ├── ExhibitorGateway.php
│   └── ... (32 more)
└── logs/                   ← Error logs (needs write access)
    └── php_errors.log
```

---

## Support Resources

- **API Documentation:** README.md
- **Construction Guide:** Instructions.md
- **Testing Guide:** TESTING.md
- **Database Schema:** Dump20260329.sql

---

## Next Steps

1. **Run the migration script** (soft_delete_migration.sql)
2. **Configure IIS** (web.config + URL Rewrite)
3. **Set permissions** (logs directory)
4. **Test connection** (test_db.php)
5. **Get OAuth token** (PowerShell script above)
6. **Test endpoints** (TESTING.md)
7. **Review security** (Production checklist)
8. **Deploy to production** (Update credentials first!)

---

**Ready to Go?** Follow the checklist above, then refer to README.md for complete API documentation.

**Questions?** Check Instructions.md for detailed construction and troubleshooting information.
