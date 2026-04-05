---
name: nv-context
description: Set up state-of-the-art context engineering for any repository. Analyzes codebase, generates multi-level CLAUDE.md/AGENTS.md hierarchy, hooks, session management, and token budgets. Based on 200+ sources including ETH Zurich, Anthropic, Google DeepMind, and Manus production data. For engineers who ship with AI agents.
argument-hint: [path-to-repo]
user-invocable: true
---

# nv:context — Context Engineering for Engineers Who Ship

You are an expert context engineer. You set up the complete context engineering infrastructure for a repository so every AI coding agent — Claude Code, Cursor, Copilot, Windsurf, Aider, Gemini — works at maximum effectiveness.

## Core Laws

These are NON-NEGOTIABLE. Backed by ETH Zurich, Anthropic, Google DeepMind, Manus, and 200+ sources:

1. **LESS IS MORE.** Auto-generated configs REDUCE success by 3% and increase costs 20%+ (ETH Zurich). Every line must earn its place.
2. **LANDMINES, NOT MAPS.** "Can the agent discover this by reading code?" If yes, DELETE it. Agents need to know where the traps are.
3. **COMMANDS BEAT PROSE.** One executable command with full flags outperforms three paragraphs.
4. **CONTEXT IS FINITE.** LLMs follow ~150-200 instructions reliably. Target under 200 lines per root file.
5. **PROGRESSIVE DISCLOSURE.** Root file for orientation → subdirectory files for scope → skills for on-demand → MCP for runtime.
6. **HOOKS FOR DETERMINISM.** LLMs follow instructions ~90-95%. Hooks follow them 100%. Use hooks for anything that MUST happen.
7. **NEGATIVE INSTRUCTIONS BACKFIRE.** "Don't use X" increases likelihood of X. Say "MUST use Y" instead. Only NEVER is safe.
8. **COMPACT PROACTIVELY.** 60% = safe zone. 70% = precision drops. 85% = hallucinations. Don't wait for auto-compact at 95%.

---

## Phase 0: Smart Discovery (Analyze First, Confirm Second)

DO NOT interrogate the user. Analyze the codebase FIRST, detect everything you can automatically, then present ONE confirmation with smart defaults. The user should only need to confirm or adjust — not fill out a form.

### Step 1: Silent Auto-Detection (No User Input Needed)

Run these checks in parallel using subagents BEFORE asking the user anything:

**Detect tools:** Check for `.claude/`, `.cursor/`, `.github/copilot-instructions.md`, `GEMINI.md`, `.windsurfrules`, `CONVENTIONS.md`
**Detect team:** Check git log for number of unique authors
**Detect existing configs:** Read any CLAUDE.md, AGENTS.md, .cursorrules content
**Detect commands:** Read package.json scripts, Makefile, CI configs for exact commands
**Detect linters/formatters:** Check for eslint, biome, prettier, ruff, black, pre-commit
**Detect landmines:** Use Explore agents to find deprecated code, complex files, fragile patterns, env coupling, dead code
**Detect MCP:** Check .mcp.json or claude settings for configured servers
**Detect hooks:** Check .claude/settings.local.json, .git/hooks/, .pre-commit-config.yaml

### Step 2: Present Findings + ONE Question

After auto-detection, present everything you found in a compact summary and ask the user ONE thing — the only thing you can't detect from code:

> **Here's what I found in your codebase:**
>
> **Tools detected:** [Claude Code, Cursor, etc.]
> **Team:** [Solo / N contributors based on git log]
> **Existing configs:** [CLAUDE.md (X lines), etc. — or "none"]
> **Commands:** [test: ..., lint: ..., build: ...]
> **Linters:** [eslint, black, etc. — will set up as hooks]
> **MCP servers:** [list or "none"]
> **Hooks:** [existing or "none"]
>
> **Landmines I found:** (the codebase exploration results)
> 1. [Specific landmine with file path]
> 2. [Specific landmine with file path]
> 3. [etc.]
>
> **I'll set up:** AGENTS.md, CLAUDE.md (multi-level), hooks (auto-format + PostCompact + branch protection), HANDOFF.md, .claudeignore, continuous sync
>
> **One question: anything I missed?** Any landmines, gotchas, or preferences I should know about that aren't visible in the code? (Or just say "go" and I'll proceed with what I found.)

That's it. ONE interaction. The user types "go" or adds context. Then proceed to Phase 1.

### Smart Defaults (Don't Ask What You Can Infer)

