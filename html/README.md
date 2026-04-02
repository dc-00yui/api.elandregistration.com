# eLand Registration API

**Version:** 1.0  
**Base URL:** `http://api.elandregistration.com`  
**Authentication:** OAuth 2.0 Client Credentials Flow  
**Response Format:** JSON  
**PHP Version:** 7.4.33  
**Database:** MySQL 5.x

---

## Table of Contents

- [Overview](#overview)
- [Authentication](#authentication)
  - [How OAuth 2.0 Works](#how-oauth-20-works)
  - [Obtaining an Access Token](#obtaining-an-access-token)
  - [Using Access Tokens](#using-access-tokens)
- [Making API Requests](#making-api-requests)
  - [JavaScript Examples](#javascript-examples)
  - [PHP Examples](#php-examples)
- [Available Endpoints](#available-endpoints)
- [Request/Response Formats](#requestresponse-formats)
- [Error Handling](#error-handling)
- [Best Practices](#best-practices)

---

## Overview

The eLand Registration API provides secure access to the event registration system database. It supports Create, Read, Update, and Delete (CRUD) operations for all tables in the system.

### Key Features:

- ✅ **RESTful Architecture**: Standard HTTP methods (GET, POST, PUT, DELETE)
- ✅ **OAuth 2.0 Security**: Industry-standard authentication
- ✅ **Soft Deletes**: Records are marked as deleted, not permanently removed
- ✅ **JSON Responses**: All responses in JSON format
- ✅ **SQL Injection Protection**: PDO prepared statements
- ✅ **CORS Support**: Cross-origin requests enabled
- ✅ **Pagination**: Built-in support for paginated results
- ✅ **Filtering**: Dynamic query parameter filtering

---

## Authentication

The API uses **OAuth 2.0 Client Credentials Flow** for authentication. This is a server-to-server authentication method suitable for backend applications.

### How OAuth 2.0 Works

1. **Request Access Token**: Your application sends client credentials to the token endpoint
2. **Receive Token**: API returns an access token valid for 1 hour
3. **Use Token**: Include the token in the `Authorization` header for all API requests
4. **Token Expiry**: When token expires (after 1 hour), request a new one

### Obtaining an Access Token

**Endpoint:** `POST /oauth/token`

**Request Parameters:**

| Parameter     | Type   | Required | Description                    |
|---------------|--------|----------|--------------------------------|
| grant_type    | string | Yes      | Must be `client_credentials`   |
| client_id     | string | Yes      | Your client ID                 |
| client_secret | string | Yes      | Your client secret key         |

**Default Credentials (Development):**
- **Client ID:** `client_id_001`
- **Client Secret:** `secret_key_12345_CHANGE_IN_PRODUCTION`

⚠️ **Important:** Change these credentials in production!

---

### Example: Get Access Token

#### JavaScript (fetch)

```javascript
async function getAccessToken() {
  const response = await fetch('http://api.elandregistration.com/oauth/token', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    },
    body: new URLSearchParams({
      grant_type: 'client_credentials',
      client_id: 'client_id_001',
      client_secret: 'secret_key_12345_CHANGE_IN_PRODUCTION'
    })
  });

  const data = await response.json();
  console.log('Access Token:', data.access_token);
  return data.access_token;
}

// Usage
getAccessToken().then(token => {
  // Store token for subsequent requests
  localStorage.setItem('api_token', token);
});
```

#### JavaScript (axios)

```javascript
const axios = require('axios');

async function getAccessToken() {
  const response = await axios.post('http://api.elandregistration.com/oauth/token', 
    new URLSearchParams({
      grant_type: 'client_credentials',
      client_id: 'client_id_001',
      client_secret: 'secret_key_12345_CHANGE_IN_PRODUCTION'
    }),
    {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }
    }
  );

  return response.data.access_token;
}
```

#### PHP (cURL)

```php
<?php

function getAccessToken() {
    $url = 'http://api.elandregistration.com/oauth/token';
    
    $data = [
        'grant_type' => 'client_credentials',
        'client_id' => 'client_id_001',
        'client_secret' => 'secret_key_12345_CHANGE_IN_PRODUCTION'
    ];
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/x-www-form-urlencoded'
    ]);
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    if ($httpCode === 200) {
        $result = json_decode($response, true);
        return $result['access_token'];
    }
    
    return null;
}

// Usage
$accessToken = getAccessToken();
echo "Access Token: " . $accessToken;
```

#### PHP (file_get_contents)

```php
<?php

function getAccessToken() {
    $url = 'http://api.elandregistration.com/oauth/token';
    
    $data = [
        'grant_type' => 'client_credentials',
        'client_id' => 'client_id_001',
        'client_secret' => 'secret_key_12345_CHANGE_IN_PRODUCTION'
    ];
    
    $options = [
        'http' => [
            'method' => 'POST',
            'header' => 'Content-Type: application/x-www-form-urlencoded',
            'content' => http_build_query($data)
        ]
    ];
    
    $context = stream_context_create($options);
    $response = file_get_contents($url, false, $context);
    
    $result = json_decode($response, true);
    return $result['access_token'];
}
```

**Response:**

```json
{
  "access_token": "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6",
  "token_type": "Bearer",
  "expires_in": 3600,
  "scope": "read write"
}
```

---

### Using Access Tokens

Include the access token in the `Authorization` header for all API requests:

```
Authorization: Bearer YOUR_ACCESS_TOKEN
```

**Token Lifetime:** 1 hour (3600 seconds)

When a token expires, you'll receive a `401 Unauthorized` response. Request a new token and retry.

---

## Making API Requests

All API endpoints follow RESTful conventions:

- **GET** - Retrieve data
- **POST** - Create new record
- **PUT** - Update existing record
- **DELETE** - Soft delete record

### JavaScript Examples

#### GET - Retrieve All Attendees

```javascript
async function getAllAttendees(accessToken) {
  const response = await fetch('http://api.elandregistration.com/attendee', {
    method: 'GET',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Content-Type': 'application/json'
    }
  });

  const data = await response.json();
  console.log('Attendees:', data);
  return data;
}
```

#### GET - Retrieve Single Attendee by ID

```javascript
async function getAttendeeById(accessToken, attendeeId) {
  const response = await fetch(`http://api.elandregistration.com/attendee/${attendeeId}`, {
    method: 'GET',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Content-Type': 'application/json'
    }
  });

  const data = await response.json();
  return data;
}
```

#### GET - With Query Parameters (Filtering & Pagination)

```javascript
async function getFilteredAttendees(accessToken, filters) {
  // filters = { event: 1, regstatus: 'COMPLETE', limit: 50, offset: 0 }
  const queryString = new URLSearchParams(filters).toString();
  
  const response = await fetch(`http://api.elandregistration.com/attendee?${queryString}`, {
    method: 'GET',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Content-Type': 'application/json'
    }
  });

  const data = await response.json();
  return data;
}

// Usage
getFilteredAttendees(accessToken, {
  event: 1,
  regstatus: 'COMPLETE',
  limit: 50,
  offset: 0
});
```

#### POST - Create New Attendee

```javascript
async function createAttendee(accessToken, attendeeData) {
  const response = await fetch('http://api.elandregistration.com/attendee', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(attendeeData)
  });

  const data = await response.json();
  console.log('Created:', data);
  return data;
}

// Usage
createAttendee(accessToken, {
  fname: 'John',
  lname: 'Doe',
  email: 'john.doe@example.com',
  event: 1,
  regstatus: 'INCOMPLETE',
  phone: '555-1234'
});
```

#### PUT - Update Attendee

```javascript
async function updateAttendee(accessToken, attendeeId, updates) {
  const response = await fetch(`http://api.elandregistration.com/attendee/${attendeeId}`, {
    method: 'PUT',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(updates)
  });

  const data = await response.json();
  console.log('Updated:', data);
  return data;
}

// Usage
updateAttendee(accessToken, 123, {
  regstatus: 'COMPLETE',
  payamount: 299.99
});
```

#### DELETE - Soft Delete Attendee

```javascript
async function deleteAttendee(accessToken, attendeeId) {
  const response = await fetch(`http://api.elandregistration.com/attendee/${attendeeId}`, {
    method: 'DELETE',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Content-Type': 'application/json'
    }
  });

  const data = await response.json();
  console.log('Deleted:', data);
  return data;
}

// Usage
deleteAttendee(accessToken, 123);
```

---

### PHP Examples

#### GET - Retrieve All Events

```php
<?php

function getAllEvents($accessToken) {
    $url = 'http://api.elandregistration.com/event';
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Authorization: Bearer ' . $accessToken,
        'Content-Type: application/json'
    ]);
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    if ($httpCode === 200) {
        return json_decode($response, true);
    }
    
    return null;
}

// Usage
$events = getAllEvents($accessToken);
print_r($events);
```

#### GET - Retrieve Single Event by ID

```php
<?php

function getEventById($accessToken, $eventId) {
    $url = 'http://api.elandregistration.com/event/' . $eventId;
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Authorization: Bearer ' . $accessToken,
        'Content-Type: application/json'
    ]);
    
    $response = curl_exec($ch);
    curl_close($ch);
    
    return json_decode($response, true);
}
```

#### GET - With Query Parameters

```php
<?php

function getFilteredExhibitors($accessToken, $filters) {
    $queryString = http_build_query($filters);
    $url = 'http://api.elandregistration.com/exhibitor?' . $queryString;
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Authorization: Bearer ' . $accessToken,
        'Content-Type: application/json'
    ]);
    
    $response = curl_exec($ch);
    curl_close($ch);
    
    return json_decode($response, true);
}

