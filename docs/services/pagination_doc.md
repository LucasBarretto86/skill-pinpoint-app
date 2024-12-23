# PaginationService

[Back](/docs/docs.md)

## Overview

The `PaginationService` handles the pagination logic for any ActiveRecord scope. It calculates the offset, limits the
number of records per page, and returns metadata about the total records, total pages, and the current page.

## Initialization

The `PaginationService` is initialized with the following parameters:

- `scope`: The ActiveRecord relation or query to paginate.
- `page`: The current page number.
- `per_page`: The number of records per page.
- `serializer`: An optional serializer for the records.

## Methods

### `paginate`

This method returns the paginated records along with metadata about the total records, pages, and the current page.

#### Example Response

```json
{
  "records": [
    { "id": 1, "name": "Survey 1" },
    { "id": 2, "name": "Survey 2" }
  ],
  "records_count": 100,
  "pages_count": 10,
  "current_page": 1
}
```

### `serialized_records`

If a serializer is provided, this method will serialize each record in the pagination response.

---

## Notes

- The `page` parameter defaults to `1`, and the `per_page` parameter defaults to `10` if not provided.
- The `paginate` method calculates the correct offset and limit based on the page and per_page parameters.
- Pagination metadata includes:
  - `records_count`: Total number of records available.
  - `pages_count`: Total number of pages based on the per_page value.
  - `current_page`: The current page number requested.
- If a `serializer` is provided, each record will be serialized using that serializer before being returned.
