---
name: feature
description: Workflow. End-to-end feature pipeline - spec, plan, test-first implementation of every task, two-stage review, docs and PR - with approval gates, inline or with agents, optionally autonomous.
argument-hint: <feature idea or spec number> [--inline | --agents] [--auto] [--worktree]
disable-model-invocation: true
---

# Workflow: feature (full pipeline)

Input: $ARGUMENTS

Flags: `--inline` / `--agents` set the execution mode, `--auto` enables autonomous mode, and
`--worktree` isolates the work in a git worktree. All rules are in `working-protocol`.

1. **Spec.** If the input is a spec number whose `spec.md` is approved, reuse it. Otherwise run
   the `spec` workflow. **Gate: spec approved.**
2. **Plan.** Run the `plan` workflow, including its plan mode decision. **Gate: plan approved.**
3. **Set up.** Decide the execution mode from the flags or the plan size and say which. In
   inline mode, load the skills listed in the `tdd` workflow before the first task.
   With `--auto` or `--worktree`, create the branch `<type>/<NN>-<slug>`; with `--worktree`,
   create it in a worktree under `.worktrees/` (ensure that folder is gitignored), install
   dependencies and confirm the test suite is green before starting.
4. **Build.** For each task in `tasks.md`, in order, run the `tdd` workflow with the same mode.
   Tasks marked parallel and touching disjoint files may run as concurrent agents. If a check
   fails and the cause is not obvious, use `subdd-core:debugger`. Supervised: stop after each
   task for review. `--auto`: commit and continue.
5. **Review.** Run the `review` workflow on the whole feature diff (spec compliance first, then
   code quality). Fix approved findings; with `--auto`, fix blockers and should-fix items and
   list the rest in the PR.
6. **Docs.** Update README, API docs or changelog where the feature requires it
   (`subdd-core:doc-writer` in agents mode).
7. **Wrap up.** Set the spec status to `implemented` and apply `verify-before-done` on the
   whole branch. Supervised: show the PR description and stop; **gate: the user commits,
   pushes and opens the PR.** `--auto`: push the branch and open a draft PR, then report its
   link. With a worktree, tell the user where it is; remove it only when they say so.

Keep a progress list in the task widget if available: one item per stage and per task.
