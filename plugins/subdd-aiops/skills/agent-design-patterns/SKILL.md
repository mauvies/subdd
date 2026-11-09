---
name: agent-design-patterns
description: Patterns for multi-agent and agentic workflow design - pipelines, orchestrator-workers, routing, parallelization, evaluator-optimizer, human gates. Use when designing how agents collaborate or structuring an agentic workflow.
---

# Agent design patterns

Start with the simplest pattern; add agents only when they remove a measured problem.

| Pattern | Shape | Use when |
|---|---|---|
| Prompt chain / pipeline | A → B → C with artifacts on disk | Steps are known and sequential (spec → plan → build → review) |
| Router | Classifier picks one specialist | Inputs vary in kind (bug vs feature vs question) |
| Parallel fan-out | N workers on independent slices, then merge | Independent subtasks (research sub-questions, files in disjoint areas) |
| Orchestrator-workers | Lead agent plans, delegates, integrates | Subtasks are not known upfront |
| Evaluator-optimizer | Generator ↔ critic loop with a stop rule | Clear quality criteria exist (tests, rubric) |
| Human gate | Pause for approval | Irreversible, expensive or taste-dependent decisions |

## Design rules

- **Artifacts over chat.** Agents hand off through files (spec.md, plan.md, report.md), not long messages.
- **Narrow tools.** Reviewers read-only; writers no network unless needed; deployers gated.
- **Clear contracts.** Each agent: input, output file/format, done criteria.
- **Context hygiene.** Subagents exist to keep the main context clean; return summaries, not dumps.
- **Fresh eyes for checks.** The reviewer must not be the author.
- **Stop rules.** Max iterations for loops; escalate to the human when stuck.
- **Model by judgement load.** Opus for design/review, Sonnet for building, Haiku for bulk/simple.
