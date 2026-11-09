---
name: database-migrations
description: Safe schema migration practices (expand/contract, backfills, locks, rollbacks). Use when creating or reviewing a database migration or changing a schema on live data.
---

# Safe migrations

## Expand / contract

1. **Expand:** add new column/table, nullable or with a default; deploy code that writes both.
2. **Backfill:** in batches (e.g. 1k-10k rows), throttled, resumable, outside the deploy transaction.
3. **Switch reads** to the new structure.
4. **Contract:** remove the old column in a later deploy once nothing reads it.

## Postgres specifics

- `CREATE INDEX CONCURRENTLY` (outside a transaction).
- Adding NOT NULL: add a `CHECK (...) NOT VALID`, validate, then set NOT NULL.
- Avoid table rewrites on big tables (type changes, volatile defaults on old versions).
- Set `lock_timeout` and `statement_timeout` in migrations.
- Foreign keys: add `NOT VALID`, then `VALIDATE CONSTRAINT`.

## Rules

- Every migration has a tested down path or a written rollback plan.
- Migrations are immutable once merged; fix forward with a new one.
- Never mix schema change and large data change in one migration.
- Test against a copy of production-sized data when tables are large.
