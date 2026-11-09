---
name: tdd
description: Workflow. Implement one task test-first (red, green, refactor), inline or with the test-writer and implementer agents.
argument-hint: <spec number> <task id> [--inline | --agents] [--auto]   or   <free-text task>
disable-model-invocation: true
---

# Workflow: tdd

Task: $ARGUMENTS

1. Resolve the task. If a spec number and task id are given, read it from
   `docs/specs/<NN>-*/tasks.md`; otherwise treat the input as the task.
2. Pick the execution mode (`working-protocol`): `--inline` or `--agents` if given; otherwise
   inline for a small single-area task, agents when the task names a specialist or spans areas.
   State the mode in one line.
   **Inline only:** before writing any code, load with the Skill tool `test-first`,
   `engineering-principles` and `verify-before-done`, plus the stack pack skills that match the
   project when installed (for TypeScript: `subdd-typescript:typescript-style` and
   `subdd-typescript:typescript-testing`; for React code also `subdd-typescript:react-conventions`).
   Agents get these preloaded; inline they must be loaded explicitly.
3. **Red.** Inline: write the tests yourself following `test-first`. Agents: delegate to
   `subdd-core:test-writer`. Run them and confirm they fail for the right reason.
4. **Green.** Inline: implement the minimum to pass. Agents: delegate to
   `subdd-core:implementer`, or to the specialist the task names (`subdd-dev:frontend-engineer`,
   `subdd-dev:backend-engineer`, `subdd-dev:database-architect`...). Never edit the tests from
   step 3 without telling the user why.
5. **Refactor** while green. Re-read every changed file against the loaded style and
   comment rules (no comments that restate the code, formatting rules the formatter does not
   cover) and fix what does not comply. Then apply `verify-before-done`: run the full relevant suite, lint
   and type check, and show the actual output.
6. Tick the task in `tasks.md`.
7. **Finish.** Supervised (default): summarize tests added (with criteria), files changed, red and
   green output, deviations, and a draft commit message, then stop. With `--auto`: commit on the
   feature branch as `working-protocol` describes and report the commit.