// Usage
$exhibitors = getFilteredExhibitors($accessToken, [
    'event' => 1,
    'limit' => 100,
    'offset' => 0
]);
```

#### POST - Create New Event

```php
<?php

function createEvent($accessToken, $eventData) {
    $url = 'http://api.elandregistration.com/event';
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($eventData));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Authorization: Bearer ' . $accessToken,
        'Content-Type: application/json'
    ]);
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    if ($httpCode === 201) {
        return json_decode($response, true);
    }
    
    return null;
}

// Usage
$newEvent = createEvent($accessToken, [
    'title' => 'Annual Conference 2026',
    'startdate' => '2026-06-15',
    'enddate' => '2026-06-17',
    'client' => 1
]);
```

#### PUT - Update Event

```php
<?php

function updateEvent($accessToken, $eventId, $updates) {
    $url = 'http://api.elandregistration.com/event/' . $eventId;
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($updates));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Authorization: Bearer ' . $accessToken,
        'Content-Type: application/json'
    ]);
    
    $response = curl_exec($ch);
    curl_close($ch);
    
    return json_decode($response, true);
}

// Usage
updateEvent($accessToken, 5, [
    'title' => 'Updated Conference Title',
    'capacity' => 500
]);
```

#### DELETE - Soft Delete Event

```php
<?php

