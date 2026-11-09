---
name: new-endpoint
description: Workflow. Design and implement a new API endpoint contract-first - contract, tests, implementation, docs.
argument-hint: <endpoint purpose, e.g. "list orders for current user with filters">
disable-model-invocation: true
---

# Workflow: new endpoint

Purpose: $ARGUMENTS

1. `subdd-dev:api-designer` writes the contract (OpenAPI/SDL) with examples. **Gate: user approves the contract.**
2. If storage changes, `subdd-dev:database-architect` designs schema and migration.
3. `subdd-core:test-writer` writes contract and integration tests from the contract.
4. `subdd-dev:backend-engineer` implements until green, with validation, auth, logging and metrics.
5. `subdd-core:code-reviewer` reviews. Fix approved findings.
6. Update API docs and generated clients/types.
