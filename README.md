# subdd

Subagent-driven development for [Claude Code](https://code.claude.com).

subdd gives your coding agent a team of specialists and a clear way to work: write a spec,
plan it, write the tests first, build, review. You approve every important step. Nothing is
committed unless you say so.

## How it works

You describe what you want to build. The agent does not start coding. It writes a short spec
with numbered acceptance criteria and asks you to approve it.

Then it makes a plan: small tasks, each with its tests. If the change is risky (payments,
auth, data, public APIs), it plans in plan mode, where it cannot touch any file until you
approve.

For each task, it writes a failing test first, then the code that makes it pass. Small tasks
run in your main session. Bigger ones go to specialist subagents: a test writer, an
implementer, a frontend or backend engineer.

When the work is done, a reviewer checks it twice: first against the spec, then for code
quality. You get the test output as proof, and a ready commit message. You commit.

If you prefer, add `--auto` and the agent commits each task, pushes the branch and opens a
draft pull request for you.

## Installation

```bash
claude plugin marketplace add mauvies/subdd
claude plugin install subdd-core@subdd
claude plugin install subdd-dev@subdd
claude plugin install subdd-typescript@subdd   # only for TypeScript projects
```

Or set it up for one project, so everyone on the team gets it:

```bash
git clone https://github.com/mauvies/subdd
bash subdd/scripts/subdd-init.sh path/to/your-project --github mauvies/subdd
```

Then open Claude Code in your project and run:

```
/subdd-aiops:new-factory
```

It reads your repo and suggests a setup for it: project rules, skills and workflows. You
approve before anything is written.

## The basic workflow

1. **Spec.** `/subdd-core:spec add CSV export to the orders page`
   Writes `docs/specs/03-orders-csv-export/spec.md` with criteria AC1, AC2... You approve it.
2. **Plan.** `/subdd-core:plan 03`
   Splits the work into small tasks. Uses plan mode when the change is risky. You approve it.
3. **Build.** `/subdd-core:tdd 03 T1`
   Test first (red), then code (green), then cleanup. Shows you the test output.
4. **Review.** `/subdd-core:review`
   Checks the change against the spec, then checks code quality.
5. **Ship.** `/subdd-core:ship`
   Runs every check, drafts the commit message and the pull request text.

Or run all five in one go: `/subdd-core:feature add CSV export to the orders page`.
It still stops for your approval at the spec and the plan.

### Options

| Flag | What it does |
|---|---|
| `--inline` | Do the work in the main session. Cheaper and faster. Good for small changes. |
| `--agents` | Use specialist subagents. Better for big or multi-area changes. |
| `--auto` | Commit each task, push the branch and open a draft PR. Never merges. |
| `--worktree` | Work in a separate git worktree. |

Without `--inline` or `--agents`, subdd picks one based on the size of the plan and tells you
which.

## What's inside

**subdd-core**: the workflow.
- Agents: architect, spec writer, planner, test writer, implementer, code reviewer, debugger,
  refactorer, doc writer.
- Commands: `spec`, `plan`, `tdd`, `review`, `feature`, `ship`, `debug`, `issue-to-pr`.
- Safety: blocks edits to `.env` files, keys and lockfiles. Can also block all commits.

**subdd-dev**: specialists.
- Frontend, backend, UI/UX, DevOps, database, security, performance, QA, API design.
- Commands: `security-audit`, `ux-review`, `new-endpoint`.

**subdd-typescript**: rules for TypeScript projects.
- Strict types and code style, React and Next.js, Vitest and Playwright, Node backends.
- Agents use it only when it is installed.

**subdd-product**: product work. Off by default.
- Product manager, user research, market research, copywriting, SEO, data analysis, growth.
- Commands: `prd`, `market-research`, `launch-plan`.

**subdd-aiops**: build your own agents.
- Agent designer, prompt engineer, skill writer, eval engineer, LLM app engineer.
- Commands: `new-agent`, `new-skill`, `new-workflow`, `new-factory`, `eval`, `promote`,
  `diagnose-session`.

The full list, with when each piece is used: [docs/CATALOG.md](docs/CATALOG.md).

## Rules the agents follow

- Never commit, push or open a PR unless you ask (or use `--auto`).
- One change per commit, in [Conventional Commits](https://www.conventionalcommits.org) format.
- Tests first. A bug fix starts with a test that reproduces the bug.
- No "it should work". Show the test output.
- Say it when they leave the plan. Never do it silently.
- Invalid input fails with a clear error. No silent defaults.
- Few comments. A good name is better than a comment.

## Settings

Stop agents from committing in a project. Add this to `.claude/settings.json`:

```json
{ "env": { "SUBDD_BLOCK_GIT_WRITES": "1" } }
```

Stop Claude from adding `Co-Authored-By` to commits. Add this to `~/.claude/settings.json`:

```json
{ "attribution": { "commit": "", "pr": "" } }
```

## Make it yours

- **Your personal rules** go in `~/.claude/CLAUDE.md`. They apply to every project.
- **Your own agents and skills** go in `~/.claude/agents/` and `~/.claude/skills/`.
- **Project rules** go in the project's `CLAUDE.md` and `.claude/` folder.
  `/subdd-aiops:new-factory` creates them for you.
- **Something worth reusing?** `/subdd-aiops:promote` moves it from a project to your
  personal folder or into this repo.

## Philosophy

- **Spec first.** Agree on what to build before building it.
- **Tests first.** A test defines the behavior. The code follows.
- **You stay in control.** The agent proposes. You approve.
- **Evidence over claims.** Done means the checks pass, and you can see them pass.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) and [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

## License

MIT
