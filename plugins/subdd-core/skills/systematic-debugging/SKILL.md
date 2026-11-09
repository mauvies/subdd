---
name: systematic-debugging
description: Step-by-step root cause analysis method. Use when investigating a bug, failing test, flaky test, crash, performance regression or production incident.
---

# Systematic debugging

1. **Reproduce.** Get a reliable, minimal reproduction. Write it down as a command or test. If it is flaky, find the conditions that raise the failure rate.
2. **Read the evidence.** Full error message, full stack trace, logs around the timestamp, recent deploys and commits.
3. **Isolate.** Bisect: inputs, code paths (`git bisect`), environment, data. Shrink until the failure has one cause.
4. **Hypothesize.** Write each hypothesis and the observation that would disprove it. Test the cheapest one first.
5. **Verify the root cause.** You can explain why it fails, and why it did not fail before.
6. **Fix at the right level.** Fix the cause, not the symptom. Prefer making the invalid state impossible.
7. **Guard.** Add a regression test that fails before the fix and passes after.
8. **Sweep.** Search for the same pattern elsewhere.

For incidents, mitigate first (rollback, flag off, scale), then debug. Write a short postmortem: timeline, impact, root cause, contributing factors, action items.
