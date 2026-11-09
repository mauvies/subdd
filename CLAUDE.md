# subdd

A Claude Code plugin marketplace of reusable agents, skills, workflows and hooks. Read
README.md and docs/ARCHITECTURE.md before changing structure.

## Rules for working here

- Components follow `templates/` and the `claude-code-extensibility` skill in subdd-aiops.
- Descriptions decide when components trigger: what it does, then "Use when ...".
- Core plugins stay language-agnostic; stack specifics go in `subdd-<stack>` packs.
- Nothing personal or project-specific in this repo.
- Prompts in English, concise; no em dashes.
- After any change: `node scripts/validate.mjs`, `bash scripts/test-hooks.sh`,
  `node scripts/catalog.mjs`, `claude plugin validate plugins/<plugin>`, bump the plugin
  version and update CHANGELOG.md.
