---
name: eval
description: Workflow. Build or run an eval suite for a prompt, skill, agent or LLM feature and compare variants.
argument-hint: <target prompt/agent/feature> [variant to compare]
disable-model-invocation: true
---

# Workflow: eval

Target: $ARGUMENTS

1. Locate the target and any existing `evals/<target>/`.
2. If no suite exists, delegate to `subdd-aiops:eval-engineer` to create cases, graders and rubric following `eval-design`. **Gate: user reviews the cases.**
3. Run baseline and candidate (if given). Report pass rates per tag, fixed vs broken cases, cost and latency.
4. Recommend ship / iterate / reject with the evidence.
