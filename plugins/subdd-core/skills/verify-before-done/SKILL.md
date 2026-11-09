---
name: verify-before-done
description: Evidence before claims. Use before saying a task, fix or feature is done, fixed, passing or working, and before any commit or PR.
---

# Verify before done

"Done" is a claim; the output of a command is evidence. Never report success without it.

1. Run the checks that prove the claim, fresh, after the last edit: the relevant tests, then
   lint and type check (and the build when the change can only fail there).
2. Read the output. A command that ran is not a command that passed: look for failures,
   skipped tests, warnings promoted to errors, and tests that did not run at all.
3. Show the evidence: the command and the lines that matter (counts of passed, failed and
   skipped, error messages). Never paraphrase a failure as a pass.
4. For a bug fix, show the regression test failing before the fix and passing after.
5. Check the claim against the spec: each acceptance criterion the task covers has a test that
   ran and passed.
6. If something could not be verified (no test setup, a service unavailable, a manual UI
   check), say exactly what was not verified instead of implying it was.

Words like "should work", "probably fixed" or "looks good" are not allowed in a completion
report.
