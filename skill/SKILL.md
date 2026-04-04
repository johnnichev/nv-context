---
name: ultracontext
description: Set up state-of-the-art context engineering for any repository. Analyzes codebase, generates multi-level CLAUDE.md/AGENTS.md hierarchy, hooks, session management, and token budgets. Based on 200+ sources including ETH Zurich, Anthropic, Google DeepMind, and Manus production data. For engineers who ship with AI agents.
argument-hint: [path-to-repo]
user-invocable: true
---

# UltraContext v2: Context Engineering for Engineers Who Ship

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

MANDATORY. Before touching ANY code, have a conversation. Ask ONE GROUP AT A TIME.

### Group 1: Your Tools

> **Which AI coding tools do you use?** (select all that apply)
> Claude Code / Cursor / GitHub Copilot / Windsurf / Aider / Gemini CLI / Other
>
> **Which is your PRIMARY tool?**

Only generate configs for tools they use. Primary tool gets the deepest configuration.

### Group 2: Your Team

> **How many people work on this codebase?** Just me / 2-5 / 6-20 / 20+
>
> **Do others use AI agents?** Same tools / Mixed tools / Just me

Solo devs get CLAUDE.local.md freedom. Teams need AGENTS.md in git. Mixed tools need the universal standard.

### Group 3: Your Pain Points

> **What frustrates you most with AI agents on your code?** (top 2-3)
> - Doesn't follow coding patterns
> - Breaks things (doesn't understand architecture)
> - Runs wrong commands
> - Modifies files it shouldn't
> - Commits/pushes without asking
> - Doesn't match our style
> - Doesn't understand domain logic
> - Wastes time exploring irrelevant files
> - Forgets context mid-session
> - Something else: ___

This directly determines config content priority.

### Group 4: Your Landmines

> **Top 3-5 things that would waste hours if an AI agent hit them unaware?**
>
> Think: non-obvious build requirements, deprecated paths that look active, fragile tests, environment gotchas, deceptively complex areas.

HIGHEST VALUE content. Only humans know these.

### Group 5: Your Workflow

> **Agent autonomy level?**
> - High: run tests, commit, push, create PRs
> - Medium: run tests/lint freely, ask before committing
> - Low: ask before any state-changing command
>
> **Want deterministic hooks?** (auto-lint, auto-format on file changes)
> Yes auto-fix / Yes check-only / No
>
> **Recurring workflows?** (e.g., "fix issue from ticket", "add API endpoint", "database migration")

Autonomy → boundaries. Workflows → skills. Hook preference → enforcement strategy.

### Group 6: Existing Setup

> **Do you have CLAUDE.md / AGENTS.md / .cursorrules already?**
> **What's working? What's not?**
> **Any MCP servers currently?**

Improve what exists. Don't replace wholesale.

### Confirm Before Proceeding

Summarize back:
> "Based on your answers, here's what I'll set up: [tool configs], [pain point priorities], [landmines to document], [autonomy level], [hooks], [skills]. Sound right?"

WAIT for confirmation.

---

## Phase 1: Deep Codebase Analysis

With preferences in hand, analyze the repository:

**1.1 — Tech Stack** (DO NOT just repeat package.json)
```
Check: package.json, Cargo.toml, pyproject.toml, go.mod, Gemfile, pom.xml
Goal: NON-OBVIOUS choices — what would surprise a new developer?
```

**1.2 — Exact Commands**
```
Check: package.json scripts, Makefile, justfile, CI configs (.github/workflows/*)
Goal: ACTUAL commands with FULL FLAGS — not "npm test" but the exact invocation
```

**1.3 — Architectural Landmines**
```
Check: Directory structure, import patterns, custom abstractions, middleware
Goal: COUNTERINTUITIVE patterns — what differs from framework defaults?
```

**1.4 — Existing Configs**
```
Check: CLAUDE.md, AGENTS.md, .cursorrules, .cursor/rules/, copilot-instructions.md, GEMINI.md
Goal: What exists, what's stale, what's working
```

**1.5 — Code Landmines** (combine with engineer's answers from Phase 0)
```
Check: Deprecated paths, legacy code, fragile tests, env requirements
Goal: What wastes HOURS if hit unaware
```

**1.6 — Testing Patterns**
```
Check: Test files, config, CI commands, fixtures, mocks, async patterns
Goal: Testing philosophy, exact commands, what MUST be followed
```

**1.7 — Style Enforcement (for hooks, NOT config)**
```
Check: .eslintrc, biome.json, .prettierrc, ruff.toml, pre-commit hooks
Goal: What DETERMINISTIC TOOLS handle — these become hooks, not CLAUDE.md lines
```

**1.8 — Token Budget Estimation**
```
Estimate tokens consumed by:
- Existing CLAUDE.md / AGENTS.md
- Skill descriptions (always loaded)
- Tool definitions (MCP servers)
- System prompt overhead (~2,500 tokens for Claude Code)
Report: "X tokens used before conversation starts. Y available for actual work."
```

**1.9 — Negative Instruction Scan**
```
Scan ALL existing config files for:
- "don't use X" → rewrite as "MUST use Y instead"
- "avoid X" → rewrite as "MUST use Y"  
- "do not X" → rewrite as "MUST Y instead"
- Keep "NEVER X" as-is (absolute prohibitions are fine)
Flag and fix every soft negative found.
```

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

ALWAYS generate. 25+ tools read it. Structure:

```markdown
# [Project Name]

[ONE sentence: what this is]

## Commands

```bash
# Dev
[exact command]

# Test (single)
[exact command with flags]

# Test (suite)
[exact command with flags]

# Lint
[exact command]

# Type check
[exact command]

# Build
[exact command]
```

## Stack

[ONLY non-obvious choices with WHY]

## Boundaries

### Always
- [Required actions]

### Ask First
- [Actions needing approval]

### Never
- NEVER commit secrets or .env files
- [Project-specific prohibitions]

## Landmines

- `path/to/file`: [What's dangerous and WHY]

## Patterns

```[lang]
// CORRECT: [pattern name]
[actual code]

// WRONG: [anti-pattern]
[what not to do]
```
```

**Rules:**
- MUST be under 200 lines (under 100 is better)
- MUST lead with commands
- MUST use RFC 2119 (MUST, SHOULD, NEVER)
- MUST NOT include directory trees, standard patterns, or README content
- MUST include three-tier boundaries
- Each line MUST pass: "Would removing this cause a mistake?"

### 3.2 — CLAUDE.md (Claude-Specific)

Only if engineer uses Claude Code. SHORT — under 50 lines. Use @imports.

```markdown
See @AGENTS.md for project conventions.

@docs/architecture.md
@docs/testing-guide.md

## Claude-Specific

### Before committing
MUST run `[exact lint]` and `[exact test]`

### When modifying [area]
Read @[specific doc] first
```

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

For the engineer's tools. Only if they opted in during Phase 0.

### Pre-Built Hook Library

**PostToolUse — Auto-format on file changes:**
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "[project-specific format command] $FILE_PATH",
        "description": "Auto-format after file changes"
      }
    ]
  }
}
```

**PreToolUse — Branch protection:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash(git push.*main|git push.*master)",
        "command": "echo 'BLOCKED: Never push directly to main. Create a PR instead.' && exit 1",
        "description": "Block direct pushes to main/master"
      }
    ]
  }
}
```

