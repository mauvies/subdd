#!/usr/bin/env node
// Lints subdd components: manifests parse, frontmatter is present and valid,
// names are unique per plugin, and preloaded skills exist (bare = same plugin, "plugin:skill" = another).
import fs from "node:fs";
import path from "node:path";

const root = path.resolve(path.dirname(new URL(import.meta.url).pathname), "..");
const errors = [];
const warnings = [];
const kebab = /^[a-z0-9]+(-[a-z0-9]+)*$/;

const readJson = (file) => {
  try {
    return JSON.parse(fs.readFileSync(file, "utf8"));
  } catch (e) {
    errors.push(`${rel(file)}: invalid JSON (${e.message})`);
    return null;
  }
};
const rel = (f) => path.relative(root, f);

const frontmatter = (file) => {
  const text = fs.readFileSync(file, "utf8");
  const match = text.match(/^---\n([\s\S]*?)\n---\n/);
  if (!match) return null;
  const fields = {};
  for (const line of match[1].split("\n")) {
    const kv = line.match(/^([A-Za-z-]+):\s*(.*)$/);
    if (kv) fields[kv[1]] = kv[2].replace(/\s+#.*$/, "").trim();
  }
  return { fields, body: text.slice(match[0].length) };
};

const marketplace = readJson(path.join(root, ".claude-plugin/marketplace.json"));
const allSkills = new Set();
const skillsByPlugin = {};
const plugins = [];

for (const entry of marketplace?.plugins ?? []) {
  const dir = path.join(root, entry.source);
  const manifest = readJson(path.join(dir, ".claude-plugin/plugin.json"));
  if (!manifest) continue;
  if (manifest.name !== entry.name) errors.push(`${entry.name}: plugin.json name "${manifest.name}" differs from marketplace entry`);
  plugins.push({ name: entry.name, dir });

  const skillsDir = path.join(dir, "skills");
  if (fs.existsSync(skillsDir)) {
    for (const s of fs.readdirSync(skillsDir)) {
      const file = path.join(skillsDir, s, "SKILL.md");
      if (!fs.existsSync(file)) { errors.push(`${rel(path.join(skillsDir, s))}: missing SKILL.md`); continue; }
      const fm = frontmatter(file);
      if (!fm) { errors.push(`${rel(file)}: missing frontmatter`); continue; }
      const name = fm.fields.name ?? s;
      if (!kebab.test(name)) errors.push(`${rel(file)}: name "${name}" is not kebab-case`);
      if (name !== s) warnings.push(`${rel(file)}: name "${name}" differs from folder "${s}"`);
      if (!fm.fields.description) errors.push(`${rel(file)}: missing description`);
      if (fm.fields["disable-model-invocation"] === "true" && !fm.body.includes("$ARGUMENTS") && fm.fields["argument-hint"])
        warnings.push(`${rel(file)}: has argument-hint but never uses $ARGUMENTS`);
      allSkills.add(name);
      (skillsByPlugin[entry.name] ??= new Set()).add(name);
    }
  }

  const hooks = path.join(dir, "hooks/hooks.json");
  if (fs.existsSync(hooks)) readJson(hooks);
}

for (const { name: plugin, dir } of plugins) {
  const agentsDir = path.join(dir, "agents");
  if (!fs.existsSync(agentsDir)) continue;
  const seen = new Set();
  for (const f of fs.readdirSync(agentsDir).filter((f) => f.endsWith(".md"))) {
    const file = path.join(agentsDir, f);
    const fm = frontmatter(file);
    if (!fm) { errors.push(`${rel(file)}: missing frontmatter`); continue; }
    const name = fm.fields.name ?? f.replace(/\.md$/, "");
    if (!kebab.test(name)) errors.push(`${rel(file)}: name "${name}" is not kebab-case`);
    if (seen.has(name)) errors.push(`${plugin}: duplicate agent name "${name}"`);
    seen.add(name);
    if (!fm.fields.description) errors.push(`${rel(file)}: missing description`);
    if (fm.fields.model && !["sonnet", "opus", "haiku", "inherit"].includes(fm.fields.model))
      warnings.push(`${rel(file)}: unusual model "${fm.fields.model}"`);
    for (const s of (fm.fields.skills ?? "").split(",").map((x) => x.trim()).filter(Boolean)) {
      const [owner, skill] = s.includes(":") ? s.split(":") : [plugin, s];
      if (!skillsByPlugin[owner]) warnings.push(`${rel(file)}: preloads "${s}" from a plugin outside this marketplace`);
      else if (!skillsByPlugin[owner].has(skill)) errors.push(`${rel(file)}: preloads unknown skill "${s}"`);
      if (owner === plugin && s.includes(":")) warnings.push(`${rel(file)}: "${s}" is in the same plugin; use the bare name`);
    }
  }
}

for (const w of warnings) console.log(`warn  ${w}`);
for (const e of errors) console.log(`error ${e}`);
console.log(`\n${plugins.length} plugins, ${allSkills.size} skills checked. ${errors.length} errors, ${warnings.length} warnings.`);
process.exit(errors.length ? 1 : 0);
