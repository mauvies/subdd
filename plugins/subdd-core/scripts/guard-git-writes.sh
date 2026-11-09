#!/usr/bin/env bash
# Opt-in: with SUBDD_BLOCK_GIT_WRITES=1 (set it under "env" in the project's .claude/settings.json),
# agents cannot commit, push, tag, rewrite history or open/merge PRs. The human does that.
set -euo pipefail

[ "${SUBDD_BLOCK_GIT_WRITES:-0}" != "1" ] && exit 0

input="$(cat)"
command="$(printf '%s' "$input" | sed -n 's/.*"command"[[:space:]]*:[[:space:]]*"\(.*\)".*/\1/p' | head -n1)"
[ -z "$command" ] && exit 0

blocked='(^|[;&|[:space:]])git([[:space:]]+-[cC][[:space:]]+[^[:space:]]+|[[:space:]]+-[^[:space:]]+)*[[:space:]]+(commit|push|merge|rebase|reset[[:space:]]+--hard|tag|cherry-pick|revert)([[:space:]]|$)|(^|[;&|[:space:]])gh[[:space:]]+pr[[:space:]]+(create|merge)([[:space:]]|$)'

if printf '%s' "$command" | grep -Eq "$blocked"; then
  echo "subdd-core: git writes are disabled in this project (SUBDD_BLOCK_GIT_WRITES=1). Stop here and give the user the draft commit message or PR description instead." >&2
  exit 2
fi
exit 0