function deleteEvent($accessToken, $eventId) {
    $url = 'http://api.elandregistration.com/event/' . $eventId;
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'DELETE');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Authorization: Bearer ' . $accessToken,
        'Content-Type: application/json'
    ]);
    
    $response = curl_exec($ch);
    curl_close($ch);
    
    return json_decode($response, true);
}

// Usage
deleteEvent($accessToken, 5);
```

---

## Available Endpoints

All endpoints support the following operations:

| Method | Endpoint Pattern          | Description                    |
|--------|---------------------------|--------------------------------|
| GET    | `/{resource}`             | Get all records (paginated)    |
| GET    | `/{resource}/{id}`        | Get single record by ID        |
| POST   | `/{resource}`             | Create new record              |
| PUT    | `/{resource}/{id}`        | Update existing record         |
| DELETE | `/{resource}/{id}`        | Soft delete record             |

### Complete List of Resources:

1. **attendee** - Event attendees/registrants
2. **attendee_seloption** - Attendee selected options
3. **attendee_seloption_extrainfo** - Additional option information
4. **attendeereg_couponcode** - Registration coupon codes
5. **attendeereg_demog_answer** - Demographic question answers
6. **attendeereg_demog_answersub** - Demographic sub-answers
7. **attendeereg_demog_question** - Demographic questions
8. **attendeereg_option** - Registration options
9. **attendeereg_optiongroup** - Registration option groups
10. **booth** - Exhibition booth information
11. **boothapp** - Booth applications
12. **boothapp_selection** - Booth application selections
13. **client** - Client organizations
14. **event** - Events/conferences
15. **event_badgetemplate** - Badge templates for events
16. **event_checkin_cfg** - Check-in configuration
17. **event_gate** - Event gate/entrance information
18. **event_gate_log** - Gate access logs
19. **exhibitor** - Exhibitor companies
20. **exhibitor_invite** - Exhibitor invitations
21. **exhibitor_invoice** - Exhibitor invoices
22. **exhibitor_product** - Exhibitor products
23. **exhibitor_productcat** - Product categories
24. **linker_exhibitor_product** - Exhibitor-product relationships
25. **lookup_attendeecompany** - Company lookup table
26. **lookup_attendeecompany_import** - Company import data
27. **lookup_country** - Country lookup table
28. **lookup_state** - State/province lookup table
29. **redirecturl** - URL redirects
30. **sponsorship** - Sponsorship packages
31. **sponsorship_purchase** - Sponsorship purchases
32. **trackresendreceiptemail** - Receipt email tracking
33. **trackroutingcode_codes** - Routing codes
34. **trackroutingcode_usage** - Routing code usage
35. **transaction** - Payment transactions

### Example Endpoint URLs:

```
GET    http://api.elandregistration.com/attendee
GET    http://api.elandregistration.com/attendee/123
POST   http://api.elandregistration.com/attendee
PUT    http://api.elandregistration.com/attendee/123
DELETE http://api.elandregistration.com/attendee/123

