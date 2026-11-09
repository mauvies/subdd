# Changelog

Format: Keep a Changelog. Each plugin carries its own version in `plugin.json`.

## [0.5.0] - 2026-11-09

### Changed
- Renamed the project to **subdd** (subagent-driven development): marketplace `subdd`,
  plugins `subdd-core`, `subdd-dev`, `subdd-product`, `subdd-aiops`, `subdd-typescript`,
  installer `scripts/subdd-init.sh`, environment variables `SUBDD_BLOCK_GIT_WRITES`,
  `SUBDD_ALLOW_LOCKFILE_EDITS` and `SUBDD_PROTECTED_EXTRA`.

## [0.4.0] - 2026-11-09

### Added
- Execution modes for `tdd` and `feature`: `--inline` (main session, no subagents) and `--agents`, chosen automatically by plan size when not given.
- Autonomous mode `--auto`: commit per task on a feature branch, push and open a draft PR; never merges; blocked by `SUBDD_BLOCK_GIT_WRITES=1`.
- `--worktree` option for `feature`.
- `verify-before-done` skill: evidence before claims.
- `diagnose-session` workflow in subdd-aiops.

### Changed
- `review` runs in two stages: spec compliance, then code quality.

## [0.3.0] - 2026-11-09

### Added
- `subdd-core` workflow `issue-to-pr`; `subdd-aiops` workflow `promote`.

### Removed
- The personal marketplace template and `subdd-init.sh --personal`: personal preferences belong
  in `~/.claude/CLAUDE.md`, `~/.claude/agents/` and `~/.claude/skills/`.

## [0.2.0] - 2026-11-09

### Added
- `subdd-typescript` stack pack: `typescript-style`, `react-conventions`, `typescript-testing`, `node-backend`.
- `subdd-core` skills `working-protocol` (gates, plan mode criteria, scope, commits, shell commands) and `engineering-principles` (fail loudly, comments, derive values, wired in).
- Opt-in hook blocking git writes (`SUBDD_BLOCK_GIT_WRITES=1`); lockfile protection now configurable.
- Personal marketplace template; `subdd-init.sh` options `--stack`, `--github`, `--personal`, `--no-git-writes`.
- MIT license, CONTRIBUTING, CI workflow, hook tests.

### Changed
- Specs live in numbered folders `docs/specs/NN-<slug>/` with stable criterion ids cited as `spec NN, ACn`.
- `plan` decides on plan mode after the spec is approved and writes files only after approval.
- Core and dev agents are language-agnostic and preload stack pack skills when installed.
- Model policy: opus for judgement agents, inherit for builders, sonnet for research and volume.
- `test-first` adds criterion, inventory and removal tests; review checklist checks wiring, scope and comments.

### Removed
- `frontend-conventions` from subdd-dev (now `subdd-typescript:react-conventions`).
- The personal plugin (moved out of this repo).

## [0.1.0] - 2026-11-09

### Added
- Initial marketplace: subdd-core, subdd-dev, subdd-product, subdd-aiops.
