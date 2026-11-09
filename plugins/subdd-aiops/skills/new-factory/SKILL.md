---
name: new-factory
description: Workflow. Scaffold a project-specific AI factory - analyze the repo, pick plugins and stack pack, generate CLAUDE.md, settings, and project-specific agents, skills and workflows.
argument-hint: [project path] [short description of the project and its goals]
disable-model-invocation: true
---

# Workflow: new AI factory

Input: $ARGUMENTS (default path: current directory)

1. **Discover.** Read README, package manifests, folder structure, CI, existing `.claude/`,
   CLAUDE.md or AGENTS.md, and `docs/specs/`. Summarize: domain, stack, architecture, test
   setup, deploy target, and the rules the project already has. Existing rules are kept, never
   rewritten into a generic voice.
2. **Blueprint.** Delegate to `subdd-aiops:agent-architect` to fill [blueprint.md](blueprint.md):
   which plugins and stack pack to enable, which generic agents are enough, and which
   project-specific pieces are worth creating. Typical ones: a domain skill (glossary,
   invariants, "things that will bite you"), one or two project workflows, a project agent
   only when it needs its own tools or model, and hooks for rules that must always hold.
   **Gate: user approves the blueprint.**
3. **Generate.**
   - `CLAUDE.md`: if one exists, propose additions as a diff; otherwise start from the
     template `templates/project-CLAUDE.md` in the plugin marketplace repo, filled with real
     commands, checks and conventions from the repo.
   - `.claude/settings.json`: enable the chosen plugins; merge, never overwrite. Add
     `"env": { "SUBDD_BLOCK_GIT_WRITES": "1" }` if the user wants agents unable to commit.
   - Project skills in `.claude/skills/`, agents in `.claude/agents/`, via
     `subdd-aiops:skill-author`.
   - `docs/specs/` if the project does not have a spec location yet.
4. **Verify.** Frontmatter parses, names are unique, referenced agents and skills exist. List
   what was created and the first three commands to try.
5. If a generated piece looks reusable across projects, suggest `/subdd-aiops:promote`.
