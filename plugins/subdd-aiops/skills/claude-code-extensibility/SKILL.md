---
name: claude-code-extensibility
description: Reference for Claude Code extension formats - subagents, skills, workflow skills, hooks, MCP, plugins and marketplaces - and when to use each. Use when creating, editing or choosing between agents, skills, commands, hooks or plugins.
---

# Claude Code extensibility reference

Formats change; when in doubt check https://code.claude.com/docs and run `claude plugin validate <dir>`.

## Choosing the primitive

| Need | Use |
|---|---|
| Rule that must always hold, context for every session | `CLAUDE.md` (project) |
| Deterministic enforcement (block, format, lint, notify) | Hook |
| Knowledge/procedure Claude applies when relevant | Skill (model-invoked) |
| Procedure the user triggers by name | Skill with `disable-model-invocation: true` (a "workflow") |
| Specialist with isolated context, restricted tools or different model | Subagent |
| Access to an external system | MCP server |
| Shareable bundle of all the above | Plugin, distributed via a marketplace |

## Subagent (`agents/<name>.md`)

```markdown
---
name: kebab-name
description: What it does. Use when <trigger situations>.
tools: Read, Grep, Glob, Write, Edit, Bash   # omit to inherit all
model: sonnet | opus | haiku | inherit
skills: skill-a, skill-b                     # preloaded skills
color: blue
---
System prompt: role, process, rules, output format.
```

In plugins: `permissionMode`, `hooks`, `mcpServers` are ignored. Invoked as `<plugin>:<name>`.

`skills:` preloads skill content into the agent's context. Bare names refer to the agent's own
plugin; skills from another plugin use the qualified form `other-plugin:skill`. If that plugin
is not installed the agent still loads, without the skill, which is how agents load optional
stack packs (`subdd-typescript:typescript-style`).

Model policy in this repo: `opus` for judgement (design, specs, plans, tests, review,
debugging, security, data and API design), `inherit` for builders so the session model decides,
`sonnet` for research and high-volume work.

## Skill (`skills/<name>/SKILL.md`)

```markdown
---
name: kebab-name
description: What it provides. Use when <trigger>.
argument-hint: <args>              # optional
disable-model-invocation: true     # optional: only the user can run it
allowed-tools: Read, Grep          # optional
---
Instructions. `$ARGUMENTS` holds what the user typed after the command.
```

Invoked as `/<plugin>:<skill>` in plugins, `/<skill>` in `.claude/skills/`. Supporting files (templates, scripts, references) live next to SKILL.md and are linked from it.

## Hooks (`hooks/hooks.json` in plugins, `hooks` in settings.json)

```json
{ "hooks": { "PostToolUse": [ { "matcher": "Write|Edit",
  "hooks": [ { "type": "command", "command": "bash \"${CLAUDE_PLUGIN_ROOT}/scripts/x.sh\"" } ] } ] } }
```

Events include PreToolUse, PostToolUse, UserPromptSubmit, Stop, SubagentStop, SessionStart, Notification. Input arrives as JSON on stdin; exit code 2 blocks (PreToolUse) and stderr is shown to Claude.

## Settings worth knowing

- Disable AI attribution in commits and PRs (user or project settings):
  `{ "attribution": { "commit": "", "pr": "" } }` (replaces the deprecated `includeCoAuthoredBy`).
- Project env for hooks: `{ "env": { "SUBDD_BLOCK_GIT_WRITES": "1" } }`.

## Plugin

```
my-plugin/
  .claude-plugin/plugin.json   { "name", "version", "description", "author" }
  agents/  skills/  commands/ (legacy)  hooks/hooks.json  .mcp.json  scripts/
```

## Marketplace

`.claude-plugin/marketplace.json` at the repo root: `{ "name", "owner": { "name" }, "plugins": [ { "name", "source": "./plugins/x", "description" } ] }`.

Project activation in `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "subdd": { "source": { "source": "directory", "path": "/abs/path/subdd" } }
  },
  "enabledPlugins": { "subdd-core@subdd": true }
}
```
