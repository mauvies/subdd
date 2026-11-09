---
name: eval-design
description: How to design evaluation suites for prompts, agents and LLM features - datasets, graders, rubrics, metrics and regression tracking. Use when testing or comparing prompts, models or agents.
---

# Eval design

## Layout

```
evals/<feature>/
  cases.jsonl        {"id", "input", "expected"|"criteria", "tags"}
  graders.(ts|py)    deterministic checks
  rubric.md          LLM-judge rubric
  results/<date>-<variant>.json
```

## Dataset

- 20-50 cases to start: typical (60%), edge (25%), adversarial (15%).
- Every production failure becomes a case.
- Tag cases by category to see where regressions happen.

## Graders, in order of preference

1. Exact match, regex, JSON schema validation.
2. Code checks (tests pass, SQL runs, links resolve, length limits).
3. LLM-as-judge with a rubric of binary or 1-5 criteria, asking for reasoning before the score, using a different or stronger model than the one judged. Spot-check judge agreement by hand.

## Reporting

Pass rate overall and per tag, diff vs baseline (fixed and broken cases), cost per case, latency p50/p95. A change ships only if it fixes more than it breaks on the categories that matter.
