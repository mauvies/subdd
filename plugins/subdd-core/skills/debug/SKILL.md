---
name: debug
description: Workflow. Investigate a bug, failing test or error to its root cause and fix it with a regression test.
argument-hint: <error message, failing test, issue link or symptom>
disable-model-invocation: true
---

# Workflow: debug

Symptom: $ARGUMENTS

1. Delegate to `subdd-core:debugger` with the symptom and any logs, stack traces or reproduction steps provided.
2. Present: root cause, evidence, proposed fix and regression test. If the fix is larger than a few lines or touches shared code, wait for approval before applying.
3. After the fix, run the relevant suite and report.
