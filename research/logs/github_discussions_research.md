# GitHub Discussions & Community Research: Agentic Coding & Context Engineering

**Research Date:** 2026-04-04
**Scope:** GitHub Discussions, Issues, community repos, awesome-lists, blog posts, gists
**Focus:** Implementation details practitioners actually share

---

## Table of Contents

1. [Real CLAUDE.md Files from Production Repos](#1-real-claudemd-files-from-production-repos)
2. [Skills People Have Built and Shared](#2-skills-people-have-built-and-shared)
3. [Hooks Configurations That Work Well](#3-hooks-configurations-that-work-well)
4. [Common Patterns in GitHub Discussions](#4-common-patterns-in-github-discussions)
5. [Context Management Problems (Issues)](#5-context-management-problems-issues)
6. [Subagent Patterns and Multi-Agent Workflows](#6-subagent-patterns-and-multi-agent-workflows)
7. [CLAUDE.md Structure Best Practices](#7-claudemd-structure-best-practices)
8. [AGENTS.md Patterns (Cross-Tool Insights)](#8-agentsmd-patterns-cross-tool-insights)
9. [.cursorrules / Aider Conventions (Parallel Ecosystem)](#9-cursorrules--aider-conventions-parallel-ecosystem)
10. [Advanced Context Engineering Techniques](#10-advanced-context-engineering-techniques)
11. [The Ralph Wiggum Autonomous Loop Pattern](#11-the-ralph-wiggum-autonomous-loop-pattern)
12. [Git Worktree Parallel Agent Patterns](#12-git-worktree-parallel-agent-patterns)
13. [Token Optimization Strategies](#13-token-optimization-strategies)
14. [Key Repositories Index](#14-key-repositories-index)

---

## 1. Real CLAUDE.md Files from Production Repos

### Source: josix/awesome-claude-md
**URL:** https://github.com/josix/awesome-claude-md

Curated collection of exemplary CLAUDE.md files from public GitHub projects. Filterable by technology and purpose.

#### Essential Examples (Top Picks)

| Repo | Stack | Notable Pattern |
|------|-------|----------------|
| OpenAI Agents Python | Python, Multi-Agent | Official agent framework with orchestration patterns |
| Basic Memory | Python, FastAPI, SQLAlchemy | MCP integration & AI collaboration patterns |
| Overreacted.io | Next.js, React, MDX | Technical depth with personality; blog architecture docs |
| Pydantic GenAI Prices | Python, Pydantic, YAML | Expert data processing pipeline patterns |

#### TypeScript/JavaScript Examples (38 total)

| Repo | Notable Pattern |
|------|----------------|
| Callstack React Native Testing Library | Testing gold standards |
| Citadel Protocol Contracts | Security-first DeFi protocol |
| Cloudflare Workers SDK | Monorepo patterns and tooling excellence |
| Claude Crew | Strict TypeScript standards enforcement |
| Web Builder | B2B2B SaaS platform (Next.js 14) |
| GalaChain SDK | Blockchain SDK patterns |
| Foam | Knowledge management tooling |
| MCP WordPress | MCP server implementation patterns |

#### Common Sections Found in Production CLAUDE.md Files

1. **Architecture overview** - High-level system description
2. **Setup instructions** - Build commands, environment setup
3. **Development guidelines** - Coding standards, conventions
4. **Technology stack** - Specific versions, key dependencies
5. **Integration patterns** - APIs, services, MCP connections
6. **Security considerations** - Auth patterns, access control
7. **Testing methodology** - Framework, patterns, coverage requirements

#### Key Insight
The best CLAUDE.md files are **under 200 lines** (~5k tokens). They act like an onboarding doc for a new senior developer -- not a comprehensive wiki, but a targeted orientation.

---

## 2. Skills People Have Built and Shared

### Source: hesreallyhim/awesome-claude-code (28k+ stars)
**URL:** https://github.com/hesreallyhim/awesome-claude-code

### Source: anthropics/skills (Official, 110k stars)
**URL:** https://github.com/anthropics/skills

### SKILL.md Format (Official Standard)

```markdown
---
name: my-skill-name          # kebab-case, 1-64 chars, becomes /slash-command
description: >
  Clear description of what this skill does AND when to use it.
  Make descriptions slightly "pushy" -- Claude tends to undertrigger skills.
---

# Skill Instructions

[Markdown content Claude follows when skill is active]

## Examples
- Example usage patterns

## Guidelines
- Specific rules to follow
```

**Key insight from Anthropic:** "Claude has a tendency to undertrigger skills -- to not use them when they'd be useful. Make the skill descriptions a little bit pushy."

### Official Anthropic Skills (anthropics/skills repo)

| Category | Skills |
|----------|--------|
| Creative & Design | Art, music, design applications |
| Development & Technical | Testing web apps, MCP server generation |
| Enterprise & Communication | Branding, communications workflows |
| Document Skills | docx, pdf, pptx, xlsx creation/editing |

**Installation:**
```bash
/plugin marketplace add anthropics/skills
/plugin install document-skills@anthropic-agent-skills
```

### Top Community Skills

#### Agent Skill Frameworks

| Name | Author | Description |
|------|--------|-------------|
| **Superpowers** | Jesse Vincent (obra) | Core SDLC competencies: TDD, brainstorming, planning, executing, code review, debugging, worktrees. 135k stars. |
| **Everything Claude Code** | Affaan Mustafa | 38 agents, 156 skills, 72 commands. 10+ months production use. Full harness optimization. |
| **Context Engineering Kit** | NeoLabHQ (Vlad Goncharov) | Advanced context techniques with minimal token footprint. Spec-driven development, reflexion, quality gates. |
| **Compound Engineering Plugin** | EveryInc | Pragmatic agents centered on learning from mistakes |
| **Trail of Bits Security Skills** | Trail of Bits | 12+ security-focused auditing and vulnerability detection |

#### Specialized Skills

| Name | Description |
|------|-------------|
| Codebase to Course (Zara Zhang) | Transforms any codebase into interactive single-page HTML course |
| Book Factory (Robert Guss) | Publishing pipeline replicating nonfiction book creation |
| cc-devops-skills (akin-ozer) | DevOps validations, generators, IaC code generation |
| Claude Scientific Skills (K-Dense) | Research, science, engineering, analysis, finance |
| Fullstack Dev Skills (jeffallan) | 65 specialized skills with Jira integration |
| read-only-postgres (jawwadfirdousi) | PostgreSQL query with SELECT/SHOW/EXPLAIN only |
| Claude Mountaineering Skills | Automates mountain route research from 10+ sources |

#### Workflow/Process Skills

| Name | Description |
|------|-------------|
| AB Method (Ayoub Bensalah) | Spec-driven workflow transforming problems into incremental missions |
| RIPER Workflow (Tony Narlock) | Research, Innovate, Plan, Execute, Review separation |
| Claude Code PM (Ran Aroussi) | Project management with specialized agents |
| Simone (Helmi) | Project management with integrated documents and guidelines |
| ContextKit (FlineDev) | Proactive development framework with 4-phase planning |
| Claude CodePro (Max Ritter) | Professional TDD and spec-driven workflows |

### Superpowers Framework Deep Dive (135k stars)

**URL:** https://github.com/obra/superpowers

**Philosophy:** Test-driven, systematic, complexity-reducing, evidence-over-claims.

**Skill taxonomy:**

| Skill | Purpose |
|-------|---------|
| test-driven-development | RED-GREEN-REFACTOR cycles with anti-patterns reference |
| systematic-debugging | Four-phase root cause analysis with tracing |
| verification-before-completion | Confirms actual resolution before declaring success |
| brainstorming | Socratic design refinement through iterative questioning |
| writing-plans | Breaks work into 2-5 minute tasks with exact specs |
| executing-plans | Batch execution with human checkpoints |
| dispatching-parallel-agents | Concurrent subagent workflows |
| requesting-code-review | Pre-review validation against specifications |
| receiving-code-review | Feedback integration processes |
| using-git-worktrees | Isolated parallel development |
| finishing-a-development-branch | Merge decision workflow |
| subagent-driven-development | Two-stage review: spec compliance then code quality |
| writing-skills | Meta-skill for creating new skills |

**Mandatory execution order:**
1. Design brainstorming with documented specifications
2. Git worktree initialization with setup verification
3. Detailed task planning with bite-sized decomposition
4. Subagent dispatch or batch execution with review gates
5. TDD implementation with red-green-refactor discipline
6. Code review against original plan
7. Branch completion with merge options

### Everything Claude Code Architecture (affaan-m)

**URL:** https://github.com/affaan-m/everything-claude-code

38 agents, 156 skills, 72 legacy command shims. Production-tested over 10+ months.

**Directory structure:**
```
.claude-plugin/
  plugin.json, marketplace.json
agents/           # 38 specialized subagents
  planner, architect, tdd-guide, code-reviewer
  security-reviewer, chief-of-staff, loop-operator
  cpp-reviewer, go-reviewer, python-reviewer, typescript-reviewer
  e2e-runner, refactor-cleaner, doc-updater, build-error-resolver
skills/           # 156 workflow definitions
  infrastructure/, development-practices/, business/
rules/            # Always-active guidelines by language
  common/ (coding-style, testing@80% coverage, security, patterns)
  typescript/, python/, golang/, swift/, php/
hooks/            # Trigger-based automations
  memory-persistence/, session hooks, compaction management
commands/         # 72 slash-entry shims
  /tdd, /plan, /code-review, /e2e, /refactor-clean
  /learn, /verify, /checkpoint
  /multi-plan, /multi-execute, /multi-backend
  /instinct-import, /instinct-export, /evolve, /prune
contexts/         # Dynamic system prompt injection
  dev.md, review.md, research.md
mcp-configs/      # GitHub, Supabase, Vercel, Railway
examples/         # SaaS, Go microservices, Django, Laravel, Rust
```

**Key patterns:**
- **Instinct system:** Automatically extracts patterns from sessions into reusable skills with confidence scoring. Clustered via `/evolve` command.
- **Hook profiles:** `ECC_HOOK_PROFILE=minimal|standard|strict` for tuning
- **Cross-platform:** All hooks/scripts rewritten in Node.js for Windows/macOS/Linux
- **Manifest-driven install:** Selective by profile (full, typescript, python, golang, etc.)

---

## 3. Hooks Configurations That Work Well

### Source: disler/claude-code-hooks-mastery
**URL:** https://github.com/disler/claude-code-hooks-mastery

### All 13 Hook Lifecycle Events

| Event | Can Block? | Purpose |
|-------|-----------|---------|
| **UserPromptSubmit** | YES (exit 2) | Validate/enhance prompts before Claude sees them |
| **PreToolUse** | YES (exit 2) | Block dangerous commands deterministically |
| **PostToolUse** | No | Automation after tool completion (formatting, tests) |
| **PostToolUseFailure** | No | Structured error logging |
| **Notification** | No | Async notification handling |
| **Stop** | YES (exit 2) | Force task continuation, prevent premature completion |
| **SubagentStart** | No | Log when Task tools spawn sub-agents |
| **SubagentStop** | YES (exit 2) | Control subagent completion |
| **PreCompact** | No | Backup transcripts, log summaries before compaction |
| **SessionStart** | No | Load persisted context, inject reminders |
| **SessionEnd** | No | Cleanup, state persistence |
| **PermissionRequest** | No | Audit permission dialogs |
| **Setup** | No | Repository initialization |

### Exit Code Semantics

| Code | Meaning |
|------|---------|
| 0 | Success (stdout shown in transcript mode) |
| 2 | Blocking error (stderr fed to Claude; prevents continuation) |
| Other | Non-blocking (stderr visible to user; execution continues) |

### Production Hook Examples

#### 1. Security: Block Dangerous Commands (PreToolUse)

```python
# .claude/hooks/pre_tool_use.py
if is_dangerous_rm_command(command):
    print("BLOCKED: Dangerous rm command detected", file=sys.stderr)
    sys.exit(2)  # Blocks tool call, shows error to Claude
```

**Key insight:** Deterministic security. Don't rely on LLM judgment for safety -- use code.

#### 2. Persistent Memory via Hooks (UserPromptSubmit + PostToolUse)

From Issue #34556 community solution (700+ hours of testing):

```bash
# ~/.claude/hooks/persistent-memory.sh
MEMORY_DIR="$HOME/.claude/persistent-memory"
mkdir -p "$MEMORY_DIR"
CONTEXT=""
if [ -f "$MEMORY_DIR/active-task.txt" ]; then
  TASK=$(cat "$MEMORY_DIR/active-task.txt")
  CONTEXT="Active task: $TASK"
fi
if [ -f "$MEMORY_DIR/decisions.txt" ]; then
  DECISIONS=$(tail -5 "$MEMORY_DIR/decisions.txt")
  CONTEXT="$CONTEXT\nRecent decisions: $DECISIONS"
fi
if [ -f "$MEMORY_DIR/project-state.txt" ]; then
  STATE=$(cat "$MEMORY_DIR/project-state.txt")
  CONTEXT="$CONTEXT\nProject state: $STATE"
fi
if [ -n "$CONTEXT" ]; then
  echo "{\"hookSpecificOutput\":{\"additionalContext\":\"PERSISTENT MEMORY (survives compaction):\n$CONTEXT\"}}"
fi
exit 0
```

**Config:**
```json
{
  "hooks": {
    "UserPromptSubmit": [{
      "hooks": [{"type": "command", "command": "bash ~/.claude/hooks/persistent-memory.sh"}]
    }],
    "PostToolUse": [{
      "hooks": [{"type": "command", "command": "bash ~/.claude/hooks/state-saver.sh"}]
    }]
  }
}
```

**Pattern:** Hooks read from filesystem on every prompt. Filesystem survives compactions. State saved to disk via PostToolUse, re-injected via UserPromptSubmit.

#### 3. Branch Protection (PreToolUse)

From ChrisWiles/claude-code-showcase:

```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Edit|Write",
      "hooks": [{
        "type": "command",
        "command": "bash -c 'BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); if [ \"$BRANCH\" = \"main\" ]; then echo \"{\\\"decision\\\": \\\"block\\\", \\\"reason\\\": \\\"Cannot edit files on main branch\\\"}\" >&2; exit 2; fi'"
      }]
    }]
  }
}
```

#### 4. Auto-Format on Edit (PostToolUse)

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Edit|Write",
      "hooks": [{
        "type": "command",
        "command": "bash -c 'npx prettier --write \"$CLAUDE_FILE_PATH\" 2>/dev/null'",
        "timeout": 30000
      }]
    }]
  }
}
```

#### 5. Auto-Run Tests on Test File Changes (PostToolUse)

```json
{
  "PostToolUse": [{
    "matcher": "Edit|Write",
    "hooks": [{
      "type": "command",
      "command": "bash -c 'if echo \"$CLAUDE_FILE_PATH\" | grep -q \"test\\|spec\"; then npm test -- --testPathPattern=\"$CLAUDE_FILE_PATH\" 2>&1 | head -50; fi'",
      "timeout": 90000
    }]
  }]
}
```

#### 6. Session Start Context Injection

```json
{
  "hooks": {
    "SessionStart": [{
      "matcher": "",
      "hooks": [{
        "type": "command",
        "command": "echo 'Reminder: use Bun, not npm. Run bun test before committing. Current sprint: auth refactor.'"
      }]
    }]
  }
}
```

#### 7. macOS Notification on Attention Needed

```json
{
  "hooks": {
    "Notification": [{
      "matcher": "",
      "hooks": [{
        "type": "command",
        "command": "osascript -e 'display notification \"Claude Code needs your attention\" with title \"Claude Code\"'"
      }]
    }]
  }
}
```

### Hook Directory Structure (Best Practice)

```
.claude/
  settings.json          # Hook configuration
  hooks/
    user_prompt_submit.py
    pre_tool_use.py
    post_tool_use.py
    validators/
      ruff_validator.py
      ty_validator.py
    utils/
      etts/etts_queue.py   # Text-to-speech integration
      llm/task_summarizer.py
  commands/               # Custom slash commands
  agents/                 # Sub-agent configurations
  output-styles/          # Response formatting
  status_lines/           # Custom status bar scripts
```

### Official Anthropic Settings Examples

**URL:** https://github.com/anthropics/claude-code/tree/main/examples/settings

Three profiles provided:

| Setting | Lax | Strict | Bash Sandbox |
|---------|-----|--------|--------------|
| Disable `--dangerously-skip-permissions` | Yes | Yes | No |
| Block plugin marketplaces | Yes | Yes | No |
| Block user/project permissions | No | Yes | Yes |
| Block user/project hooks | No | Yes | No |
| Deny web fetch/search | No | Yes | No |
| Bash requires approval | No | Yes | No |
| Bash must run sandboxed | No | No | Yes |

---

## 4. Common Patterns in GitHub Discussions

### Anthropic's Official Best Practices (from gist/documentation)

**URL:** https://gist.github.com/jussker/e825980ed46af2b99318e19ef01083be

#### Four Dominant Workflows

1. **Explore-Plan-Code-Commit**: Research files first, use "think" for extended reasoning, implement incrementally, commit results
2. **Test-Driven Development**: Write tests first, confirm failures, commit tests, iterate code until passing
3. **Visual Iteration**: Provide design mocks/screenshots, implement, screenshot results, refine 2-3 iterations
4. **Safe Autonomous Mode**: Use `--dangerously-skip-permissions` in isolated containers for low-risk tasks

#### Performance Optimization Tips

- **Specificity matters significantly** -- "add tests" vs detailed edge case descriptions
- Use images/screenshots as reference points
- Tab-complete file paths to anchor context
- Paste URLs for on-demand resource fetching
- Interrupt with Escape to course-correct early
- `/clear` between tasks to reset context window
- Multiple Claude instances: separate for writing vs reviewing

### Top Community Tips (from ykdojo/claude-code-tips, Anthropic DevRel)

**URL:** https://github.com/ykdojo/claude-code-tips

45+ tips from daily usage. Key highlights:

| Tip | Detail |
|-----|--------|
| **Slim system prompt** | Lazy-load MCP tools; don't load all simultaneously |
| **Git worktrees** | `git worktree` for parallel branch development |
| **Proactive compaction** | Run `/compact` every ~40 messages with focus area |
| **Handoff documents** | Create before fresh conversations; `/handoff` command automates |
| **Clone/half-clone** | Fork conversations; reduce context with "half-clone" |
| **Fresh context wins** | New discussion > long conversation for performance |
| **Terminal aliases** | `alias c='claude'`, `c -c` (continue), `c -r` (resume) |
| **CLAUDE.md vs Skills** | CLAUDE.md = always loaded. Skills = on-demand. Keep CLAUDE.md lean. |
| **Realpath** | Use `realpath` for absolute file paths in references |
| **Audit approved commands** | Regularly review auto-execution allow list |
| **Background subagents** | Strategic deployment for parallel specialized work |

### The "dx" Plugin (from ykdojo)

Bundles practical tools as a Claude Code plugin:
- `/dx:clone` - Fork conversation
- `/dx:half-clone` - Reduced context fork
- `/dx:handoff` - Create handoff document
- `/dx:gha` - GitHub Actions helper

---

## 5. Context Management Problems (Issues)

### Issue #34556: Persistent Memory Across Context Compactions (59 compactions)

**URL:** https://github.com/anthropics/claude-code/issues/34556

**The Problem:** Claude Code has NO persistent memory between context compactions. Every compaction loses everything not externally saved. After 59 compactions across 26 days, the issue author built a complete memory system.

**Impact:** ~3,100 tokens reloaded per session start. Over 10 compactions = ~31,000 tokens wasted.

#### User-Built Solution: 3-Tier Memory Architecture

**L1: MEMORY.md** (~100 lines, always loaded)
- Pointers to deeper files
- Critical rules surviving every compaction
- "I Remember..." section (emotional/relational cues)
- Last 5 events for quick orientation

**L2: Topic Files** (memory/*.md, loaded on demand)
- ~15 files, each under 200 lines
- Project summaries, people profiles, infrastructure notes

**L3: Vault** (OneDrive-synced, ~200 files)
- 127 conversation narratives
- 10 architectural decision records
- 1,477-line append-only changelog (event bus)
- 59-entry compaction log with timestamps and "last words"

**Supporting infrastructure:**
- `compaction_watcher.py` -- Monitors JSONL for compaction markers
- **Context Compression Language (CCL)** -- 4-tier shorthand (T0-T3) compressing system prompts 65-72%
- **Session Protocol** in CLAUDE.md standing orders:
  - On boot: read L1, read ToDo, read changelog if resuming
  - Mid-session: file insights immediately (never batch -- compaction will eat them)
  - Post-compaction: autosave narrative, update changelog, re-read L1
  - On end: write conversation narrative, update state files

#### Community Solution: Self-Balancing Memory Tree (Alzheimer project)

- Root `MEMORY.md` capped at 150 lines
- `_index/` category files
- Leaf topic files
- Self-balancing via PostToolUse, SessionStart, PreCompact hooks
- Drift detection for orphaned files and oversized leaves
- Two-layer safety (memory rules + PreToolUse hook)

#### Community Solution: Minolith (Hosted API)

**URL:** https://minolith.io/

- 19 entry types (rule, decision, warning, pattern, event, workflow, etc.)
- Nothing in context window -- hosted API; compaction can't touch it
- Cross-session event bus with immutable timestamped entries
- Loads 2-3K tokens of precisely filtered context at session start

### Issue #24677: Compaction Death Spiral (6 compactions in 3.5 minutes)

**URL:** https://github.com/anthropics/claude-code/issues/24677

**Root Cause:** Large CLAUDE.md (~32KB) + MCP servers = system context consuming 86.5% of window.

| Component | Tokens | % of 200K |
|-----------|--------|-----------|
| CLAUDE.md | ~28,000 | 14% |
| MCP tool definitions | ~80,000 | 40% |
| System prompts | ~40,000 | 20% |
| Compaction instructions | ~25,000 | 12.5% |
| **Total system context** | **~173,000** | **86.5%** |
| **Available for work** | **~27,000** | **13.5%** |

**Result:** ~1M tokens wasted on compaction overhead. Compaction #6 failed entirely.

**Mitigations suggested:**
1. Lazy-load MCP tool definitions (only used tools)
2. Compaction cooldown (minimum 60s between attempts)
3. Circuit breaker (stop after N failed/rapid compactions)
4. Headroom check (skip if system > X% of window)
5. Larger-context model for compaction when system context is large
6. Terser summaries (reference paths, don't reproduce code)

### Issue #28984: Increase Effective Context / Reduce Compaction Overhead

**URL:** https://github.com/anthropics/claude-code/issues/28984

### Issue #23920: Auto-Upgrade to Larger Context Window Model

**URL:** https://github.com/anthropics/claude-code/issues/23920

### The 33K-45K Token Problem

Current buffer: ~33,000 tokens (16.5%). Working limit at 167K tokens. Compaction at that threshold feels like losing roughly half of available tokens.

**Key insight from community:** "Most agent failures aren't model failures -- they're context failures."

---

## 6. Subagent Patterns and Multi-Agent Workflows

### Official Claude Code Subagent System

**URL:** https://code.claude.com/docs/en/sub-agents

Subagents are defined in `.claude/agents/` as markdown files with YAML frontmatter:

```markdown
---
name: reviewer
description: Reviews code for quality and correctness
isolation: worktree    # Optional: each gets own git worktree
allowed_tools:
  - Read
  - Grep
  - Glob
  # No Write/Edit = read-only agent
---

# Code Reviewer

Review the provided code for:
- Correctness
- Performance
- Security
- Style consistency
```

### Tool Allocation by Role (from VoltAgent/awesome-claude-code-subagents)

**URL:** https://github.com/VoltAgent/awesome-claude-code-subagents

130+ specialized subagents across 10 categories:

| Category | Agent Count | Plugin Name |
|----------|-------------|-------------|
| Core Development | 11 | voltagent-core-dev |
| Language Specialists | 31 | voltagent-lang |
| Infrastructure & DevOps | 16 | voltagent-infra |
| Quality & Security | 15 | voltagent-qa-sec |
| Data & AI | 13 | voltagent-data-ai |
| Developer Experience | 14 | voltagent-dev-exp |
| Specialized Domains | 12 | voltagent-domains |
| Business & Product | 11 | voltagent-biz |
| Meta & Orchestration | 13 | voltagent-meta |
| Research & Analysis | 3 | voltagent-research |

**Key pattern:** Read-only agents for reviewers (Read/Grep/Glob only), research agents (WebFetch/WebSearch), code-writing agents (Read/Write/Edit/Bash).

### Orchestration Frameworks

| Framework | Description |
|-----------|-------------|
| **Claude Squad** (smtg-ai) | Terminal app managing multiple agents in separate workspaces |
| **Claude Swarm** (parruda) | Launch session connected to agent swarm |
| **Claude Task Master** (eyaltoledano) | Task management for AI-driven development |
| **Ruflo** (ruvnet) | Multi-agent swarm with vector memory, hierarchical or mesh patterns |
| **metaswarm** (dsifry) | 18 agents, 13 skills, 9-phase workflow with quality gates |
| **Auto-Claude** (AndyMik90) | Multi-agent with kanban UI |
| **sudocode** (ssh-randy) | Lightweight orchestration integrated with specs |

### Claude Code Swarm Orchestration (kieranklaassen gist)

**URL:** https://gist.github.com/kieranklaassen/4f2aba89594a4aea4ad64d753984b2ea

Complete guide to multi-agent coordination with TeammateTool, Task system, and patterns.

### Subagent Context Management (from ACE)

Subagents serve context control purposes:
- Handle search, summarization, file discovery in isolated context windows
- Free the primary agent's context for implementation work
- Iterative retrieval pattern manages context limitations when delegating

### Sequential vs Parallel Patterns

**Sequential:** Each subagent completes, returns results to orchestrator, which passes relevant context to next subagent.

**Parallel (via worktrees):** `/batch` decomposes large task into 5-30 independent units, spawns one background agent per unit in isolated worktree, each implements + tests + opens PR.

---

## 7. CLAUDE.md Structure Best Practices

### Recommended Size and Budget

- **Target:** Under 200 lines, under 5,000 tokens
- **Rationale:** Claude loads CLAUDE.md automatically at session start. Every token here is consumed on EVERY interaction.
- **Danger zone:** 28K+ tokens in CLAUDE.md = compaction death spiral potential

### What to Include

| Section | Content |
|---------|---------|
| **Project summary** | 2-3 sentence overview |
| **Build commands** | Exact commands with flags: `npm test`, `pytest -v`, etc. |
| **Code style** | ONE real code snippet beats three paragraphs describing style |
| **Architecture map** | Where controllers live, how routing works |
| **Testing requirements** | Framework, patterns, coverage thresholds |
| **Critical bugs / mistakes** | Common pitfalls specific to this codebase |
| **Git workflow** | Branch naming, commit format, PR process |
| **Boundaries** | What NOT to do (never modify .env, don't touch vendor/) |

### What NOT to Include

- Verbose explanations (use skills for on-demand loading)
- Duplicated code structure (drifts -- let code be authoritative)
- Generic advice ("write clean code")
- Full API documentation (reference via skills or external docs)

### Token Optimization Pattern

From John Lindquist's 54% reduction study:

| Technique | Impact |
|-----------|--------|
| Trigger-based routing (minimal index instead of full docs) | 70% reduction |
| Identity file compression | 82% reduction |
| Lazy loading via Skills | 93% reduction for archived content |
| Consolidated documentation (merge duplicates) | Significant |
| Remove duplicate hook injections | Prevents context flooding |

**Core insight:** Move from verbose inline documentation to structured triggers. Registry as single source of truth. Hooks for enforcement, not instructions.

### File Organization Beyond CLAUDE.md

```
CLAUDE.md                    # Main (< 200 lines, always loaded)
.claudeignore                # Keeps old docs from loading
.claude/
  COMMON_MISTAKES.md         # Loaded on demand
  QUICK_START.md
  ARCHITECTURE_MAP.md
  settings.json              # Hooks, permissions, tools
  hooks/                     # Hook scripts
  commands/                  # Slash commands
  agents/                    # Subagent definitions
  skills/                    # Skill definitions
  completions/               # Archived work (0 tokens)
  sessions/                  # Session logs
```

### Compaction Instructions in CLAUDE.md

```markdown
## Compaction Rules
When compacting context, preserve:
- Active file paths and their purposes
- Current task state and next steps
- Test results and error messages
- Architectural decisions made this session
```

Run `/compact` with specific focus: `Focus on code samples and API usage`

---

## 8. AGENTS.md Patterns (Cross-Tool Insights)

### Source: GitHub Blog - "Lessons from 2,500+ Repositories"

**URL:** https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/

#### Five Critical Success Elements

1. **Executable commands early** -- `npm test`, `pytest -v` with flags, not just tool names
2. **Real code snippets** -- One snippet > three paragraphs
3. **Clear constraints** -- Secrets, vendor dirs, production configs
4. **Specific stack details** -- "React 18 with TypeScript, Vite, and Tailwind CSS" with versions
5. **Six essential areas:** Commands, Testing, Structure, Code Style, Git Workflow, Boundaries

#### Anti-Pattern
"You are a helpful coding assistant" FAILS.
"You are a test engineer who writes tests for React components" SUCCEEDS.

#### Recommended Agent Types

| Agent | Role | Key Boundary |
|-------|------|-------------|
| @docs-agent | Generate API docs to docs/ only | Read-only on source |
| @test-agent | Write unit/integration tests | Never remove failing tests without auth |
| @lint-agent | Fix formatting and style | Low-risk (linters are safe) |
| @api-agent | Create endpoints | Ask before schema modifications |
| @dev-deploy-agent | Handle local builds | Require explicit approval for deploys |
| @security-agent | Analyze for vulnerabilities | Report only, no auto-fixes |

#### Three-Tier Boundary Framework

- **Always do** (required actions)
- **Ask first** (decisions requiring authorization)
- **Never do** (strictly forbidden actions)

### Source: Ischca/awesome-agents-md

**URL:** https://github.com/Ischca/awesome-agents-md

Real-world examples:
- OpenAI Codex official AGENTS.md (tests, environment, safety rules)
- Temporal Java SDK (production build/test instructions)
- Next.js Shop (monorepo TypeScript e-commerce)
- Rust API Skeleton (Axum REST APIs)

### Source: agentsmd/agents.md (Spec)

**URL:** https://agents.md/

Open format specification for guiding coding agents across tools.

---

## 9. .cursorrules / Aider Conventions (Parallel Ecosystem)

### awesome-cursorrules (PatrickJS)

**URL:** https://github.com/PatrickJS/awesome-cursorrules

179 rule categories covering virtually every major stack:

**Most popular categories:**
- React (TypeScript, Next.js, Redux, Chakra UI, styled-components, GraphQL/Apollo)
- Next.js (App Router, Material UI, Tailwind, Supabase, SEO, PWA, Vercel)
- Python (FastAPI, Django, Flask, containerization)
- Vue (3, Nuxt 3, composition API)
- Go (backend, servemux, Temporal DSL, HTMX)
- Mobile (React Native/Expo, Flutter/Riverpod, SwiftUI, Jetpack Compose)
- Testing (Jest, Vitest, Cypress, Playwright -- each with a11y, API, e2e variants)
- Blockchain (Solidity with Foundry/Hardhat)
- DevOps (Docker, Kubernetes, GitHub Actions)

**Key insight for CLAUDE.md authors:** These rules show what developers care about most when guiding AI -- framework-specific conventions, testing patterns, and code style enforcement. The most popular rules are VERY specific (not generic advice).

### Aider Conventions

**URL:** https://github.com/Aider-AI/conventions

Community-contributed convention files:
- bash-scripts, flutter, functional-programming, golang, icalendar-events, moodle500, nextjs-ts

**Pattern:** Load as read-only with `/read CONVENTIONS.md` or `aider --read CONVENTIONS.md`. Best configured in `.aider.conf.yml`:
```yaml
read: [CONVENTIONS.md, anotherfile.txt]
```

**Cross-tool insight:** All AI coding tools converge on the same pattern -- a markdown file loaded at session start with project-specific conventions. The format details differ but the concept is universal.

---

## 10. Advanced Context Engineering Techniques

### Source: humanlayer/advanced-context-engineering-for-coding-agents

**URL:** https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/ace-fca.md

#### The "Frequent Intentional Compaction" Technique

Three-phase workflow maximizing AI effectiveness in large codebases:

**Phase 1: Research** -- Comprehend architecture, locate files, understand info flow. Establish knowledge base before proceeding.

**Phase 2: Planning** -- Outline precise implementation steps, identify files needing modification, detail verification procedures. Specificity prevents cascading errors.

**Phase 3: Implementation** -- Execute incrementally, compact status updates back into planning documents after each verified phase.

#### Context Window Management Principles

Hierarchy of context quality problems (most to least severe):
1. **Incorrect information** (worst)
2. **Missing information**
3. **Excessive noise** (least severe)

**Target utilization:** 40-60% depending on complexity. Prevents both information loss and cognitive overload.

#### Human Leverage Strategy

```
Research review --> prevents THOUSANDS of incorrect code lines
Plan review     --> prevents HUNDREDS of problematic lines
Code review     --> catches INDIVIDUAL errors
```

Strategic human attention on research and planning > traditional code-only review.

#### Results Achieved
- Fixed bugs in unfamiliar 300k LOC Rust codebases within hours
- Shipped 35k lines of complex features in 7 hours
- Quality sufficient for direct merge approval

### Source: coleam00/context-engineering-intro

**URL:** https://github.com/coleam00/context-engineering-intro

#### The PRP (Prompt-Response-Plan) Workflow

**Philosophy:** "Most agent failures aren't model failures -- they're context failures."

**Three key files:**

1. **CLAUDE.md** -- Global rules (architecture, conventions, testing, style, docs)
2. **INITIAL.md** -- Feature request template with FEATURE, EXAMPLES, DOCUMENTATION, OTHER CONSIDERATIONS sections
3. **PRP file** -- Generated implementation blueprint with validation gates

**Critical folder:** `examples/` -- Living style guide showing patterns for module organization, test structure, API clients, CLI parsing. "AI assistants perform significantly better when provided concrete patterns."

**PRP Generation Phase (`/generate-prp`):**
- Analyzes codebase for patterns
- Gathers relevant documentation
- Creates step-by-step blueprint
- Includes validation gates and test requirements
- Assigns confidence scores (1-10)

**PRP Execution Phase (`/execute-prp`):**
- Loads complete context
- Implements iteratively
- Self-corrects through test validation

### Source: NeoLabHQ/context-engineering-kit

**URL:** https://github.com/NeoLabHQ/context-engineering-kit

#### Spec-Driven Development (SDD)

"Development as compilation" -- transforming task specifications into working implementations.

**Multi-agent orchestration:**
- researcher, code-explorer, business-analyst, architect
- QA-engineer, developer, tech-writer

**Quality gates:** LLM-as-Judge with structured rubrics

**Commands:** `/sdd:add-task`, `/sdd:plan`, `/sdd:implement`

#### Reflexion Plugin

Feedback and refinement loops:
- `/reflexion:reflect` -- Self-refinement with complexity triage
- `/reflexion:memorize` -- Extract insights to project memory
- `/reflexion:critique` -- Multi-perspective review with debate and consensus

#### Additional Techniques Implemented

| Technique | Description |
|-----------|-------------|
| Zero-shot/Few-shot Chain of Thought | Structured reasoning templates |
| Tree of Thoughts | Branching exploration |
| Problem Decomposition | Breaking complex into simple |
| Multi-agent orchestration | Context isolation and management |
| LLM-as-Judge quality gates | Structured rubric evaluation |
| Continuous learning | Skill building from patterns |
| MAKER pattern | Agent reliability |
| Competitive generation | Multi-judge evaluation |
| ADI cycle (FPF plugin) | Abduction-Deduction-Induction for transparent reasoning |
| 5 Whys / Cause-Effect (Kaizen) | Root cause analysis |

### Source: Meirtz/Awesome-Context-Engineering

**URL:** https://github.com/Meirtz/Awesome-Context-Engineering

Comprehensive survey: hundreds of papers, frameworks, implementation guides for LLMs and AI agents.

### Source: Denis2054/Context-Engineering-for-Multi-Agent-Systems

**URL:** https://github.com/Denis2054/Context-Engineering-for-Multi-Agent-Systems

Production-ready blueprint for Multi-Agent Systems (MAS). Replace rigid workflows with dynamic, transparent Context Engine with 100% transparency.

**Three-tier architecture:**
- **Hot memory** (constitution, always loaded)
- **Domain specialists** (agents, invoked per task)
- **Cold memory** (knowledge base, retrieved on demand)

### The Agent Harness Concept (2026)

From community discussions: In 2026, the most important context engineering advances no longer live inside the prompt. They live inside the **agent harness**: the runtime loop managing plans, subagents, checkpoints, files, approvals, tool execution, and recovery from failure. Context engineering becomes agent engineering.

---

## 11. The Ralph Wiggum Autonomous Loop Pattern

### Official Plugin

**URL:** https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum

### How It Works

Ralph is a Bash `while true` loop that repeatedly feeds an AI agent a prompt file. The plugin uses a **Stop hook** that intercepts Claude's exit attempts:

1. Claude works on the task
2. Claude tries to exit
3. Stop hook blocks exit
4. Stop hook feeds the same prompt back
5. Cycle repeats until completion

**Key mechanism:** Dual-condition exit detection requiring both completion indicators AND explicit EXIT_SIGNAL.

### Philosophy

Inverts the usual AI coding workflow. Instead of carefully reviewing each step, define success criteria upfront and let the agent iterate toward them. Failures become data.

### Notable Implementations

| Implementation | Author | Key Feature |
|---------------|--------|-------------|
| Official Plugin | Anthropic | Stop hook-based, part of claude-code repo |
| ralph-claude-code | Frank Bria | Intelligent exit detection, safety guardrails |
| ralph-orchestrator | mikeyobrien | Robust orchestration with testing |
| ralph-wiggum-bdd | marcindulak | BDD with Ralph loop |
| Ralph Playbook | Clayton Farr | Detailed guide with practical guidelines |
| awesome-ralph | Martin Joly | Curated resources about the technique |

---

## 12. Git Worktree Parallel Agent Patterns

### Official Support

Subagents support `isolation: worktree` in frontmatter. Each gets own worktree, auto-cleaned when done.

```markdown
---
name: feature-builder
isolation: worktree
allowed_tools: [Read, Write, Edit, Bash, Grep, Glob]
---
```

### Usage Patterns

**Manual:**
```bash
# Open multiple terminals, each with own worktree
claude -w task-name    # in terminal 1
claude -w task-name-2  # in terminal 2
```

**At scale via /batch:**
- Decomposes large task into 5-30 independent units
- Spawns one background agent per unit in isolated worktree
- Each implements, tests, opens PR

**Anthropic internal:** 10-15 parallel sessions simultaneously (per Cherny).

### Community Tools

| Tool | Description |
|------|-------------|
| **parallel-code** (johannesjo) | Desktop app: every agent gets own branch/worktree automatically |
| **parallel-worktrees** (SpillwaveSolutions) | Runs parallel subagents, syncs with git worktrees |
| **parallel-cc** (frankbria) | Automated parallel management with autonomous coordination |
| **viwo-cli** (OverseedAI) | Docker runner with git worktrees for safer execution |
| **Container Use** (dagger) | Development environments for safe independent agent work |

---

## 13. Token Optimization Strategies

### The Token Budget Problem

| Scenario | Impact |
|----------|--------|
| CLAUDE.md > 200 lines | Wastes tokens every interaction |
| Multiple MCP servers loaded eagerly | 80K+ tokens on tool definitions alone |
| No compaction strategy | Context fills, quality degrades |
| Duplicate hook injections | Context flooding |

### Proven Optimization Techniques

#### 1. Lazy Loading (biggest win)

Move specialized instructions into skills that load on-demand. Only CLAUDE.md loads automatically.

```
Before: 7,584 initial tokens
After:  3,434 initial tokens (54% reduction)
```

#### 2. Trigger-Based Routing

Instead of full docs upfront, use minimal trigger tables mapping phrases to skills:
```
"task" -> /task-skill
"deploy" -> /deploy-skill
"test" -> /tdd-skill
```

#### 3. Proactive Compaction

Run `/compact` every ~40 messages. Specify focus:
```
/compact Focus on code samples and API usage
```

#### 4. Session Handoff Documents

Before starting fresh: create handoff doc capturing state, decisions, next steps.
```
/handoff    # If using dx plugin
```

#### 5. Context Compression Language (CCL)

4-tier shorthand system achieving 65-72% compression of system prompts:
- T0: Base compression
- T1-T3: Progressive shorthand based on MetaGlyph, Gregg shorthand, military brevity codes

#### 6. .claudeignore

Exclude files from auto-loading:
```
# .claudeignore
old-docs/
vendor/
node_modules/
*.log
```

#### 7. Modular Context Files

Split reusable info into standalone markdown/YAML loaded on demand via `@filename.md` syntax:
```
@docs/progress.md
@session_summary.md
@CLAUDE.md
```

---

## 14. Key Repositories Index

### Awesome Lists / Curations

| Repository | Stars | Focus |
|-----------|-------|-------|
| [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | 28K+ | Skills, hooks, commands, orchestrators, plugins |
| [josix/awesome-claude-md](https://github.com/josix/awesome-claude-md) | -- | Real CLAUDE.md examples from production repos |
| [PatrickJS/awesome-cursorrules](https://github.com/PatrickJS/awesome-cursorrules) | -- | 179 .cursorrules by technology |
| [Ischca/awesome-agents-md](https://github.com/Ischca/awesome-agents-md) | -- | Real AGENTS.md files and templates |
| [Meirtz/Awesome-Context-Engineering](https://github.com/Meirtz/Awesome-Context-Engineering) | -- | Papers, frameworks, implementation guides |
| [travisvn/awesome-claude-skills](https://github.com/travisvn/awesome-claude-skills) | -- | Skills resources and tools |

### Frameworks / Systems

| Repository | Stars | Focus |
|-----------|-------|-------|
| [anthropics/skills](https://github.com/anthropics/skills) | 110K | Official Anthropic skills |
| [obra/superpowers](https://github.com/obra/superpowers) | 135K | Core SDLC skill set |
| [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) | -- | 38 agents, 156 skills, full harness |
| [NeoLabHQ/context-engineering-kit](https://github.com/NeoLabHQ/context-engineering-kit) | -- | SDD, reflexion, quality gates |
| [VoltAgent/awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) | -- | 130+ specialized subagents |
| [dsifry/metaswarm](https://github.com/dsifry/metaswarm) | -- | Self-improving multi-agent framework |
| [coleam00/context-engineering-intro](https://github.com/coleam00/context-engineering-intro) | -- | PRP workflow, examples-driven |

### Hooks / Configuration

| Repository | Focus |
|-----------|-------|
| [disler/claude-code-hooks-mastery](https://github.com/disler/claude-code-hooks-mastery) | All 13 hook types with examples |
| [johnlindquist/claude-hooks](https://github.com/johnlindquist/claude-hooks) | Hook implementations |
| [decider/claude-hooks](https://github.com/decider/claude-hooks) | Clean code enforcement hooks |
| [karanb192/claude-code-hooks](https://github.com/karanb192/claude-code-hooks) | Copy-paste hook collection |
| [ChrisWiles/claude-code-showcase](https://github.com/ChrisWiles/claude-code-showcase) | Complete settings.json showcase |
| [anthropics/claude-code/examples/settings](https://github.com/anthropics/claude-code/tree/main/examples/settings) | Official lax/strict/sandbox profiles |

### Guides / Documentation

| Repository | Focus |
|-----------|-------|
| [FlorianBruniaux/claude-code-ultimate-guide](https://github.com/FlorianBruniaux/claude-code-ultimate-guide) | Beginner to power user |
| [ykdojo/claude-code-tips](https://github.com/ykdojo/claude-code-tips) | 45+ practical tips from Anthropic DevRel |
| [luongnv89/claude-howto](https://github.com/luongnv89/claude-howto) | Visual, example-driven guide |
| [awattar/claude-code-best-practices](https://github.com/awattar/claude-code-best-practices) | Best practices with /custom-init |
| [humanlayer/advanced-context-engineering-for-coding-agents](https://github.com/humanlayer/advanced-context-engineering-for-coding-agents) | ACE techniques |
| [abhishekray07/claude-md-templates](https://github.com/abhishekray07/claude-md-templates) | CLAUDE.md templates |

### Memory / Persistence

| Repository | Focus |
|-----------|-------|
| [yuvalsuede/memory-mcp](https://github.com/yuvalsuede/memory-mcp) | Persistent memory across sessions |
| [wbelk/claude-qmd-sessions](https://github.com/wbelk/claude-qmd-sessions) | Session memory with qmd indexing |
| [kayba-ai/agentic-context-engine](https://github.com/kayba-ai/agentic-context-engine) | Agents that learn from experience |

### Orchestrators

| Repository | Focus |
|-----------|-------|
| [smtg-ai/claude-squad](https://github.com/smtg-ai/claude-squad) | Terminal multi-agent manager |
| [parruda/claude-swarm](https://github.com/parruda/claude-swarm) | Agent swarm sessions |
| [ruvnet/ruflo](https://github.com/ruvnet/ruflo) | Enterprise swarm platform |
| [johannesjo/parallel-code](https://github.com/johannesjo/parallel-code) | Parallel agents with auto-worktrees |
| [frankbria/parallel-cc](https://github.com/frankbria/parallel-cc) | Parallel management + cloud VMs |
| [eyaltoledano/claude-task-master](https://github.com/eyaltoledano/claude-task-master) | Task management for AI dev |

### Tools / Utilities

| Repository | Focus |
|-----------|-------|
| [matt1398/claude-devtools](https://github.com/matt1398/claude-devtools) | Session observability desktop app |
| [agent-sh/agnix](https://github.com/agent-sh/agnix) | Linter for CLAUDE.md, AGENTS.md, SKILL.md, hooks |
| [carlrannaberg/claudekit](https://github.com/carlrannaberg/claudekit) | CLI with checkpointing + 20 subagents |
| [foxj77/claudectx](https://github.com/foxj77/claudectx) | Switch entire config with one command |
| [nadimtuhin/claude-token-optimizer](https://github.com/nadimtuhin/claude-token-optimizer) | 90% token savings setup prompts |
| [zilliztech/claude-context](https://github.com/zilliztech/claude-context) | Code search MCP for entire codebase context |

---

## Key Takeaways

### The Convergence Pattern
Every AI coding tool ecosystem (Claude Code, Cursor, Codex, Aider, Copilot) converges on the same fundamental pattern: a **markdown file loaded at session start** containing project-specific conventions, commands, and boundaries. The format differs but the concept is universal.

### The Context Hierarchy That Works
```
Always loaded (< 5K tokens):     CLAUDE.md / AGENTS.md / .cursorrules
On-demand (skills/agents):       Loaded only when task matches
Session state (hooks):           Injected via filesystem persistence
Cold storage (docs/vault):       Referenced but not loaded until needed
```

### The Five Highest-Leverage Investments
1. **CLAUDE.md quality** -- Keep it lean, specific, and actionable (< 200 lines)
2. **Skills for specialized knowledge** -- Everything not always-needed goes here
3. **Hooks for persistence** -- SessionStart + PostToolUse + PreCompact for memory
4. **Subagents with role-appropriate tools** -- Read-only reviewers, full-access builders
5. **Compaction strategy** -- Proactive compaction, handoff docs, session protocols

### The Anti-Patterns That Waste Tokens
1. Bloated CLAUDE.md (> 5K tokens)
2. Eagerly-loaded MCP tool definitions
3. Duplicate information across files
4. Generic instructions ("write clean code")
5. No compaction strategy (hoping for the best)
6. Verbose inline documentation instead of trigger tables

### What the Community Wants (Feature Requests)
1. Structured persistent memory surviving compaction
2. Automatic pre-compaction save of discoveries/decisions
3. Cross-session event bus (append-only log)
4. User profile persistence across sessions
5. Lazy MCP tool loading
6. Compaction cooldown/circuit breaker
7. PostCompact hook for verification
