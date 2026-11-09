---
name: observability
description: Logging, metrics, tracing and alerting conventions. Use when adding logs, instrumenting services, defining SLOs, setting up dashboards or alerts, or debugging production behavior.
---

# Observability

- **Logs:** structured JSON, one event per line, with `level`, `msg`, `service`, `env`, `traceId`, `requestId`, `userId` (if allowed). Log decisions and failures, not every step. Never log secrets, tokens or full PII.
- **Levels:** error = someone must act; warn = degraded but handled; info = business events; debug = off in prod.
- **Metrics:** RED for services (Rate, Errors, Duration), USE for resources (Utilization, Saturation, Errors). Histograms for latency. Business metrics for key events.
- **Tracing:** OpenTelemetry SDK, propagate context across HTTP and queues, span per external call.
- **SLOs:** define per user-facing journey (availability and latency), alert on error-budget burn rate, not raw thresholds.
- **Alerts:** actionable, owned, linked to a runbook. Page only for user impact.
- **Errors:** Sentry or equivalent with release tracking and source maps.
