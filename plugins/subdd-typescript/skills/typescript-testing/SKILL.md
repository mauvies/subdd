---
name: typescript-testing
description: Testing stack and conventions for TypeScript projects - Vitest/Jest, Testing Library, Playwright, MSW, integration tests with real databases. Use when writing or running tests in a TypeScript or JavaScript project.
---

# TypeScript testing

Use what the project already has. Defaults when starting:

| Level | Tool |
|---|---|
| Unit | Vitest (or Jest if present) |
| Components | Testing Library + `@testing-library/user-event` |
| HTTP mocks | MSW |
| API integration | in-process server (Fastify `inject`, Supertest) |
| Database integration | the real engine in Docker (Testcontainers, Supabase local, `docker compose`) |
| End to end | Playwright with role-based locators |

## Conventions

- Query by role and label (`getByRole`, `getByLabelText`), never by class or test id first.
- Fake timers (`vi.useFakeTimers`) instead of sleeps; seeded randomness.
- Integration tests reset state per test (`beforeEach(resetDatabase)`), so order cannot make a
  test pass or fail.
- Choose the database client deliberately: a privileged client to assert query behaviour, a
  user-scoped one to assert access rules.
- Separate fast unit runs (no Docker) from integration runs; keep the unit loop fast.
- Snapshot tests only for stable serialised output, never for logic.

## Commands

Detect them from `package.json` (`test`, `test:unit`, `test:integration`, `typecheck`, `lint`,
`build`) and run the narrowest one while iterating, the full set before finishing.
