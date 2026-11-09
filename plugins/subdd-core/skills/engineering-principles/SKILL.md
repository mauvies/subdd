---
name: engineering-principles
description: Language-agnostic code quality principles - fail loudly, comments, deriving values, small functions, no dead code, and checking that new code is actually wired in. Use when writing, refactoring or reviewing code in any language.
---

# Engineering principles

The project's CLAUDE.md and stack conventions win over this file.

## Clarity

- Clarity over cleverness. Optimise only when a measurement shows it is needed.
- Small functions with one responsibility. Logic in pure functions; side effects (I/O, DOM,
  network, timers, database) at the edges.
- Names say what something is in domain terms.
- Follow the patterns already in the codebase.
- No dead code, no commented-out code, no abstractions for needs that do not exist yet, no
  error handling for conditions that cannot occur.

## Comments

Good names and small functions should make code readable without comments. **If a better name
would make a comment unnecessary, rename instead.** A comment earns its place only when a
reader would otherwise ask "why?": a non-obvious choice, a workaround, a precondition that
cannot be checked at runtime, a rule from a spec (cite it, `spec 03, AC2`, rather than copying
it). Never comment what the code already says, never narrate control flow, never restate a
signature. Over-commented code is a review finding, not a style nit.

## Fail loudly

- Invalid input throws (or returns a typed error) that names the field and the problem:
  `price: expected a positive integer, got "abc"`.
- Never swallow an error: no empty `catch`, no silent default (`0`, `null`, `[]`) that hides a
  failure. A silent default turns a bug into wrong data that surfaces far from its cause.
- Where a path must not throw (a webhook that would be retried, a batch that must continue),
  record or report the failure explicitly instead of dropping it.

## Derive, don't type

A figure, date or limit that a computation or a source of truth decides is computed or
imported, never typed by hand into code, copy, docs or config. A typed number is right on the
day it is written and wrong after the next change.

## Wired in

Code correct in isolation but never connected is a common agent mistake. Before calling
something done:

- Every new exported function, component, route or job has a caller or registration. If not,
  say so.
- Every new script or command works from a clean state (services stopped, env unset), not
  only on an already warmed-up machine.
- Every new config entry or env var lands with the code that reads it, in the package that
  needs it.
