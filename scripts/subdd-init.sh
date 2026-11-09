#!/usr/bin/env bash
# Enable the subdd plugins in a project: registers the marketplace, enables a plugin profile,
# and scaffolds CLAUDE.md and docs/specs without overwriting anything.
set -euo pipefail

usage() {
  cat <<USAGE
Usage: subdd-init.sh [project-dir] [options]

Options:
  --profile minimal|dev|full|product|ai   plugin set (default: dev)
  --stack typescript|none                 stack pack (default: typescript)
  --github <owner/repo>                   register the marketplace from GitHub instead of this local clone
  --no-git-writes                         set SUBDD_BLOCK_GIT_WRITES=1 so agents cannot commit or push

Profiles:
  minimal  subdd-core
  dev      subdd-core, subdd-dev
  full     subdd-core, subdd-dev, subdd-product, subdd-aiops
  product  subdd-core, subdd-product
  ai       subdd-core, subdd-dev, subdd-aiops
USAGE
}

SUBDD_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT="."
PROFILE="dev"
STACK="typescript"
GITHUB_REPO=""
BLOCK_GIT="0"

while [ $# -gt 0 ]; do
  case "$1" in
    --profile) PROFILE="${2:-}"; shift 2 ;;
    --stack) STACK="${2:-}"; shift 2 ;;
    --github) GITHUB_REPO="${2:-}"; shift 2 ;;
    --no-git-writes) BLOCK_GIT="1"; shift ;;
    -h|--help) usage; exit 0 ;;
    -*) echo "Unknown option: $1" >&2; usage; exit 1 ;;
    *) PROJECT="$1"; shift ;;
  esac
done

case "$PROFILE" in
  minimal) PLUGINS="subdd-core" ;;
  dev)     PLUGINS="subdd-core subdd-dev" ;;
  full)    PLUGINS="subdd-core subdd-dev subdd-product subdd-aiops" ;;
  product) PLUGINS="subdd-core subdd-product" ;;
  ai)      PLUGINS="subdd-core subdd-dev subdd-aiops" ;;
  *) echo "Unknown profile: $PROFILE" >&2; usage; exit 1 ;;
esac

case "$STACK" in
  typescript) PLUGINS="$PLUGINS subdd-typescript" ;;
  none) ;;
  *) echo "Unknown stack: $STACK" >&2; usage; exit 1 ;;
esac

if ! command -v node >/dev/null 2>&1; then
  echo "node is required to merge .claude/settings.json safely." >&2
  exit 1
fi

[ -d "$PROJECT" ] || { echo "Project directory not found: $PROJECT" >&2; exit 1; }
PROJECT="$(cd "$PROJECT" && pwd)"
if [ "$PROJECT" = "$SUBDD_ROOT" ]; then
  echo "Run this against a project, not against the marketplace repo itself." >&2
  exit 1
fi

mkdir -p "$PROJECT/.claude" "$PROJECT/docs/specs"
SETTINGS="$PROJECT/.claude/settings.json"

SUBDD_ROOT="$SUBDD_ROOT" PLUGINS="$PLUGINS" SETTINGS="$SETTINGS" GITHUB_REPO="$GITHUB_REPO" \
BLOCK_GIT="$BLOCK_GIT" node <<'NODE'
const fs = require("fs");
const path = require("path");
const { SUBDD_ROOT, PLUGINS, SETTINGS, GITHUB_REPO, BLOCK_GIT } = process.env;

const readJson = (file) => JSON.parse(fs.readFileSync(file, "utf8"));
const marketplaceName = readJson(path.join(SUBDD_ROOT, ".claude-plugin/marketplace.json")).name;

let settings = {};
if (fs.existsSync(SETTINGS)) {
  settings = readJson(SETTINGS);
  fs.copyFileSync(SETTINGS, SETTINGS + ".bak");
}

settings.extraKnownMarketplaces ??= {};
settings.extraKnownMarketplaces[marketplaceName] = {
  source: GITHUB_REPO
    ? { source: "github", repo: GITHUB_REPO }
    : { source: "directory", path: SUBDD_ROOT },
};
settings.enabledPlugins ??= {};
for (const p of PLUGINS.split(" ")) settings.enabledPlugins[`${p}@${marketplaceName}`] = true;

if (BLOCK_GIT === "1") {
  settings.env ??= {};
  settings.env.SUBDD_BLOCK_GIT_WRITES = "1";
}

fs.writeFileSync(SETTINGS, JSON.stringify(settings, null, 2) + "\n");
console.log(`Enabled: ${Object.keys(settings.enabledPlugins).join(", ")}`);
NODE

if [ ! -f "$PROJECT/CLAUDE.md" ] && [ ! -f "$PROJECT/AGENTS.md" ]; then
  cp "$SUBDD_ROOT/templates/project-CLAUDE.md" "$PROJECT/CLAUDE.md"
  echo "Created CLAUDE.md from the template. Fill it in, or run /subdd-aiops:new-factory."
fi

echo "Done. Open Claude Code in $PROJECT, trust the marketplace when prompted, and check /plugin."
