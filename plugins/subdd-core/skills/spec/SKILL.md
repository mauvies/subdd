---
name: spec
description: Workflow. Write a feature specification with acceptance criteria from an idea or ticket.
argument-hint: <feature idea, ticket link or description>
disable-model-invocation: true
---

# Workflow: spec

Input: $ARGUMENTS

1. Pick the next free number in `docs/specs/` and derive a kebab-case slug: `NN-<slug>`.
2. Delegate to the `subdd-core:spec-writer` agent with the input, the folder name and any relevant file paths you already know.
3. Show the user the spec summary, the criteria (AC ids), the assumptions and the open questions.
4. **Gate:** ask the user to approve or adjust. On approval set `Status: approved`.

Next step suggestion: `/subdd-core:plan NN`.
