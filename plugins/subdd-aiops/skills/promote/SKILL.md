---
name: promote
description: Workflow. Promote a project-local agent, skill or workflow from the current repo's .claude/ so other projects can reuse it - to your user-level ~/.claude/ or into a plugin of a marketplace repo you maintain.
argument-hint: <path to .claude/agents/x.md or .claude/skills/x> [user | <path to marketplace repo>]
disable-model-invocation: true
---

# Workflow: promote

Source and target: $ARGUMENTS (default target: `user`)

1. Read the component. Strip project-specific details (names, URLs, business rules) into
   placeholders, or leave them in a project skill that stays behind.
2. Pick the destination:
   - `user`: `~/.claude/agents/` or `~/.claude/skills/`, available in all your projects.
   - a marketplace repo: ask which plugin it belongs to, or whether it needs a new one. Anything
     tied to one stack goes into that stack's pack.
3. Check for name collisions at the destination.
4. Show the generalized version. **Gate: user approves.** Then write it.
5. For a marketplace repo: bump the plugin version in `plugin.json`, add a CHANGELOG line, and run
   its validation (`node scripts/validate.mjs`, `claude plugin validate <plugin>`). Remind the user
   to commit there and run `/plugin marketplace update <name>` in projects.
