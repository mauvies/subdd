---
name: issue-to-pr
description: Workflow. Take a GitHub issue all the way to a ready-to-open PR using the spec-driven, test-first pipeline.
argument-hint: <issue number or URL>
disable-model-invocation: true
---

# Workflow: issue to PR

Issue: $ARGUMENTS

1. Read the issue with `gh issue view $ARGUMENTS --comments`.
2. Create a branch `<type>/<issue-number>-<slug>` (ask first if the working tree is dirty).
3. Run `/subdd-core:feature` using the issue as input. Keep the gates.
4. Prepare the PR body with `Closes #<n>` and show it. Open it with `gh pr create` only when the user says so.
