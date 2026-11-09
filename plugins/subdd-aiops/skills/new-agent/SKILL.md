---
name: new-agent
description: Workflow. Create a new subagent definition (project-local or in an subdd plugin) with the right tools, model and prompt.
argument-hint: <what the agent should do> [--project | --plugin <plugin-name>]
disable-model-invocation: true
---

# Workflow: new agent

Request: $ARGUMENTS

1. Check existing agents (`.claude/agents/`, installed plugins) for overlap. If one covers 80% of the need, propose extending it or adding a skill to it instead.
2. Decide the location: `--project` → `.claude/agents/<name>.md` in the current repo (default); `--plugin <p>` → `plugins/<p>/agents/<name>.md` in subdd.
3. Delegate to `subdd-aiops:skill-author` to draft it from `templates/agent.md`, with `subdd-aiops:prompt-engineer` reviewing the prompt and description.
4. Show the draft. On approval write it and explain how to invoke it (`@agent-<name>` or by asking Claude to use it).
5. Suggest 3 eval prompts to sanity-check the agent.
