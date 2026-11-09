---
name: market-research
description: Workflow. Research a market, niche or set of competitors and produce a cited report with implications.
argument-hint: <market, niche, product category or competitor list>
disable-model-invocation: true
---

# Workflow: market research

Topic: $ARGUMENTS

1. Delegate to `subdd-product:market-researcher`. For broad topics, split into parallel sub-questions (market size, competitors, pricing, trends) and run them concurrently.
2. Merge into one report with the `competitive-analysis` structure plus sizing and trends.
3. Every figure cited with source and date. Save to `docs/research/`.
4. Return the five most important implications.
