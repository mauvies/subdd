---
name: user-stories
description: User story and acceptance criteria format, INVEST checks and story splitting patterns. Use when writing backlog items, epics or tickets.
---

# User stories

Format: **As a** <role>, **I want** <capability>, **so that** <benefit>.

Acceptance criteria in Given/When/Then, 3-7 per story.

INVEST check: Independent, Negotiable, Valuable, Estimable, Small, Testable.

Splitting patterns when a story is too big: by workflow step, by business rule, by data variation, by interface (web first, mobile later), happy path first then edge cases, by CRUD operation, spike then implementation.

Ticket template:

```markdown
## Story
As a ..., I want ..., so that ...

## Acceptance criteria
- Given ..., when ..., then ...

## Notes
Designs, dependencies, out of scope.
```
