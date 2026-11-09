---
name: ship
description: Workflow. Pre-merge checklist - tests, lint, types, build, self-review, conventional commit and PR description.
argument-hint: [base-branch] [--auto]
disable-model-invocation: true
---

# Workflow: ship

Base: $ARGUMENTS (default `main`)

1. Detect project scripts (package.json, Makefile, pyproject.toml, go.mod, Cargo.toml) and run, in order: format check, lint, type check, tests, build. Stop on the first failure and report it.
2. Check the diff for leftovers (debug logs, `.only`/`skip` in tests, TODOs added, secrets, large binaries, commented-out code) and for scope: every changed file must belong to the purpose of the commit. Propose splitting or reverting anything unrelated.
3. Draft commit message(s) and the PR description following the `conventional-commits` skill, citing spec and criteria.
4. Show everything to the user. Commit, push or open the PR (`gh pr create --draft`) only when
   the user says so in this session, or directly with `--auto` (never to the default branch,
   never merge).
