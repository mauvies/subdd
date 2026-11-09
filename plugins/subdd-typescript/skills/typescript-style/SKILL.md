---
name: typescript-style
description: TypeScript typing rules and code style conventions that formatters do not enforce. Use when writing, refactoring or reviewing any TypeScript or TSX code.
---

# TypeScript style

The project's CLAUDE.md and its formatter config win over this file. If the formatter
(Biome, Prettier) and a rule here disagree, the formatter wins: say so, so the config or the
rule gets fixed. Do not hand-format; run the formatter before finishing.

## Typing

- `strict` on; prefer `noUncheckedIndexedAccess`.
- No `any`, no non-null assertions (`!`), no casts (`as X`) to silence the compiler. Narrow
  with type guards, `satisfies`, or by validating at the boundary (Zod or similar).
- Exported functions declare parameter and return types. Inside a function, let TypeScript
  infer. Existing helpers that already declare a return type keep it.
- Model alternatives with discriminated unions, not optional-field bags or boolean flags.
- Types and interfaces: data properties first, function-typed members last.

## Layout

- Blank line before and after every `if`, `try`, `for`, `while` and `switch` block and every
  statement spanning several lines, unless it is the first or last statement of its block.
- Blank line before `return`, unless it is alone in its block.
- Consecutive single-line declarations of the same kind may stay together. A blank line
  separates logical groups; never one at the start or end of a block.
- Guard clauses instead of nesting; no `else` after a branch that returns.
- File order: imports, types, constants, the file's main function or component, then the
  helpers it uses. A helper a constant calls at load stays above it; a type read off a
  constant (`typeof`) follows it.

## Naming

- A number that does not explain itself becomes an `UPPER_SNAKE_CASE` constant at the top of
  the file. Standard domain symbols (`r`, `v`, `dt`, `G`) may stay short inside formulas.
- New booleans start with `is`, `has`, `can` or `should`; existing names are not renamed just
  for this.
- Handlers are `handleX` inside a component and `onX` as props.

## Functions

- Keep the form a function was written in: never convert between arrow functions and
  declarations in passing. New local functions inside a component are arrows.
- `describe` and `it` callbacks are arrows.

## Tests

- Arrange, act and assert separated by blank lines. Consecutive `expect` calls form one block.
- The test name states the behaviour; one concept per test; named fixtures, not magic numbers.
