---
name: diagnose-session
description: Workflow. Work out what went wrong in a Claude Code session with the subdd plugins - a skill or agent that fired when it should not, stayed silent, ignored the plan or burned tokens - with evidence from the transcript.
argument-hint: [session id, or empty for the current session] [what went wrong]
disable-model-invocation: true
---

# Workflow: diagnose a session

Input: $ARGUMENTS

1. Locate the transcript. Session logs live under `~/.claude/projects/<encoded project path>/`
   as `<session-id>.jsonl`. Without an id, use the most recent file for this project. Ask the
   user to share it if it is not readable from here.
2. Reconstruct the timeline: user requests, skills loaded, agents dispatched (with their
   prompts), tool calls, check results, and where tokens concentrated (large reads, repeated
   work, long agent runs).
3. Compare it with what the workflow defines: gates skipped, a mode chosen against the rules,
   an agent doing another agent's job, tests edited to pass, claims without evidence, scope
   creep, commits outside autonomous mode.
4. For each problem give: what happened (with the transcript line or excerpt), what should have
   happened, and the likely cause (a vague skill or agent description, a missing rule,
   conflicting instructions, missing context in a delegation).
5. Propose concrete fixes to the component files (description wording, a rule, a hook) and, if
   the user wants, a short bug report with secrets and personal data removed.
