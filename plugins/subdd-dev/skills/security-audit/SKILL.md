---
name: security-audit
description: Workflow. Run a security audit of the repo, a directory or the current diff with the security-auditor agent.
argument-hint: [path | "diff" | "full"]
disable-model-invocation: true
---

# Workflow: security audit

Scope: $ARGUMENTS (default: current diff against `main`; `full` = whole repo)

1. Delegate to `subdd-dev:security-auditor` with the scope.
2. Present findings by severity with locations and fixes.
3. Ask which to fix. For approved fixes delegate to the matching engineer agent and add a test per fix.
4. Save the report to `docs/security/audit-YYYY-MM-DD.md`.
