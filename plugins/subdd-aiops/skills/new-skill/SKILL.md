---
name: new-skill
description: Workflow. Create a new knowledge skill (model-invoked) with a description that triggers correctly and optional supporting files.
argument-hint: <knowledge or procedure to capture> [--project | --plugin <plugin-name>]
disable-model-invocation: true
---

# Workflow: new skill

Request: $ARGUMENTS

1. Gather the knowledge: ask for or read the source material (docs, conventions, examples from the codebase). A skill without real content is noise.
2. Decide location: `.claude/skills/<name>/SKILL.md` (project, default) or `plugins/<p>/skills/<name>/SKILL.md` (subdd).
3. Delegate to `subdd-aiops:skill-author` using `templates/skill/SKILL.md`. Long references go into sibling files linked from SKILL.md.
4. Write a description that starts with what it provides and "Use when ..." with the words a user would actually type.
5. Show the draft, write on approval, and list 3 prompts that should trigger it and 2 that should not.
