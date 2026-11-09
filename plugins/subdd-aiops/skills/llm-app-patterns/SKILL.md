---
name: llm-app-patterns
description: Architecture patterns for LLM-powered product features - structured output, tool use, RAG, agents, streaming, caching, cost and safety. Use when designing or implementing AI features inside an application.
---

# LLM app patterns

## Ladder of complexity (stop at the first that works)

1. Single call with a good prompt and structured output.
2. Chain of calls with validation between steps.
3. Router to specialized prompts.
4. Retrieval-augmented generation.
5. Tool-using agent loop (Claude API tool use or Agent SDK).
6. Multi-agent orchestration.

## RAG checklist

Chunking by semantic units with overlap and metadata; hybrid search (BM25 + embeddings); rerank; cite sources in the answer; evaluate retrieval (recall@k) separately from generation; refresh pipeline for changing docs.

## Reliability

- JSON schema outputs, validated; retry once with the validation error.
- Timeouts, retries with backoff on 429/5xx, fallbacks.
- Idempotent tools; confirm before irreversible actions.
- Max steps and budget per agent run.

## Cost and latency

Prompt caching for stable prefixes (system prompt, tools, documents); smallest model that passes evals; streaming to the UI; batch for offline jobs; cap max tokens.

## Safety and privacy

Separate untrusted content from instructions (prompt injection); never give the model secrets it does not need; redact PII in logs; human review for high-stakes outputs.

## Observability

Trace id per request; log model, tokens, latency, cost, tool calls; sample outputs for review; online feedback (thumbs) feeding the eval set.
