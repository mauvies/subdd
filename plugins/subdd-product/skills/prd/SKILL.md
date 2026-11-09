---
name: prd
description: Workflow. Write a PRD for a product idea or feature with the product-manager agent.
argument-hint: <product or feature idea>
disable-model-invocation: true
---

# Workflow: PRD

Idea: $ARGUMENTS

1. Delegate to `subdd-product:product-manager` to clarify problem, users, metrics and scope.
2. If market context is missing and the idea is a new product, delegate to `subdd-product:market-researcher` in parallel for a short competitive scan.
3. Produce the PRD with the `prd-writing` skill and a first backlog of stories with the `user-stories` skill.
4. Show the TL;DR, metrics, MVP scope and open questions. Offer `/subdd-core:spec` for the first story.
