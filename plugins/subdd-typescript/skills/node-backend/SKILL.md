---
name: node-backend
description: Node.js and TypeScript backend conventions - env validation, request validation, frameworks, ORMs and migrations, background jobs. Use when writing server-side TypeScript (APIs, Server Actions, workers, scripts).
---

# Node backend (TypeScript)

- **Environment:** validated once at startup with a schema (T3 Env, Zod, envalid). Every new
  variable is added there in the same change. Secrets never inlined or logged.
- **Input:** validate at the edge with Zod (or the framework's schema system) and infer types
  from the schema instead of duplicating them.
- **Frameworks:** follow the project (Next.js Server Actions and route handlers, Fastify,
  Express, Hono). For a new standalone API prefer Fastify with schema-based validation.
- **Data access:** queries live in one layer (`src/database/queries/`, repositories), never
  inline in components or handlers. Parameterised queries only.
- **Migrations:** generated and committed as SQL; applied with a migrate command, never a
  schema push against a shared database (`drizzle-kit generate` + `migrate`, Prisma
  `migrate`, Supabase SQL migrations). A migration is immutable once merged.
- **Errors:** typed domain errors mapped to transport errors in one place.
- **Background work:** a job system (Inngest, BullMQ, cloud queues) with idempotent handlers,
  not fire-and-forget promises in a request.
- **Money and ids:** integers in minor units for money, never floats; UUID/ULID strings for ids.