GET    http://api.elandregistration.com/event
GET    http://api.elandregistration.com/event/5
POST   http://api.elandregistration.com/event
PUT    http://api.elandregistration.com/event/5
DELETE http://api.elandregistration.com/event/5

GET    http://api.elandregistration.com/exhibitor?limit=50&offset=0
GET    http://api.elandregistration.com/booth?event=1
GET    http://api.elandregistration.com/transaction?orderid=ORD12345
```

---

## Request/Response Formats

### Query Parameters (GET Requests)

| Parameter | Type    | Description                              | Default |
|-----------|---------|------------------------------------------|---------|
| limit     | integer | Maximum number of records to return      | 1000    |
| offset    | integer | Number of records to skip (pagination)   | 0       |
| {column}  | mixed   | Filter by column value (e.g., event=1)   | -       |

**Example:**
```
GET /attendee?event=1&regstatus=COMPLETE&limit=50&offset=100
```

### Response Format - GET All

```json
{
  "data": [
    {
      "ID": 1,
      "fname": "John",
      "lname": "Doe",
      "email": "john.doe@example.com",
      "event": 1,
      "regstatus": "COMPLETE"
    },
    {
      "ID": 2,
      "fname": "Jane",
      "lname": "Smith",
      "email": "jane.smith@example.com",
      "event": 1,
      "regstatus": "INCOMPLETE"
    }
  ],
  "total": 2,
  "limit": 1000,
  "offset": 0
}
```

### Response Format - GET Single

```json
{
  "ID": 1,
  "fname": "John",
  "lname": "Doe",
  "email": "john.doe@example.com",
  "event": 1,
  "regstatus": "COMPLETE",
  "CreateDate": "2026-03-15 10:30:00",
  "ModifyDate": "2026-03-20 14:45:00"
}
```

### Response Format - POST (Create)

```json
{
  "message": "Record created successfully",
  "id": 123,
  "data": {
    "ID": 123,
    "fname": "John",
    "lname": "Doe",
    "email": "john.doe@example.com",
    "CreateDate": "2026-03-30 12:00:00"
  }
}
```

### Response Format - PUT (Update)

```json
{
  "message": "Record updated successfully",
  "id": 123,
  "data": {
    "ID": 123,
    "fname": "John",
    "lname": "Smith",
    "email": "john.smith@example.com",
    "ModifyDate": "2026-03-30 12:15:00"
  }
}
```

### Response Format - DELETE

```json
{
  "message": "Record deleted successfully",
  "id": 123
}
```

---

## Error Handling

### HTTP Status Codes

| Code | Status                | Description                           |
|------|-----------------------|---------------------------------------|
| 200  | OK                    | Request successful                    |
| 201  | Created               | Resource created successfully         |
| 400  | Bad Request           | Invalid request format                |
| 401  | Unauthorized          | Invalid or missing access token       |
| 404  | Not Found             | Resource or record not found          |
| 405  | Method Not Allowed    | HTTP method not supported             |
| 500  | Internal Server Error | Server error occurred                 |

### Error Response Format

```json
{
  "error": "Error type",
  "message": "Detailed error message"
}
```

### Common Errors

#### 401 Unauthorized

```json
{
  "error": "unauthorized",
  "message": "Missing authorization header"
}
```

**Solution:** Include valid Bearer token in Authorization header

#### 404 Not Found

```json
{
  "error": "Not found",
  "message": "Record with ID 999 not found"
}
```

**Solution:** Verify the ID exists and hasn't been soft-deleted

#### 400 Bad Request

```json
{
  "error": "Invalid JSON",
  "message": "Request body must be valid JSON"
}
```

**Solution:** Ensure request body is properly formatted JSON

---

## Best Practices

### 1. Token Management

- Store access tokens securely (not in localStorage for sensitive apps)
- Implement token refresh logic when tokens expire
- Don't hardcode client credentials in frontend code

### 2. Error Handling

```javascript
async function makeApiRequest(url, options) {
  try {
    const response = await fetch(url, options);
    
    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.message);
    }
    
    return await response.json();
  } catch (error) {
    console.error('API Error:', error);
    throw error;
  }
}
```

### 3. Pagination

Always use pagination for large datasets:

```javascript
let offset = 0;
const limit = 100;
let allRecords = [];

