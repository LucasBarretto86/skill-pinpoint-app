# API::SessionsController

[Back](/docs/docs.md)

## Overview

The `API::SessionsController` handles user login functionality using Devise for authentication. It provides an endpoint
for creating a session by verifying the user's credentials (email and password) and returns a JWT token for
authenticated requests.

## Endpoint

- **URL**: `/api/sessions`
- **Method**: `POST`
- **Response Format**: `JSON`

## Request

The request must include the user's email and password in the JSON body.

### Request Body

```json
{
  "user": {
    "email": "user@example.com",
    "password": "password123"
  }
}
```

### Parameters

- `email`: The user's email address.
- `password`: The user's password.

## Response

If the user provides valid credentials, a JWT token is generated and returned along with the user's ID.

### Success Response

- **Code**: `200 OK`
- **Body**:

  ```json
  {
    "user_id": 1,
    "token": "jwt_token_here"
  }
  ```

### Error Response

If the email or password is invalid, the API returns an error message.

- **Code**: `401 Unauthorized`
- **Body**:

  ```json
  {
    "error": "Invalid email or password."
  }
  ```

## Notes

- This controller uses Devise for authentication and JWT for session management.
- The `create` action attempts to authenticate the user based on the provided email and password.
- If authentication is successful, the user ID and a JWT token are returned.
- If authentication fails, an error message is returned indicating invalid credentials.
- This controller uses `null_session` for CSRF protection to allow API consumption without CSRF token validation.
