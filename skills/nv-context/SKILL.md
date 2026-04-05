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

## Phase 0: Engineer Interview

MANDATORY. Before touching ANY code, have a diagnostic conversation. Ask ONE GROUP AT A TIME. This is UltraContext's key differentiator — no other tool interviews the human.

**Tone:** Like a senior engineer onboarding onto the team. Warm, curious, efficient. Not a form — a conversation.

### Group 1: Your Tools & Environment

> **Which AI coding tools do you use?** (select all that apply)
> Claude Code / Cursor / GitHub Copilot / Windsurf / Aider / Gemini CLI / Other
>
> **Which is your PRIMARY tool?** (this gets the deepest configuration)
>
> **What model do you typically use?** (Opus, Sonnet, GPT-4, etc.)

Only generate configs for tools they use. Primary tool gets the richest config; others get the AGENTS.md baseline. Model choice affects how aggressive we can be with instruction density.

### Group 2: Your Team & Collaboration

> **How many people work on this codebase?** Just me / 2-5 / 6-20 / 20+
>
> **Do others use AI agents?** Same tools / Mixed tools / Just me / Not sure
>
> **How do you handle code review?** PRs with human review / PRs with AI review / Direct to main / Mix

Solo → CLAUDE.local.md freedom. Team → AGENTS.md in git. Mixed tools → universal standard. PR-heavy teams → compounding engineering setup.

### Group 3: Your Pain Points (Diagnostic)

> **What frustrates you most with AI agents on your code?** (pick your top 2-3)
> - Doesn't follow our coding patterns/conventions
> - Breaks things because it doesn't understand architecture
> - Runs wrong commands (build, test, lint)
> - Modifies files it shouldn't touch
> - Commits or pushes without being asked
> - Writes code that doesn't match our style
> - Doesn't understand our domain/business logic
> - Wastes time exploring irrelevant files
> - Forgets my rules mid-session (after compaction)
> - Takes too long on simple tasks (over-exploring)
> - Something else: ___

**FOLLOW UP on each selection.** Don't just record — diagnose:
- "You said it runs wrong commands — what command does it run, and what should it run instead?"
- "You said it breaks architecture — can you give me a specific example of what it broke?"
- "You said it forgets rules — at what point in the session does it start forgetting?"

Each follow-up answer becomes a specific line in the config. Vague pain points produce vague configs.

### Group 4: Your Landmines (The Highest-Value Question)

> **What are the top 3-5 things that would waste hours if an AI agent hit them unaware?**
>
> Think about:
> - Non-obvious build requirements or environment setup
> - Deprecated code paths that look active
> - Fragile tests or flaky CI
> - Files that look simple but are deceptively complex
> - Things that break in non-obvious ways
> - Areas where "the obvious fix" is actually wrong

**DIG DEEPER on each landmine.** For each one ask:
- "What happens when someone hits this? What does the failure look like?"
- "Is there a specific file path or directory?"
- "What's the correct way to handle this area?"

Landmines are the SINGLE MOST VALUABLE content in any config file. Spend time here. The more specific, the better.

### Group 5: Your Workflow & Autonomy

> **Agent autonomy level?**
> - High: run tests, commit, push, create PRs — tell me when done
> - Medium: run tests/lint freely, but ask before committing or pushing
> - Low: ask before running any command that modifies state
>
> **Want deterministic hooks?** (auto-lint, auto-format on file changes)
> - Yes, auto-fix everything (format + lint on save)
> - Yes, but only check — don't auto-fix
> - No, I prefer to control when formatting runs
>
> **Do you want continuous sync?** (warns when configs may be stale on every commit)
> - Yes (recommended)
> - No
>
> **Recurring workflows you do often?**
> Examples: "fix issue from Linear/Jira", "add new API endpoint", "database migration", "deploy to staging", "write tests for existing code"

Autonomy → boundaries. Workflows → skills. Hook pref → enforcement. Sync → pre-commit hook.

### Group 6: Your Current Setup

> **Do you already have any of these?** CLAUDE.md / AGENTS.md / .cursorrules / copilot-instructions.md
>
> **If yes — what's working well about them?** (we keep what works)
>
> **What's NOT working?** (we fix what's broken)
>
> **Any MCP servers currently configured?**
>
> **Any pre-commit hooks or CI quality gates already running?**

Improve what exists. Don't replace wholesale. If something works, preserve it.

### Group 7: Your Aspirations (Quick)

> **On a scale of 1-5, how important is each to you?**
> - Agent follows conventions perfectly: ___
> - Agent works autonomously with minimal babysitting: ___
> - Agent maintains quality across long sessions: ___
> - Configs stay fresh as code evolves: ___
> - New team members (human or AI) can onboard fast: ___

This prioritizes which features we invest the most setup effort in.

### Confirm Before Proceeding

Summarize the FULL diagnostic back:

> "Here's what I learned and what I'll build:
>
> **Tools:** [primary] as main, [others] get AGENTS.md baseline
> **Team:** [size], [collaboration model], [review process]
> **Top pain points:**
> 1. [Specific pain point with specific example they gave]
> 2. [Specific pain point with specific example they gave]
> **Landmines:**
> 1. [Specific landmine with file path and failure mode]
> 2. [Specific landmine with file path and failure mode]
> 3. [Specific landmine with file path and failure mode]
> **Autonomy:** [level] — [specific boundaries]
> **Hooks:** [yes/no] — [what gets enforced]
> **Continuous sync:** [yes/no]
> **Skills to create:** [based on their workflows]
> **Priorities:** [ordered by their aspiration scores]
>
> Does this capture everything? Anything to add or change?"

**WAIT for confirmation before proceeding to Phase 1.**

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
