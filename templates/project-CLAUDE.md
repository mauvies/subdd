# <Project name>

<One paragraph: what this project is, who uses it, and the main goal right now. Link the
README or architecture doc for the model and flows.>

## Workflow

- Specs live in `docs/specs/NN-<slug>/` (spec, plan, tasks). Code is written against an
  approved spec; criteria are cited as `spec NN, ACn`.
- Tests first: red, then green. A bug fix starts with a test that reproduces it.
- <Who commits. Default: agents never commit or push; the human reviews and commits.>

## Commands

```bash
<install>
<dev>
<test>
<lint>
<typecheck>
<build>
```

## Checks

- Every step: `<typecheck>`, `<lint>` and `<test>`.
- When touching <area where only the build catches problems>: also `<build>`.

## Structure

- `<dir>/` <what lives here, and what must not>

## Conventions

- <Rules specific to this project: where queries live, how mutations are done, i18n, env
  validation, naming that matters in this domain>

## Things that will bite you

- <Non-obvious traps: a column whose name misleads, a step only the build catches, a
  framework quirk, an invariant that a "simplification" would break, with the test that pins it>

## Do not

- <Hard prohibitions: e.g. never push migrations with `db push`, never edit generated files,
  never hardcode a figure the model computes>
