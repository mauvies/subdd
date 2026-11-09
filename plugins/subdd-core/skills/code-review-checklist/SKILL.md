---
name: code-review-checklist
description: Structured checklist for reviewing code changes. Use when reviewing a diff, PR or branch, or self-reviewing before opening a PR.
---

# Code review checklist

## Correctness
- Does it do what the spec/ticket says? Every acceptance criterion covered?
- Edge cases: null/empty, boundaries, concurrency, retries, partial failure, time zones.
- Error handling: errors surfaced or logged with context, never swallowed; invalid input fails
  loudly and names the field; no silent defaults.
- State: race conditions, stale caches, idempotency of handlers and jobs.

## Security
- Input validated at trust boundaries; output encoded.
- AuthN/AuthZ checked on every new path, including object-level access.
- No secrets in code, logs or client bundles.
- Queries parameterized; no shell or eval with user input.
- Dependencies: new ones justified, maintained, licensed.

## Tests
- Tests exist for new behavior and fail without the change.
- Failure paths tested, not only the happy path.
- No flaky patterns (sleeps, real network, order dependence).

## Wired in and in scope
- Every new exported function, component, route or job has a caller or registration.
- New scripts and commands work from a clean state, not only on the author's machine.
- New config and env vars land with the code that reads them.
- Every changed file belongs to the purpose of the change; unrelated edits are split out.
- Figures and dates are derived from their source, not typed by hand.

## Design and maintainability
- Fits existing patterns; no parallel way of doing the same thing.
- Names say what things are. Functions do one thing.
- No dead code, commented-out code, or debug output.
- Comments explain why, never what. A comment a better name would remove, or one that restates the code or copies the spec, is a finding (should fix).
- Public API and contract changes are backward compatible or versioned.

## Performance and operations
- No N+1 queries, unbounded loops or loading whole tables.
- Indexes for new query patterns. Pagination for lists.
- Logs, metrics and traces for new critical paths.
- Migrations safe to run on live data and reversible.

## Frontend specifics
- Accessible (labels, roles, focus, contrast, keyboard).
- Loading, empty and error states.
- No layout shift, no unnecessary re-renders, bundle size impact checked.
