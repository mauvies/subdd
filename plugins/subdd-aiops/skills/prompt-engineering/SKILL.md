---
name: prompt-engineering
description: Principles and checklist for writing system prompts, agent instructions, skill descriptions and in-app LLM prompts. Use when writing or debugging any prompt.
---

# Prompt engineering

## Structure of a good system prompt

1. **Role and goal** in one or two sentences, including what success looks like.
2. **Context** the model cannot infer: audience, domain facts, constraints, stack.
3. **Process** as numbered steps when order matters.
4. **Rules** as short imperatives, most important first. Explain the why for non-obvious ones; models generalize from reasons.
5. **Output format** precisely: sections, schema, length, file location.
6. **Examples** (optional): 1-3 diverse ones, marked as illustrative, never the only pattern.

## Principles

- Be explicit; the model does what you ask, not what you meant.
- Positive instructions ("write in prose") work better than prohibitions alone.
- Separate instructions from data with XML tags or clear delimiters.
- Long documents first, question last.
- Ask for reasoning before answers on judgement tasks.
- Fewer, stronger rules beat long rule lists; contradictions cause erratic behavior.
- For descriptions that drive routing (skills, agents, tools): lead with the trigger and use the words users actually say.

## Debugging a prompt

Collect failing cases → find the instruction that is missing, ambiguous or conflicting → minimal change → re-run all cases (not just the failing one).
