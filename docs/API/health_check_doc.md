# API::HealthCheckController

[Back](/docs/docs.md)

## Overview

The `API::HealthCheckController` provides an endpoint to check the health status of the API. It returns a simple JSON
response indicating whether the system is healthy.

## Endpoint

- **URL**: `/api/health_check`
- **Method**: `GET`
- **Response Format**: `JSON`

## Request

This endpoint does not require any parameters.

### Example Request

```http
GET /api/health_check
```

## Response

A successful response will return a JSON object with a `"status"` key and a `"healthy"` value.

### Success Response

- **Code**: `200 OK`
- **Body**:

  ```json
  {
    "status": "healthy"
  }
  ```

## Errors

This endpoint does not currently return any errors.

## Notes

- This endpoint is typically used for monitoring purposes to ensure that the API is running smoothly.
- The controller returns a status code `200 OK` if the system is healthy.
