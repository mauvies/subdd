---
name: <kebab-case-name>
description: Workflow. <What it accomplishes end to end>.
argument-hint: <what the user passes>
disable-model-invocation: true
---

# Workflow: <name>

Input: $ARGUMENTS

1. <Step>. Delegate to `<plugin>:<agent>` with <inputs>. Output: <artifact path>.
2. <Step>. **Gate: <what the user approves>.**
3. <Step>.
4. Report: <what to show at the end> and suggest the next command.
