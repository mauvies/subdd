#!/usr/bin/env bash
# Exercises the subdd-core hook scripts with sample tool inputs.
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILES="$ROOT/plugins/subdd-core/scripts/guard-protected-files.sh"
GIT="$ROOT/plugins/subdd-core/scripts/guard-git-writes.sh"
failures=0

expect() {
  local expected="$1" script="$2" payload="$3" env="$4"
  env $env bash "$script" <<<"$payload" >/dev/null 2>&1
  local actual=$?
  if [ "$actual" != "$expected" ]; then
    echo "FAIL expected $expected got $actual: $env $payload"
    failures=$((failures + 1))
  fi
}

file() { printf '{"tool_input":{"file_path":"%s"}}' "$1"; }
cmd() { printf '{"tool_input":{"command":"%s"}}' "$1"; }

expect 2 "$FILES" "$(file /p/.env)" ""
expect 2 "$FILES" "$(file /p/.env.local)" ""
expect 0 "$FILES" "$(file /p/.env.example)" ""
expect 0 "$FILES" "$(file /p/src/app.ts)" ""
expect 2 "$FILES" "$(file /p/pnpm-lock.yaml)" ""
expect 0 "$FILES" "$(file /p/pnpm-lock.yaml)" "SUBDD_ALLOW_LOCKFILE_EDITS=1"
expect 2 "$FILES" "$(file /p/secrets.yaml)" "SUBDD_PROTECTED_EXTRA=^secrets\.yaml$"

expect 0 "$GIT" "$(cmd 'git commit -m x')" ""
expect 2 "$GIT" "$(cmd 'git commit -m x')" "SUBDD_BLOCK_GIT_WRITES=1"
expect 2 "$GIT" "$(cmd 'pnpm test && git push')" "SUBDD_BLOCK_GIT_WRITES=1"
expect 2 "$GIT" "$(cmd 'git -c user.name=x commit -m y')" "SUBDD_BLOCK_GIT_WRITES=1"
expect 2 "$GIT" "$(cmd 'gh pr create --draft')" "SUBDD_BLOCK_GIT_WRITES=1"
expect 0 "$GIT" "$(cmd 'git status')" "SUBDD_BLOCK_GIT_WRITES=1"
expect 0 "$GIT" "$(cmd 'git diff main...HEAD')" "SUBDD_BLOCK_GIT_WRITES=1"
expect 0 "$GIT" "$(cmd 'gh pr view 3')" "SUBDD_BLOCK_GIT_WRITES=1"

[ "$failures" -eq 0 ] && echo "hook tests passed" || { echo "$failures hook test(s) failed"; exit 1; }
