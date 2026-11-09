---
name: new-workflow
description: Workflow. Create a new user-invoked workflow skill that orchestrates agents and skills through steps and approval gates.
argument-hint: <process to automate> [--project | --plugin <plugin-name>]
disable-model-invocation: true
---

# Workflow: new workflow

Request: $ARGUMENTS

1. Map the process with the user: trigger, inputs, steps, which agent does each step, artifacts produced, gates needing human approval, done criteria.
2. Pick the pattern with `agent-design-patterns` (pipeline, fan-out, orchestrator, evaluator loop).
3. Verify every referenced agent and skill exists (or create them first with `/subdd-aiops:new-agent` / `new-skill`).
4. Delegate to `subdd-aiops:skill-author` using `templates/workflow/SKILL.md`, with `disable-model-invocation: true` and `$ARGUMENTS`.
5. Show the draft; write on approval; explain the invocation command.