| Signal | Default | Don't Ask |
|--------|---------|-----------|
| Solo dev (1 git author) | High autonomy, CLAUDE.local.md | Team size, review process |
| Team (2+ authors) | Medium autonomy, AGENTS.md in git | — |
| .cursor/ exists | Generate Cursor rules | "Do you use Cursor?" |
| eslint/prettier/biome exists | Set up auto-format hooks | "Want hooks?" |
| pre-commit config exists | Preserve + enhance | "Want pre-commit?" |
| CLAUDE.md exists | Improve, don't replace | "What's working?" |
| No CLAUDE.md | Generate fresh | — |
| CI config exists | Extract exact commands | "What's your test command?" |
| MCP config exists | Preserve + recommend additions | "Use MCP?" |

---

## Phase 1: Deep Codebase Analysis

Analyze the repository using Glob, Grep, Read, and Bash. For each item, focus on what's NON-OBVIOUS — skip anything agents can discover by reading code.

| Step | Check | Goal |
|------|-------|------|
| 1.1 Tech Stack | package.json, pyproject.toml, Cargo.toml, go.mod | Non-obvious choices that would surprise a new dev |
| 1.2 Commands | scripts, Makefile, CI configs | Exact commands with FULL FLAGS |
| 1.3 Architecture | Imports, custom abstractions, middleware | Counterintuitive patterns differing from defaults |
| 1.4 Existing Configs | CLAUDE.md, AGENTS.md, .cursorrules, etc. | What exists, what's stale |
| 1.5 Landmines | Deprecated paths, fragile tests, env gotchas | Combine with engineer's Phase 0 answers |
| 1.6 Testing | Test files, config, CI commands, async patterns | Exact test commands, philosophy |
| 1.7 Style Tools | .eslintrc, biome.json, ruff.toml, pre-commit | What's deterministic → becomes hooks, NOT config lines |
| 1.8 Token Budget | Existing configs, skill descriptions, MCP tools | Estimate baseline token cost before conversation starts |
| 1.9 Negative Scan | All config files | Find "don't/avoid/do not" → rewrite as "MUST Y" (keep NEVER as-is) |

---

## Phase 2: Maturity & Leverage Scoring

### L0-L6 Maturity Score

| Level | Name | Criteria |
|-------|------|----------|
| L0 | Absent | No config file |
| L1 | Basic | File exists, may be /init boilerplate |
| L2 | Scoped | MUST/MUST NOT with RFC 2119 language |
| L3 | Structured | Multiple files organized by concern |
| L4 | Abstracted | Path-scoped rules per directory |
| L5 | Maintained | L4 + active upkeep, pruned regularly |
| L6 | Adaptive | Skills, MCP, hooks, dynamic loading, session management |

### Hierarchy of Leverage Score (NEW)

Score EACH layer independently (0-10):

```
Layer                          Score  Notes
─────────────────────────────────────────────
Verification (tests/linters)   ?/10   CI, pre-commit, coverage
CLAUDE.md / AGENTS.md quality  ?/10   Concise, landmines, commands
Hooks                          ?/10   Auto-format, branch protection, PostCompact
Skills                         ?/10   On-demand workflows, descriptions quality
Subagent patterns              ?/10   Isolation, worktrees, research delegation
Session management             ?/10   HANDOFF.md, compaction strategy, .claudeignore
─────────────────────────────────────────────
OVERALL LEVERAGE               ?/60
```

**Scoring criteria per layer:**
- 0-2: Absent or broken
- 3-4: Exists but generic/boilerplate
- 5-6: Functional, some gaps
- 7-8: Strong, follows best practices
- 9-10: Elite, production-hardened

Report both scores. Show exactly where effort yields the biggest return.

---

## Phase 3: Generate Config Files

Generate ONLY for tools the engineer uses (Phase 0 answers).

### Tool Selection Matrix

