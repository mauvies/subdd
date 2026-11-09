---
name: test-first
description: Test-first (TDD) discipline and testing conventions. Use when writing tests, implementing a planned task, or deciding what and how to test.
---

# Test-first

Cycle per task: **red** (write a failing test for the next behavior) → **green** (simplest code that passes) → **refactor** (clean up while green).

## What to test

- Each acceptance criterion, through the public interface.
- Edge cases: empty, null, max size, invalid format, duplicates, unicode, time zones.
- Failure paths: dependency down, timeout, permission denied, conflict.
- Contracts at boundaries: API request/response shapes, events, DB constraints.

## Test pyramid

- Unit: pure logic, fast, many.
- Integration: module plus real DB/queue/HTTP layer (containers or in-memory equivalents), fewer.
- End-to-end: critical user journeys only.

## Conventions

- Name tests as behavior sentences.
- Arrange / Act / Assert, one behavior per test.
- Factories or builders for test data, never giant shared fixtures.
- Mock at the boundary only; prefer fakes over mocks for owned interfaces.
- Deterministic: fake timers, seeded randomness, no network.
- A bug fix starts with a test that reproduces it.

## Tests that pin decisions

- **Regression test:** every bug fix starts with a test that fails before the fix and passes after.
- **Criterion tests:** a test tied to an acceptance criterion says so in its name or `describe`
  (`spec 03, AC2`), so a reader can trace behaviour back to the spec.
- **Inventory tests:** when a class of bug can recur in new code (a route without a rate limit, a
  table without access rules, a job not registered), write a test that enumerates every instance
  and fails until a new one is declared with its decision. The test, not the reviewer's memory,
  makes the next instance safe.
- **Removal tests:** when deleting something dangerous (an unsafe endpoint, a misleading column),
  a test that fails if it reappears keeps it gone.

## Stack specifics

Tools and commands come from the stack pack when installed (for example
`subdd-typescript:typescript-testing`) and always from the project's existing setup.