while (true) {
  const response = await fetch(
    `http://api.elandregistration.com/attendee?limit=${limit}&offset=${offset}`,
    { headers: { 'Authorization': `Bearer ${token}` } }
  );
  
  const data = await response.json();
  allRecords = allRecords.concat(data.data);
  
  if (data.data.length < limit) break;
  offset += limit;
}
```

### 4. Rate Limiting

While not currently enforced, be respectful:
- Don't make excessive concurrent requests
- Implement exponential backoff for retries
- Cache responses when appropriate

### 5. Data Validation

Always validate data before sending to API:

```javascript
function validateAttendee(data) {
  if (!data.fname || !data.lname) {
    throw new Error('First and last name are required');
  }
  if (!data.email || !data.email.includes('@')) {
    throw new Error('Valid email is required');
  }
  return true;
}
```

### 6. Soft Deletes

Remember that DELETE operations don't permanently remove records:
- Deleted records have `deleted_at` timestamp set
- Use PUT to restore soft-deleted records: `{ deleted_at: null }`
- Query parameters won't return soft-deleted records

---

## Support & Documentation

- **Construction Guide:** See `Instructions.md` for implementation details
- **Database Schema:** Reference `Dump20260329.sql` for table structures
- **Configuration:** Edit `config.php` for customization

---

## Version History

**v1.0** - March 30, 2026
- Initial release
- OAuth 2.0 Client Credentials authentication
- Full CRUD operations for 35 tables
- Soft delete functionality
- Pagination and filtering support

---

## Security Notes

⚠️ **Important:** This API currently uses hardcoded OAuth credentials for development. Before deploying to production:

1. Change OAuth client credentials in `config.php`
2. Enable HTTPS/SSL
3. Implement token storage (Redis/database)
4. Add rate limiting
5. Restrict CORS to specific domains
6. Enable audit logging
7. Use environment variables for sensitive data

---

**API Status:** ✅ Active  
**Last Updated:** March 30, 2026  
**Maintained By:** Development Team