**PostCompact — Context re-injection (CRITICAL):**
```json
{
  "hooks": {
    "PostCompact": [
      {
        "command": "cat <<'REINJECT'\n## Critical Context (re-injected after compaction)\n\n$(head -30 CLAUDE.md)\n\n## Active Landmines\n$(grep -A1 '##.*Landmine' AGENTS.md)\nREINJECT",
        "description": "Re-inject critical context after compaction"
      }
    ]
  }
}
```

**PreCommit — Quality gate:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash(git commit)",
        "command": "[project-specific lint command] && [project-specific test command]",
        "description": "Lint and test before committing"
      }
    ]
  }
}
```

Adapt all hooks to the project's actual commands discovered in Phase 1.

---

## Phase 6: Set Up Session Management (NEW)

### HANDOFF.md Template

Generate at project root:

```markdown
# Session Handoff

> Update this before ending a long session. Next session starts by reading this file.

## Last Updated
[date]

## What I Was Working On
[Current task/feature]

## What's Done
- [Completed items]

## What's Left
- [Remaining items]

## Key Decisions Made
- [Architectural or design decisions with WHY]

## Landmines Discovered
- [New gotchas found during this session — consider adding to AGENTS.md]

## Files Modified
- [List of changed files for quick orientation]

## How to Continue
[Exact next steps — what command to run, what file to open]
```

### .claudeignore Generation

Analyze the repo and generate `.claudeignore` excluding:
```
# Build artifacts
node_modules/
dist/
build/
.next/
__pycache__/
*.pyc

# Dependencies
vendor/
.venv/

# Large generated files
*.lock
coverage/
.nyc_output/

# Binary/media
*.png
*.jpg
*.gif
*.ico
*.woff
*.woff2
*.ttf

