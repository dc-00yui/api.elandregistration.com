# eLand Registration API - Quick Start Test Script

This script provides quick test commands for validating your API setup.

## Step 1: Get Access Token

### Using PowerShell (Windows)
```powershell
$body = @{
    grant_type = "client_credentials"
    client_id = "client_id_001"
    client_secret = "secret_key_12345_CHANGE_IN_PRODUCTION"
}

$response = Invoke-RestMethod -Uri "http://api.elandregistration.com/oauth/token" -Method Post -Body $body -ContentType "application/x-www-form-urlencoded"

$token = $response.access_token
Write-Host "Access Token: $token"
```

### Using cURL (Command Line)
```bash
curl -X POST http://api.elandregistration.com/oauth/token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=client_id_001&client_secret=secret_key_12345_CHANGE_IN_PRODUCTION"
```

## Step 2: Test API Endpoints

### Get API Info
```bash
curl -X GET http://api.elandregistration.com/ \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### Get All Events
```bash
curl -X GET http://api.elandregistration.com/event \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### Get Single Event
```bash
curl -X GET http://api.elandregistration.com/event/1 \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### Create New Event (Test)
```bash
curl -X POST http://api.elandregistration.com/event \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{"title":"Test Event","startdate":"2026-06-01","client":1}'
```

### Get All Attendees with Filtering
```bash
curl -X GET "http://api.elandregistration.com/attendee?event=1&limit=10" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

## Using Postman

1. **Create New Request Collection**
   - Name: eLand Registration API

2. **Add OAuth Token Request**
   - Method: POST
   - URL: `http://api.elandregistration.com/oauth/token`
   - Body Type: x-www-form-urlencoded
   - Body:
     - grant_type: client_credentials
     - client_id: client_id_001
     - client_secret: secret_key_12345_CHANGE_IN_PRODUCTION

3. **Save Token from Response**
   - Copy the `access_token` value

4. **Create API Requests**
   - Add Authorization header: `Bearer YOUR_TOKEN`
   - Test various endpoints

## Troubleshooting

### If you get 500 errors:
1. Check `logs/php_errors.log` for details
2. Verify database connection in config.php
3. Ensure PDO MySQL extension is enabled

### If you get 401 Unauthorized:
1. Verify you're including the Authorization header
2. Check token hasn't expired (1 hour lifetime)
3. Request a new token

### If you get 404 errors:
1. Verify URL rewrite is working (web.config for IIS, .htaccess for Apache)
2. Check the resource name is correct
3. Ensure index.php is accessible

## PowerShell Complete Test Script

```powershell
# Get Token
$tokenBody = @{
    grant_type = "client_credentials"
    client_id = "client_id_001"
    client_secret = "secret_key_12345_CHANGE_IN_PRODUCTION"
}

$tokenResponse = Invoke-RestMethod -Uri "http://api.elandregistration.com/oauth/token" -Method Post -Body $tokenBody -ContentType "application/x-www-form-urlencoded"
$token = $tokenResponse.access_token

Write-Host "Token obtained: $token" -ForegroundColor Green

# Test API Info
$headers = @{
    Authorization = "Bearer $token"
}

$apiInfo = Invoke-RestMethod -Uri "http://api.elandregistration.com/" -Method Get -Headers $headers
Write-Host "API Status: $($apiInfo.status)" -ForegroundColor Green

# Get Events
$events = Invoke-RestMethod -Uri "http://api.elandregistration.com/event?limit=5" -Method Get -Headers $headers
Write-Host "Total Events: $($events.total)" -ForegroundColor Green

# Get Attendees
$attendees = Invoke-RestMethod -Uri "http://api.elandregistration.com/attendee?limit=5" -Method Get -Headers $headers
Write-Host "Total Attendees: $($attendees.total)" -ForegroundColor Green

Write-Host "`nAPI Tests Complete!" -ForegroundColor Cyan
```

Save this as `test_api.ps1` and run with:
```powershell
.\test_api.ps1
```