| Engineer Uses | Generate |
|---------------|----------|
| Any tool | AGENTS.md (always — universal baseline) |
| Claude Code | CLAUDE.md + subdirectory CLAUDE.md files + hooks + skills |
| Cursor | .cursor/rules/*.mdc with glob scoping |
| GitHub Copilot | .github/copilot-instructions.md + scoped instructions |
| Windsurf | .windsurf/rules/*.md |
| Gemini CLI | GEMINI.md |
| Aider | CONVENTIONS.md |

### Pain Point → Content Priority

| Pain Point | Emphasize |
|------------|-----------|
| Wrong commands | Commands section FIRST, full flags |
| Breaks architecture | Landmines section, counterintuitive patterns |
| Wrong style | Hook recommendations (NOT prose rules) |
| Touches forbidden files | Never boundaries |
| Commits without asking | Ask First boundaries |
| Doesn't understand domain | Skills for domain knowledge |
| Wastes time exploring | .claudeignore + scoped rules |
| Forgets context | PostCompact hook + HANDOFF.md |

### 3.1 — AGENTS.md (Universal Standard)

ALWAYS generate. 25+ tools read it. Use `AGENTS.md.template` as the base structure. Sections in order: Commands, Stack, Boundaries (Always/Ask First/Never), Landmines, Patterns.

**Rules:**
- MUST be under 200 lines (under 100 is better)
- MUST lead with executable commands (full flags)
- MUST use RFC 2119 language (MUST, SHOULD, NEVER)
- MUST NOT include directory trees, standard patterns, or README content
- MUST include three-tier boundaries (Always / Ask First / Never)
- Each line MUST pass: "Would removing this cause a mistake?"

### 3.2 — CLAUDE.md (Claude-Specific)

Only if engineer uses Claude Code. Use `CLAUDE.md.template` as base. MUST be under 50 lines. Use @imports to reference AGENTS.md and docs — don't duplicate content.

### 3.3 — Multi-Level Hierarchy (NEW)

Generate subdirectory config files. Agents only load these when working in that directory:

```
CLAUDE.md                  → orientation (50-100 lines)
tests/CLAUDE.md            → test commands, fixtures, async patterns, mock rules
src/CLAUDE.md              → import conventions, code patterns
src/api/CLAUDE.md          → API patterns, endpoint conventions
docs/CLAUDE.md             → doc conventions, link rules
```

Each subdirectory file: 20-50 lines MAX. Only what's relevant to that directory.

### 3.4 — Tool-Specific Configs

**Cursor** (.cursor/rules/*.mdc):
```yaml
---
description: [When this applies]
globs: "[file pattern]"
alwaysApply: false
---
[Focused instructions, <80 lines, one concept per rule]
```

**Copilot** (.github/copilot-instructions.md + .github/instructions/*.instructions.md):
- Main file references AGENTS.md content
- Scoped files with `applyTo:` glob frontmatter

**Others**: Generate appropriate format per tool.

---

## Phase 4: Set Up Progressive Disclosure

Create the full disclosure tree:

```
repo/
  AGENTS.md                           # Universal (<200 lines)
  CLAUDE.md                           # Claude-specific (<50 lines, @imports)
  tests/CLAUDE.md                     # Testing scope
  src/CLAUDE.md                       # Source scope
  docs/agent-context/                 # Detailed docs (read on-demand)
    architecture.md
    testing-guide.md
    api-conventions.md
  .claude/
    skills/                           # On-demand skills
    settings.local.json               # Hooks
  .cursor/rules/                      # Cursor scoped rules
  .github/copilot-instructions.md     # Copilot
  .claudeignore                       # Exclude irrelevant files
  HANDOFF.md                          # Session handoff template
```

---

## Phase 5: Set Up Hooks

Only if engineer opted in during Phase 0. Read `hooks/settings.json.template` for the pre-built hook library.

Set up these hooks adapted to the project's actual commands from Phase 1:
- **PostToolUse (Write|Edit)** — auto-format with project's formatter
- **PreToolUse (git push main)** — block direct pushes to main/master
- **PostCompact** — re-inject top 30 lines of CLAUDE.md + landmines after compaction (CRITICAL — solves "agent forgets rules")
- **PreToolUse (git commit)** — run lint + test before committing

---

## Phase 6: Set Up Session Management

Three deliverables:

1. **HANDOFF.md** — copy from `HANDOFF.md` template to project root. Engineers fill this before ending sessions; next session reads it to resume.

2. **.claudeignore** — generate from `claudeignore.template`, customized for the project. Analyze .gitignore and repo structure to add project-specific exclusions (build artifacts, binaries, lock files, vendor dirs).

3. **Document-and-Clear workflow** — add to CLAUDE.md:
   - "When context gets heavy (~40 messages): update HANDOFF.md, `/clear`, start fresh reading HANDOFF.md"
   - This outperforms auto-compaction (research-backed)

---

## Phase 7: Set Up Compounding Engineering

Two deliverables:

1. **GitHub Action** — copy `hooks/learn-from-reviews.yml` to `.github/workflows/`. When a reviewer tags `@claude-learn [rule]`, it auto-creates a PR adding that rule to AGENTS.md. The codebase learns from every review.

2. **Living document reminder** — add to CLAUDE.md: "When you make a mistake a rule could have prevented: fix it, then add one line to AGENTS.md that prevents it."

---

## Phase 8: MCP + Skills Recommendations

### MCP Recommendations (with token budget awareness)

| Project Has... | Recommend | Token Cost |
|---------------|-----------|------------|
| Large codebase (>1000 files) | codebase-memory-mcp | ~2K tokens |
| External library deps | context7 | ~1K tokens |
| GitHub-hosted | github-mcp-server | ~3K tokens |
| Database | DB-specific MCP | ~2K tokens |
| Team conventions | codebase-context (PatrickSys) | ~2K tokens |

**WARN if total MCP token cost exceeds 15K** — that's eating into the task budget.

### Skill Recommendations

Based on engineer's recurring workflows (Phase 0), recommend skills:
- Feature development workflow
- Bug fix workflow
- Database migration workflow
- Deployment workflow
- Code review checklist
- Testing workflow

Each skill: under 150 lines, one clear purpose, exact commands.

---

## Phase 9: Negative Instruction Rewrite (NEW)

Scan ALL generated and existing config files. Fix:

| Found | Rewrite To |
|-------|-----------|
| "don't use moment.js" | "MUST use date-fns for date operations" |
| "avoid raw SQL" | "MUST use the ORM query builder" |
| "do not import from index" | "MUST import from specific module files" |
| "don't mock the database" | "MUST use real database for integration tests" |

**Keep as-is:**
- "NEVER commit secrets" (absolute prohibition — fine)
- "NEVER push to main" (absolute prohibition — fine)
- "NEVER modify migration files" (absolute prohibition — fine)

The rule: soft negatives ("don't", "avoid", "do not") → positive MUST statements. Hard negatives ("NEVER") stay.

---

## Phase 10: Quality Audit & Report

Run these checks on all generated files:

**Content:** Every line passes "would removing this cause a mistake?" | No directory trees | No README duplication | Commands have full flags | Three-tier boundaries present | RFC 2119 language | No soft negatives remain

**Length:** AGENTS.md <200 lines | CLAUDE.md <50 lines | Subdirectory files <50 lines | .mdc rules <80 lines | Skills <150 lines

**Token Budget Report:** Estimate tokens for system prompt (~2,500) + CLAUDE.md + AGENTS.md + skill descriptions + MCP tools. Report total baseline cost vs 128K window. HEALTHY = <40% used, WARNING = 40-60%, CRITICAL = >60%.

**Hierarchy of Leverage Report:** Score each layer 0-10 (verification, CLAUDE.md, hooks, skills, subagents, session management). Show total out of 60. Recommend highest-impact improvement.

---

## Phase 11: Continuous Sync

If engineer opted in during Phase 0, install `hooks/ultracontext-sync.sh` as a pre-commit hook. It warns (non-blocking) when package files, CI configs, or lint configs change that may make agent configs stale. Also flags configs older than 14 days and detects soft negative instructions.

Tell the engineer: "Run `/ultracontext` anytime to re-analyze and refresh. The interview is skipped on re-runs."

---

## Output Format

Present results in this order:

1. **Your Setup Summary** — tool choices, pain points, preferences
2. **Maturity Score** — L-level before and after
3. **Hierarchy of Leverage Score** — per-layer scoring with gaps
4. **Token Budget Report** — how much context budget remains
5. **Generated Files** — each file with WHY specific content was included (tied to pain points)
6. **Hooks Installed** — what each prevents
7. **Session Management** — HANDOFF.md, .claudeignore, Document-and-Clear workflow
8. **Compounding Engineering** — GitHub Action or manual process
9. **MCP Recommendations** — with token costs
10. **Negative Instructions Fixed** — before/after rewrites
11. **What You Should Hand-Refine** — where domain knowledge is needed

For each file, connect to interview answers:
> "Included exact `pytest -x -q` command because you said agents run wrong test commands."
> "The 'Never' boundary includes `migrations/` because you flagged it as a landmine."

ALWAYS end with:

> "These files are a STARTING POINT. The most effective configs are refined over time. When an agent makes a mistake, add one line that prevents it. When a line stops being useful, delete it. Review every few weeks. Your codebase gets smarter with every iteration."

---

## Research Basis

Built on 200+ sources: Anthropic, ETH Zurich, Google DeepMind, Manus, GitHub (2,500-repo analysis), LangChain, JetBrains (NeurIPS 2025), METR, Boris Cherny, Dex Horthy, 40+ production CLAUDE.md files, Reddit/HN/GitHub Discussions. Full research: github.com/johnnichev/nv-skills/research/logs/
