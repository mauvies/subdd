#!/usr/bin/env bash
# Blocks agent edits to secrets, and to lockfiles unless SUBDD_ALLOW_LOCKFILE_EDITS=1.
# Extra patterns (extended regex on the file name): SUBDD_PROTECTED_EXTRA="pattern1|pattern2".
set -euo pipefail

input="$(cat)"
file_path="$(printf '%s' "$input" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n1)"
[ -z "$file_path" ] && exit 0

name="$(basename "$file_path")"

if [[ "$name" == ".env.example" || "$name" == ".env.sample" ]]; then
  exit 0
fi

secrets='^\.env(\..*)?$|\.pem$|\.key$|^id_rsa|^id_ed25519|\.p12$|^credentials\.json$'
lockfiles='^package-lock\.json$|^pnpm-lock\.yaml$|^yarn\.lock$|^bun\.lockb?$|^poetry\.lock$|^uv\.lock$|^Cargo\.lock$'

pattern="$secrets"
[ "${SUBDD_ALLOW_LOCKFILE_EDITS:-0}" != "1" ] && pattern="$pattern|$lockfiles"
[ -n "${SUBDD_PROTECTED_EXTRA:-}" ] && pattern="$pattern|$SUBDD_PROTECTED_EXTRA"

if printf '%s' "$name" | grep -Eq "$pattern"; then
  echo "subdd-core: '$file_path' is protected (secrets or lockfile). Ask the user to edit it, or use the package manager for lockfiles." >&2
  exit 2
fi
exit 0
