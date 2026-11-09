---
name: spec-driven-development
description: Method and templates for spec-driven development (numbered spec folders with spec, plan and tasks, criteria ids). Use when writing or reading a feature spec, an implementation plan or a task breakdown, or when files under docs/specs/ are involved.
---

# Spec-driven development

Each feature gets a numbered folder, `docs/specs/NN-<slug>/` (next free number, two digits),
unless the project's CLAUDE.md names another location:

| Artifact | Question it answers | Owner agent |
|---|---|---|
| `spec.md` | What and why | spec-writer |
| `plan.md` | How, and what could go wrong | planner / architect |
| `tasks.md` | In what order, in what slices | planner |

Code is written only against an approved spec. When reality contradicts the spec, update the
spec first, then the code. Acceptance criteria have stable ids (`AC1`, `AC2`...) that never get
renumbered; tests, comments and commits cite them as `spec 03, AC2`.

## spec.md template

```markdown
# NN. <Feature name>

Status: draft | approved | implemented

## Problem
Who has the problem and what it costs them today.

## Goals
- Measurable outcomes.

## Non-goals
- What this explicitly does not do.

## Requirements
R1. <behaviour>

## Acceptance criteria
- AC1 (R1): Given <context>, when <action>, then <observable result>.

## Non-functional requirements
Performance, security, accessibility, observability, limits.

## Assumptions and open questions
```

## plan.md template

```markdown
# Plan: NN. <Feature name>

## Approach
The design and why. Alternatives considered, briefly.

## Affected areas
Files and modules created or changed.

## Data and API changes
Schemas, migrations, endpoints, events.

## Risks
Risk, mitigation, task where it surfaces.

## Rollout
Flags, migration order, backfill, rollback.
```

## tasks.md template

```markdown
# Tasks: NN. <Feature name>

- [ ] T1 (S) <goal>. Criteria: AC1. Tests: <...>. Done when: <...>. Agent: <...>
- [ ] T2 (M) ... [parallel with T3]
```

Rules: vertical slices, each task leaves the build green, nothing bigger than M, every
acceptance criterion covered by at least one task.
