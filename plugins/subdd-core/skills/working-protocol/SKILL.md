---
name: working-protocol
description: How agents work with the human in subdd projects - approval gates, plan mode criteria, scope discipline, commits, objections and auto-approvable shell commands. Use in every implementation, planning or review task.
---

# Working protocol

The project's CLAUDE.md wins over this file.

## Gates and commits

- Work moves through gates: spec approved → plan approved → implementation → review → the
  human decides to commit. Never skip a gate the workflow defines.
- **Never commit, push or open a PR unless the human asks in this session**, runs a workflow
  with `--auto`, or the project's CLAUDE.md explicitly enables autonomous mode. Otherwise draft
  the commit message instead.
- Commits are atomic: each contains only what its purpose needs. No unrelated fixes, renames,
  formatting or files riding along; note them as follow-ups.
- Conventional Commits, citing the spec and criterion when one applies:
  `feat(orders): add CSV export (spec 03, AC2)`.
- No `Co-Authored-By` trailers for AI. If the project requires disclosing AI assistance, use
  the form it asks for (an `Assisted-by:` trailer or a note in the PR).

## Execution modes

How tasks are carried out, chosen per run with a flag or decided by the workflow:

- **Inline (`--inline`)**: the main session implements with the skills loaded, no subagents.
  Cheapest and fastest; keeps the conversation's context. Default for plans of up to 3 tasks
  that touch one area.
- **Agents (`--agents`)**: test-writer, implementer or a specialist, and reviewer run as
  subagents with clean contexts. Costs more tokens; pays off for larger plans, work across
  several areas, or tasks that can run in parallel. Default otherwise.

Always state the mode chosen and why in one line, so the user can switch.

## Autonomous mode (`--auto`)

Off by default. When the user passes `--auto` (or the project's CLAUDE.md enables it):

- Work on a feature branch (`<type>/<spec-number>-<slug>`), never on the default branch.
- Commit after each task once its tests, lint and type check are green, one Conventional
  Commit per task citing spec and criteria.
- When all tasks and the review are done: push the branch and open a **draft** PR with the
  description from the `conventional-commits` format. Never merge, never push to the default
  branch, never force-push.
- Approval gates on spec and plan still apply; `--auto` only removes the stops between tasks
  and the final commit/PR step.
- If `SUBDD_BLOCK_GIT_WRITES=1` is set, autonomous mode is unavailable: say so and continue in
  supervised mode.
- Stop and ask on a failing check you cannot fix within the task, on any deviation from the
  plan, or on anything irreversible.

## Plan mode

Plan mode is the only real gate: writes are blocked until the human approves. Decide after the
spec is approved and before planning. **Enter plan mode when any of these is true:**

- It touches money, payments, auth, permissions or personal data.
- It changes a data schema, runs a migration or deletes data.
- It breaks or changes a public contract (API, events, file formats).
- It spans several modules or packages, or adds a dependency or infrastructure.
- It is hard to roll back.
- More than one design is reasonable, or the architecture is unclear.

Skip it for a bug with a clear reproduction, copy and small UI changes, single-file refactors
and test-only changes. The human can always force either way. Write `plan.md` and `tasks.md`
only after the plan is approved.

## Scope

- Stay inside the current task. Any deviation from the spec or plan, and any new pattern not
  already in the codebase, is named explicitly in the summary, never made silently.
- If the spec, plan or an instruction looks wrong, say so with the reason and an alternative.
  Do not work around it.

## Shell commands (Claude Code)

Keep commands auto-approvable so the human is not interrupted:

- Prefer the native tools (Glob, Grep, Read) over `find`, `grep` and `cat`. Bracketed paths
  such as Next.js `[id]` make a `find` require manual approval.
- One simple command per call: no `&&` chains, no `cd` before a command, no `git -C` (git runs
  from the repo root), no needless redirection or pipes.
