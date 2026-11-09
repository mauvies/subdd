---
name: prd-writing
description: Product Requirements Document template and guidance. Use when writing, reviewing or updating a PRD or product brief.
---

# PRD

Save to `docs/product/<slug>-prd.md`.

```markdown
# <Product or feature>

Status: draft | in review | approved   Owner: <name>   Date: YYYY-MM-DD

## TL;DR
Three sentences: problem, solution, expected outcome.

## Problem
Who, pain, frequency, current workaround, evidence (data, quotes, tickets).

## Goals and success metrics
| Metric | Baseline | Target | Measured how |

## Non-goals

## Users and use cases
Primary persona, top 3 jobs to be done.

## Solution overview
Narrative of the experience. Link wireframes.

## Requirements
| ID | Requirement | Priority (Must/Should/Could) | Notes |

## Risks and assumptions
Assumption, how we validate it, by when.

## Release plan
MVP scope, phases, rollout, launch criteria.

## Open questions
```

Keep it under three pages. Detail belongs in the spec (`/subdd-core:spec`).
