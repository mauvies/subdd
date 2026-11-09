---
name: react-conventions
description: React and Next.js conventions - component structure, hooks order, state, data fetching, forms, styling and performance. Use when creating or reviewing React components, pages, hooks or Next.js routes.
---

# React and Next.js conventions

Follow the project's existing patterns first; these are defaults.

## Structure (feature-first)

```
src/
  app/                  routing only (Next.js App Router)
  features/<feature>/   components, hooks, api, types and tests of one feature
  components/ui/        design-system primitives, no business logic
  lib/                  framework-agnostic code
```

## Components

- One component per file, named export, PascalCase file name.
- `interface Props` right above the component, typing its argument (`FooProps` only when
  exported and used elsewhere).
- Order inside a component, with a blank line between groups: local state (`useState`,
  `useReducer`, `useRef`), custom and context hooks, derived values, handlers, effects, early
  returns, then the JSX. When one value needs another, the data decides the order. No hook
  after an early return.
- No nested ternaries in JSX; extract a component or a variable.
- Composition over configuration: `children` and slots before many props. Presentational
  components hold no business logic.

## State and data

- Server state: Server Components and loaders, or TanStack Query with a query-key factory per
  feature. Do not fetch in `useEffect` what the framework or a library handles.
- URL is state: filters, pagination and tabs live in search params.
- Derive, don't sync: compute values instead of copying props into state.
- Global client state only when shared and frequent (Zustand or context).
- Forms: React Hook Form or TanStack Form with Zod schemas, shared with the server when possible.

## Next.js App Router

- Server Components by default; `"use client"` only where interactivity needs it, as low in the
  tree as possible.
- Mutations through Server Actions when the project uses them; validate input inside the action.
- Never import server-only code (secrets, `fs`, image processing) into the client graph. Only
  `next build` catches it: run it when touching shared libraries.

## Styling and performance

- Design tokens for color, spacing, type and radius; use the Tailwind scale before an
  arbitrary value. Respect `prefers-reduced-motion` and `prefers-color-scheme`.
- Code-split heavy routes and widgets; `next/image` or responsive `srcset`; avoid layout shift.
- Memoize only after profiling.
