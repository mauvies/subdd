---
name: api-design
description: REST/GraphQL/event API design conventions - resources, naming, pagination, errors, idempotency, versioning. Use when designing, implementing or reviewing an API endpoint, webhook or event contract.
---

# API design

## REST

- Plural nouns for resources: `/orders`, `/orders/{id}/items`. Verbs only for real actions: `POST /orders/{id}:cancel` or `/orders/{id}/cancel`.
- Methods: GET safe, PUT/DELETE idempotent, POST for creation and actions, PATCH for partial updates.
- Status codes: 200, 201 + Location, 204, 400 validation, 401, 403, 404, 409 conflict, 422 semantic, 429, 5xx.
- JSON in camelCase (or the project's existing convention), ISO 8601 UTC timestamps, string ids.
- Pagination: cursor-based (`?limit=&cursor=`) returning `nextCursor`; offset only for small admin lists.
- Filtering and sorting via query params; document allowed fields.
- Errors in one shape (RFC 9457 problem details):
  `{ "type", "title", "status", "detail", "instance", "errors": [{ "field", "message" }] }`
- Idempotency-Key header on POSTs that create money movements or external side effects.
- Versioning: additive changes without version bump; breaking changes behind `/v2` or a header, with deprecation dates.
- Rate limits exposed via headers.

## GraphQL

Nullable by default for resilience, Relay-style connections for lists, mutations return payload types with user errors, DataLoader against N+1, depth/complexity limits.

## Events and webhooks

Envelope: `{ id, type, version, occurredAt, source, data }`. Past-tense type names (`order.paid`). Signed webhooks (HMAC + timestamp), retries with backoff, consumers idempotent by `id`.

## Contract first

Write OpenAPI 3.1 / AsyncAPI / SDL before code. Generate types and clients from it. Add contract tests.