# IDE
.idea/
.vscode/settings.json

# Project-specific
[detected from .gitignore and repo analysis]
```

### Document-and-Clear Workflow Guide

Add to CLAUDE.md:

```markdown
## Session Management

When context gets heavy (after ~40 messages or complex exploration):
1. Update HANDOFF.md with current progress
2. `/clear`
3. Start fresh: "Read HANDOFF.md and continue where I left off"

This outperforms auto-compaction. Use it.
```

---

## Phase 7: Set Up Compounding Engineering (NEW)

### Auto-Learning from PR Reviews

Generate a GitHub Action (`.github/workflows/learn-from-reviews.yml`):

```yaml
name: Learn from PR Reviews
on:
  pull_request_review:
    types: [submitted]

jobs:
  update-context:
    if: contains(github.event.review.body, '@claude-learn')
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Extract learning
        run: |
          LEARNING="${{ github.event.review.body }}"
          LEARNING=$(echo "$LEARNING" | sed 's/@claude-learn//')
          echo "" >> AGENTS.md
          echo "- $LEARNING" >> AGENTS.md
      - name: Create PR with learning
        uses: peter-evans/create-pull-request@v6
        with:
          commit-message: "context: add learning from PR review"
          title: "Context: Add learning from PR #${{ github.event.pull_request.number }}"
          branch: context-update-${{ github.event.pull_request.number }}
```

When a reviewer writes `@claude-learn agents MUST validate input before database writes`, it auto-creates a PR adding that rule to AGENTS.md.

### Living Document Reminder

Add to CLAUDE.md:

```markdown
## Compounding Engineering

When you make a mistake that a rule could have prevented:
1. Fix the mistake
2. Add a one-line rule to AGENTS.md that prevents it
3. The codebase gets smarter over time
```

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

### Content Checklist

- [ ] Every line passes: "Would removing this cause an agent mistake?"
- [ ] No directory trees (agents can `ls`)
- [ ] No standard patterns agents know
- [ ] No README duplication
- [ ] Commands include full flags
- [ ] Code examples show correct AND incorrect
- [ ] Three-tier boundaries present
- [ ] RFC 2119 language used
- [ ] No soft negative instructions remain

### Length Limits

- [ ] AGENTS.md: under 200 lines (under 100 ideal)
- [ ] CLAUDE.md: under 50 lines (uses @imports)
- [ ] Subdirectory files: under 50 lines each
- [ ] Each .mdc rule: under 80 lines
- [ ] Each skill: under 150 lines

### Token Budget Report (NEW)

```
Context Budget Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
System prompt (Claude Code)    ~2,500 tokens
CLAUDE.md                      ~[X] tokens
AGENTS.md                      ~[X] tokens  
Skill descriptions             ~[X] tokens
MCP tool definitions           ~[X] tokens
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total baseline cost            ~[X] tokens
Context window                 128,000 tokens
Available for work             ~[X] tokens ([X]%)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Status: [HEALTHY / WARNING / CRITICAL]

HEALTHY = <40% used by context
WARNING = 40-60% used by context  
CRITICAL = >60% used by context (reduce configs!)
```

### Hierarchy of Leverage Report (NEW)

```
Hierarchy of Leverage Score
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Verification        [██████████] 10/10
CLAUDE.md quality   [████████░░]  8/10
Hooks               [██████░░░░]  6/10
Skills              [████░░░░░░]  4/10
Subagent patterns   [██░░░░░░░░]  2/10
Session management  [████████░░]  8/10
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Overall             38/60

Top recommendation: Set up hooks for auto-format 
and PostCompact re-injection to reach 48/60.
```

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

Built on 200+ sources including:
- **Anthropic** — Effective Context Engineering (engineering blog)
- **ETH Zurich** — 2 studies on AGENTS.md impact
- **Google DeepMind** — Sessions & Memory (70-page whitepaper)
- **Manus** — Production lessons (50+ tool-calls/task, 4 framework rebuilds)
- **GitHub** — 2,500 repository AGENTS.md analysis
- **LangChain** — Write/Select/Compress/Isolate framework
- **JetBrains** — NeurIPS 2025: observation masking
- **METR** — Controlled study on AI developer productivity
- **Boris Cherny** — Claude Code creator's workflow (259 PRs/30 days)
- **Dex Horthy** — 12-Factor Agents, harness engineering
- **40+ production CLAUDE.md files** from open source projects
- **Community** — Reddit, HackerNews, GitHub Discussions practitioner wisdom

Full research: github.com/[repo]/research/logs/ (12 documents, 471KB)
