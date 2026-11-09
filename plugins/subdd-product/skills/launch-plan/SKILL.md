---
name: launch-plan
description: Workflow. Build a go-to-market and launch plan with copy, channels and metrics for a product or feature.
argument-hint: <product or feature, audience, launch date if known>
disable-model-invocation: true
---

# Workflow: launch plan

Input: $ARGUMENTS

1. `subdd-product:growth-marketer` defines ICP, positioning, channels, timeline and metrics using the `launch-checklist` skill.
2. `subdd-product:copywriter` drafts landing hero, launch post and announcement email in the needed languages.
3. `subdd-product:seo-specialist` reviews the landing page for SEO and metadata.
4. Output `docs/product/<slug>-launch.md` with a dated checklist and owners.
