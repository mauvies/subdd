---
name: conventional-commits
description: Commit message, branch naming and PR description conventions. Use when committing, naming branches, writing PR descriptions or generating changelogs.
---

# Commits, branches and PRs

## Commit messages (Conventional Commits)

```
<type>(<scope>): <imperative summary, max 72 chars>

<body: what and why, wrapped at 72>

<footer: BREAKING CHANGE: ..., Refs #123>
```

Types: feat, fix, refactor, perf, test, docs, build, ci, chore, revert.

One logical change per commit, containing only what that change needs. The summary completes
"This commit will...". When a spec applies, cite it at the end of the summary or in the body:
`feat(orders): add CSV export (spec 03, AC2)`.

No `Co-Authored-By` trailers for AI tools. If the project requires disclosing AI assistance, use
the form it defines (for example an `Assisted-by:` trailer or a note in the PR).

## Branches

`<type>/<ticket-or-slug>`, for example `feat/checkout-apple-pay`, `fix/1234-null-cart`.

## PR description

```markdown
## What
One paragraph.

## Why
Link to spec/ticket.

## How
Notable decisions and trade-offs.

## Testing
What was run, what was added.

## Risk and rollout
Migrations, flags, rollback.
```
