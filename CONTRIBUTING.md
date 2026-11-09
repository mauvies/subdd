# Contributing

Issues and pull requests are welcome.

## Before opening a PR

1. Follow the formats in `templates/` and the `claude-code-extensibility` skill.
2. Keep pieces generic. Anything tied to one project belongs in that project's `.claude/`;
   anything tied to one language belongs in a stack pack.
3. A description decides when a component triggers: say what it does, then "Use when ..." with
   the words users actually type.
4. Agents preload skills by bare name from their own plugin and by `plugin:skill` from others.
5. Run `node scripts/validate.mjs`, `bash scripts/test-hooks.sh`, `node scripts/catalog.mjs`
   and `claude plugin validate plugins/<plugin>`.
6. Bump the version of every plugin you changed in its `plugin.json` and add a line to
   `CHANGELOG.md`.

## Adding a stack pack

Create `plugins/subdd-<stack>/` with skills that mirror the TypeScript pack's roles
(`<stack>-style`, `<stack>-testing`, framework conventions, backend conventions), add it to
`.claude-plugin/marketplace.json`, and add its qualified skill names to the `skills:` lists of
the agents that should load them.
