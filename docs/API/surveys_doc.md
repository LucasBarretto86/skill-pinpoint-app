# API::SurveysController

[Back](/docs/docs.md)

## Overview

The `API::SurveysController` handles the retrieval of survey data. It includes an option for pagination to manage large
sets of survey records.

## Endpoints

- **URL**: `/api/surveys`
- **Method**: `GET`
- **Response Format**: `JSON`

## Request

### Parameters

- `page`: The page number to fetch (optional).
- `per_page`: The number of records to return per page (optional).

### Example Request

```http
GET /api/surveys?page=1&per_page=10
```

## Response

### Success Response

- **Code**: `200 OK`
- **Body**:

  If no pagination parameters are provided:

  ```json
  [
    {
      "id": 1,
      "name": "Survey 1",
      "participants": [...],
      "polls": [...]
    },
    ...
  ]
  ```

  If pagination parameters are provided:

  ```json
  {
    "records": [
      {
        "id": 1,
        "name": "Survey 1",
        "participants": [...],
        "polls": [...]
      },
      ...
    ],
    "records_count": 100,
    "pages_count": 10,
    "current_page": 1
  }
  ```

## Notes

- The `index` action retrieves all surveys and includes related data (participants, polls, questions, and responses).
- Pagination is handled if the `page` and `per_page` parameters are provided in the request.
- If pagination parameters are not present, all surveys are returned.

---
