---
name: ux-review
description: Workflow. UX and accessibility review of a page, flow or component, with prioritized recommendations.
argument-hint: <route, component path or flow description>
disable-model-invocation: true
---

# Workflow: UX review

Target: $ARGUMENTS

1. Delegate to `subdd-dev:ui-ux-designer` for a heuristic and flow review of the target.
2. In parallel, run an accessibility pass using the `accessibility` skill (axe via Playwright if the app can run locally).
3. Merge into a prioritized list: issue, user impact, evidence (screenshot or code location), recommendation, effort (S/M/L).
4. Offer to turn the top items into a spec with `/subdd-core:spec`.
