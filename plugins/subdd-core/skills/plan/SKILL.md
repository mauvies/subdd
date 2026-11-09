---
name: plan
description: Workflow. Turn an approved spec into an implementation plan and task list, entering plan mode when the change is risky.
argument-hint: <spec number or folder, e.g. 03>
disable-model-invocation: true
---

# Workflow: plan

Spec: $ARGUMENTS

1. Resolve the folder `docs/specs/<NN>-*/` and read `spec.md`. If it is missing or not
   approved, stop and suggest `/subdd-core:spec`.
2. Decide whether to enter plan mode using the criteria in the `working-protocol` skill (money,
   auth, data/migrations, contracts, several modules, new dependency, hard rollback, unclear
   design). State the decision and the criterion in one line. If it applies, enter plan mode
   now; the user can override.
3. If the change crosses subsystems or adds infrastructure or a dependency, delegate first to
   `subdd-core:architect` for the design.
4. Delegate to `subdd-core:planner` for the plan and the task list. In plan mode, present them
   for approval without writing files.
5. **Gate:** after approval, write `plan.md` and `tasks.md` in the spec folder and show the task
   list with sizes, criteria covered, parallel groups and the agent for each task.

Next step suggestion: `/subdd-core:tdd <NN> T1` or `/subdd-core:feature <NN>`.
