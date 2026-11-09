---
name: review
description: Workflow. Two-stage review of the current branch, a PR or specific files - spec compliance first, then code quality - plus security review when relevant.
argument-hint: [base-branch | PR number | paths]
disable-model-invocation: true
---

# Workflow: review

Target: $ARGUMENTS (default: current branch against `main`)

1. Determine the diff. For a PR number use `gh pr diff <n>`; for a branch use `git diff <base>...HEAD`.
   Find the spec under `docs/specs/` if one applies.
2. **Stage 1: spec compliance.** Delegate to `subdd-core:code-reviewer` asking only whether the
   change does what the spec says: every acceptance criterion implemented and tested, nothing
   built that the spec excludes, no unplanned behaviour. If there is no spec, check against the
   task or PR description. Blocking gaps go back to implementation before stage 2.
3. **Stage 2: code quality.** Delegate to `subdd-core:code-reviewer` for the full checklist
   (correctness, security, tests, wiring, scope, design, comments).
4. If the diff touches auth, payments, user input handling, file uploads, cryptography or
   infrastructure, also delegate to `subdd-dev:security-auditor` (if installed) in
   parallel with stage 2.
5. Merge the findings, deduplicate, and order by severity.
6. Ask the user which findings to fix. Fix only the approved ones, then re-run the checks
   (`verify-before-done`).
