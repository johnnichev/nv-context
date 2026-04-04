# AI Coding Agent Configuration Files: Comprehensive Research

**Research Date:** 2026-04-04
**Scope:** CLAUDE.md, AGENTS.md, .cursorrules, copilot-instructions.md, GEMINI.md, .windsurfrules, and related agent configuration files.

---

## Table of Contents

1. [Landscape Overview](#1-landscape-overview)
2. [CLAUDE.md Deep Dive](#2-claudemd-deep-dive)
3. [AGENTS.md (Universal Standard)](#3-agentsmd-universal-standard)
4. [Cursor Rules (.cursorrules / .mdc)](#4-cursor-rules)
5. [GitHub Copilot (copilot-instructions.md)](#5-github-copilot)
6. [GEMINI.md](#6-geminimd)
7. [Windsurf Rules](#7-windsurf-rules)
8. [Aider Conventions](#8-aider-conventions)
9. [Claude Code Skills System](#9-claude-code-skills-system)
10. [Context Engineering Principles](#10-context-engineering-principles)
11. [ETH Zurich Research: What Actually Works](#11-eth-zurich-research)
12. [Anti-Patterns and Common Mistakes](#12-anti-patterns-and-common-mistakes)
13. [Real-World Examples and Repositories](#13-real-world-examples)
14. [Templates and Frameworks](#14-templates-and-frameworks)
15. [Cross-Tool Strategy](#15-cross-tool-strategy)
16. [Key Takeaways for UltraContext](#16-key-takeaways-for-ultracontext)

---

## 1. Landscape Overview

Every major AI coding tool now reads a configuration file from the project root. These files solve a fundamental problem: **AI models have no persistent memory** -- every session starts blank.

### Complete File Format Matrix

| File Format | Tool | Location | Format |
|---|---|---|---|
| `CLAUDE.md` | Claude Code | Project root + `~/.claude/` | Markdown |
| `AGENTS.md` | Codex, Copilot, Cursor, 25+ tools | Project root + subdirs | Markdown |
| `GEMINI.md` | Gemini CLI | Project root + `~/.gemini/` | Markdown |
| `.cursorrules` | Cursor (legacy) | Project root | Plain text |
| `.cursor/rules/*.mdc` | Cursor (current) | `.cursor/rules/` directory | MDC format |
| `.github/copilot-instructions.md` | GitHub Copilot | `.github/` directory | Markdown |
| `.github/instructions/*.instructions.md` | GitHub Copilot (scoped) | `.github/instructions/` | Markdown + frontmatter |
| `.windsurfrules` | Windsurf (legacy) | Project root | Plain text |
| `.windsurf/rules/*.md` | Windsurf (current) | `.windsurf/rules/` directory | Markdown |
| `CONVENTIONS.md` | Aider | Project root | Markdown |

### Industry Convergence

The industry is converging on "markdown file at project root that tells AI agents how to behave." AGENTS.md has the broadest cross-tool support (25+ tools, Linux Foundation governance, 60,000+ open source projects), while CLAUDE.md has the deepest feature integration with Claude Code specifically.

**Key insight from Martin Fowler's team:** Context engineering has replaced prompt engineering as the key discipline. It's about "curating what the model sees" -- managing the entire information landscape including system instructions, tools, external data, and message history.

---

## 2. CLAUDE.md Deep Dive

### What It Is

CLAUDE.md is a special Markdown file that Claude Code reads at the start of every conversation. It provides persistent context that Claude cannot infer from code alone. It is loaded every session, so it should only contain broadly applicable guidance.

**Source:** [Anthropic Official Best Practices](https://code.claude.com/docs/en/best-practices)

### File Locations (Hierarchical Loading)

| Level | Path | Applies To |
|---|---|---|
| Global | `~/.claude/CLAUDE.md` | All Claude sessions |
| Project (shared) | `./CLAUDE.md` or `.claude/CLAUDE.md` | Team (check into git) |
| Project (personal) | `./CLAUDE.local.md` | Personal project overrides (gitignore this) |
| Parent directories | `root/CLAUDE.md` | Monorepo roots |
| Child directories | `root/foo/CLAUDE.md` | On-demand when working in that directory |

**Loading behavior:** Starting from the current working directory, Claude searches upward toward the root, loading every CLAUDE.md file it finds. Subdirectory CLAUDE.md files are only loaded when Claude actually accesses files in those directories, keeping context focused.

**Import syntax:** CLAUDE.md files can import additional files using `@path/to/import`:
```markdown
See @README.md for project overview and @package.json for available npm commands.
# Additional Instructions
- Git workflow: @docs/git-instructions.md
- Personal overrides: @~/.claude/my-project-instructions.md
```

### What to Include vs. Exclude

**From Anthropic's official documentation:**

| Include | Exclude |
|---|---|
| Bash commands Claude can't guess | Anything Claude can figure out by reading code |
| Code style rules that differ from defaults | Standard language conventions Claude already knows |
| Testing instructions and preferred test runners | Detailed API documentation (link to docs instead) |
| Repository etiquette (branch naming, PR conventions) | Information that changes frequently |
| Architectural decisions specific to your project | Long explanations or tutorials |
| Developer environment quirks (required env vars) | File-by-file descriptions of the codebase |
| Common gotchas or non-obvious behaviors | Self-evident practices like "write clean code" |

### Critical Length Constraints

**From Anthropic:** Target under 200 lines per file. For each line, ask: "Would removing this cause Claude to make mistakes?" If not, cut it.

**From HumanLayer research:** Frontier LLMs can follow approximately 150-200 instructions reliably. Claude Code's system prompt already contains ~50 instructions, leaving limited capacity for user content. Under 300 lines is acceptable; under 60 lines is ideal.

**From the gradually.ai template guide:** 200-500 lines keeps content manageable. Global CLAUDE.md should be max 50 lines.

**Why this matters:** Claude Code injects a system reminder: *"IMPORTANT: this context may or may not be relevant to your tasks. You should not respond...unless it is highly relevant to your task."* This means non-universal instructions get actively deprioritized. Bloated files cause Claude to ignore your actual instructions.

### Emphasis Techniques

You can tune instructions by adding emphasis:
- "IMPORTANT" or "YOU MUST" improves adherence
- RFC 2119 language ("MUST use TypeScript strict mode" vs "Prefer TypeScript") significantly improves compliance
- "NEVER modify migration files" is clearer than "avoid modifying migration files"

### Official Example from Anthropic

```markdown
# Code style
- Use ES modules (import/export) syntax, not CommonJS (require)
- Destructure imports when possible (eg. import { foo } from 'bar')

# Workflow
- Be sure to typecheck when you're done making a series of code changes
- Prefer running single tests, and not the whole test suite, for performance
```

### Monorepo Strategy

For large codebases:
- Root CLAUDE.md provides orientation, not exhaustive detail -- think of it as the introduction chapter of a book
- Stay under 10k words for best performance
- Split into smaller, relevant pieces that load only when needed
- Use skills (`.claude/skills/`) for on-demand context rather than cramming everything into CLAUDE.md
- Each package/subdirectory can have its own CLAUDE.md with scoped rules

**Source:** [DEV Community - Organizing CLAUDE.md in Monorepos](https://dev.to/anvodev/how-i-organized-my-claudemd-in-a-monorepo-with-too-many-contexts-37k7)

### Progressive Disclosure Strategy

Instead of cramming everything into CLAUDE.md, create separate markdown files:

```
agent_docs/
 |- building_the_project.md
 |- running_tests.md
 |- code_conventions.md
 |- service_architecture.md
 |- database_schema.md
```

Point Claude to these files rather than copying content. Use `file:line` references to authoritative sources.

**Source:** [HumanLayer Blog](https://www.humanlayer.dev/blog/writing-a-good-claude-md)

---

## 3. AGENTS.md (Universal Standard)

### What It Is

AGENTS.md is an open, tool-agnostic standard for providing instructions to AI coding agents. It emerged from collaboration between Sourcegraph, OpenAI, Google, Cursor, and Factory, and is now stewarded by the Agentic AI Foundation under the Linux Foundation.

**Key stat:** Over 60,000 open-source projects use this format.

**Supported by 25+ tools** including Codex, Copilot, Cursor, Windsurf, Continue.dev, Aider, OpenHands, and more. Note: Claude Code uses CLAUDE.md natively but also recognizes AGENTS.md as a fallback.

**Source:** [agents.md](https://agents.md/) and [GitHub Blog - 2500 repositories analysis](https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/)

### Core Principles

- No required fields -- standard Markdown with agent-friendly headings
- A "README for agents" -- complements README.md
- File placement at repository root; nested files in monorepos for subproject-specific guidance
- Closest AGENTS.md in directory tree takes precedence; explicit chat prompts override all

### Six Core Coverage Areas (from 2500-repo Analysis)

Top-tier agents address all six dimensions:
1. **Executable commands** -- full flags and options, not just tool names
2. **Testing practices** -- CI/CD commands, test patterns, validation steps
3. **Project structure** -- folder organization and file locations
4. **Code style conventions** -- with concrete examples
5. **Git workflow requirements** -- commit messages, branch naming, PR process
6. **Explicit boundaries** -- always do, ask first, never do

### Key Finding: Command-First Architecture

Put relevant executable commands in an early section: `npm test`, `npm run build`, `pytest -v`, including flags and options. Agents reference these commands repeatedly during execution.

### Three-Tier Boundary Framework

The most effective agents employ:
- **Always do**: Specific permitted actions
- **Ask first**: Actions requiring approval
- **Never do**: Absolute prohibitions (secrets, vendor directories, production configs)

The single most common helpful constraint: **"Never commit secrets."**

### Code Examples Beat Explanations

One actual code snippet demonstrating expected output outperforms three paragraphs of description.

### Tech Stack Precision

Vague stacks ("React project") underperform. Successful files specify: "React 18 with TypeScript, Vite, and Tailwind CSS" with version numbers and key dependencies.

---

## 4. Cursor Rules

### Evolution: .cursorrules to .mdc

The legacy `.cursorrules` file is deprecated in favor of the `.cursor/rules/` directory with `.mdc` files. The legacy format still works.

**Source:** [Cursor Docs](https://docs.cursor.com/context/rules)

### .mdc Format Structure

Each rule file uses MDC (Markdown Components) format with frontmatter:

```yaml
---
description: When to apply this rule
globs: "**/*.ts"
alwaysApply: false
---

# Rule content in markdown
```

### Activation Modes

| Mode | Behavior |
|---|---|
| Always On | Loaded for every conversation |
| Auto Attached | Triggered by specific file type globs |
| Model Decision | AI determines relevance from description |
| Manual | Only via `@` mention |

### Directory Organization

```
.cursor/
  rules/
    cursor-rules.mdc      # Meta-rules
    general.mdc           # Project-wide standards
    frontend.mdc          # React conventions
    backend.mdc           # API patterns
```

### Best Practices

- Keep rules simple, concise, and specific
- Use bullet points, numbered lists, and markdown formatting
- Specific and actionable: "Use camelCase for variable names" not "Write clean code"
- Include error handling patterns with guard clauses
- Regularly update rules to reflect evolving practices

### Community Resources

The [awesome-cursorrules](https://github.com/PatrickJS/awesome-cursorrules) repository curates rules for 50+ frameworks including Angular, Next.js, React, Vue, FastAPI, Django, Flask, Rails, SwiftUI, Flutter, and more.

**Source:** [cursorrules.org](https://cursorrules.org/)

---

## 5. GitHub Copilot

### copilot-instructions.md

**Location:** `.github/copilot-instructions.md` for project-wide rules.

**Scoped instructions (2025+):** `.github/instructions/*.instructions.md` files with glob-pattern frontmatter:

```yaml
---
applyTo: "**/*.tsx"
---
# React Component Guidelines
...
```

### 5 Tips from GitHub Blog

1. **Give a project overview** -- elevator pitch: what the app is, audience, key features
2. **Identify the tech stack** -- backend, database, frontend, APIs, testing suites with specific details
3. **Spell out coding guidelines** -- formatting, type hints, testing requirements, security
4. **Explain project structure** -- directory layout with what each folder contains
5. **Point to available resources** -- scripts, tools, MCP servers for automation

**Source:** [GitHub Blog - 5 Tips](https://github.blog/ai-and-ml/github-copilot/5-tips-for-writing-better-custom-instructions-for-copilot/)

### Length Limit

Limit any single instruction file to approximately 1,000 lines. Beyond this, response quality deteriorates.

### Include Reasoning Behind Rules

"Use date-fns instead of moment.js because moment.js is deprecated and increases bundle size" -- when instructions explain WHY, the AI makes better edge-case decisions.

### Community Repository

[github/awesome-copilot](https://github.com/github/awesome-copilot) provides community-contributed instructions covering:
- Azure, AWS, Terraform, Bicep
- .NET, C#, Python, TypeScript, Clojure
- Accessibility, security, agent safety
- Azure DevOps, GitHub Actions, CMake

---

## 6. GEMINI.md

### Hierarchical Context Loading

1. **Global:** `~/.gemini/GEMINI.md` -- applies to all projects
2. **Project:** `GEMINI.md` files from current directory up to project root (`.git` folder)
3. **Subdirectory:** Files below current location, respecting `.gitignore`

All discovered files are concatenated and sent with every prompt.

### Management Commands

- `/memory show` -- displays concatenated context
- `/memory refresh` -- rescans and reloads files
- `/memory add <text>` -- appends to `~/.gemini/GEMINI.md`

### Features

- File imports with `@file.md` syntax (relative and absolute paths)
- Custom filenames via `settings.json` using `context.fileName`
- Footer counter shows active context file count

**Source:** [Gemini CLI Docs](https://google-gemini.github.io/gemini-cli/docs/cli/gemini-md.html)

---

## 7. Windsurf Rules

### Evolution

- **Legacy:** `.windsurfrules` in project root
- **Current (Wave 8+):** `.windsurf/rules/` directory with `.md` files

### Rule Types

- **Global rules:** `global_rules.md` applied across all workspaces
- **Workspace rules:** Tied to specific file patterns (globs) or natural language descriptions

### Constraints

- Individual rule files capped at 6,000 characters
- Total combined rules cannot exceed 12,000 characters

### Activation Modes

- Always On
- Manual (@mention)
- Model Decision

**Source:** [Windsurf Documentation](https://docs.windsurf.com/windsurf/cascade/memories)

---

## 8. Aider Conventions

Aider looks for coding conventions in `CONVENTIONS.md` by default but accepts any file via `--conventions-file`.

### Configuration

In `.aider.conf.yml`:
```yaml
conventions-file: CONVENTIONS.md
```

Or multiple files:
```yaml
conventions-file:
  - CONVENTIONS.md
  - AGENTS.md
```

### Impact

When guided by CONVENTIONS.md, GPT correctly used httpx and provided type hints; without it, GPT used requests and skipped types.

### Best Practices

- Aim for 150 lines or less
- Wrap commands in backticks for copy-paste accuracy
- One real code snippet beats three paragraphs
- Show pattern AND anti-pattern

**Source:** [Aider Docs](https://aider.chat/docs/usage/conventions.html) and [Aider-AI/conventions repository](https://github.com/Aider-AI/conventions)

---

## 9. Claude Code Skills System

### Overview

Skills extend Claude's capabilities beyond what CLAUDE.md provides. They are on-demand -- loaded only when relevant, rather than consuming context in every session.

**Key distinction:** CLAUDE.md is always loaded. Skills load on demand. Use CLAUDE.md for universal project conventions; use skills for domain knowledge and workflows that are only sometimes relevant.

### SKILL.md Structure

```yaml
---
name: my-skill
description: What this skill does and when to use it
argument-hint: [issue-number]
disable-model-invocation: false
user-invocable: true
allowed-tools: Read Grep Glob Bash
model: opus
effort: high
context: fork
agent: Explore
paths: "src/api/**"
---

# Skill instructions in markdown
...
```

### Frontmatter Fields

| Field | Purpose |
|---|---|
| `name` | Display name and /slash-command |
| `description` | When to invoke (250 char max before truncation) |
| `argument-hint` | Autocomplete hint for arguments |
| `disable-model-invocation` | Prevent automatic invocation |
| `user-invocable` | Hide from / menu if false |
| `allowed-tools` | Tools available without permission prompts |
| `model` | Model to use when active |
| `effort` | Override session effort level |
| `context` | Set to `fork` for isolated subagent execution |
| `agent` | Subagent type when `context: fork` |
| `paths` | Glob patterns limiting activation scope |

### Content Types

**Reference content:** Knowledge applied to current work (conventions, patterns, style guides). Runs inline alongside conversation context.

**Task content:** Step-by-step instructions for specific actions (deployments, commits, code generation). Often invoked with `disable-model-invocation: true`.

### Invocation Control Matrix

| Frontmatter | User Can Invoke | Claude Can Invoke |
|---|---|---|
| (default) | Yes | Yes |
| `disable-model-invocation: true` | Yes | No |
| `user-invocable: false` | No | Yes |

### Dynamic Context Injection

The `` !`<command>` `` syntax runs shell commands before skill content is sent to Claude:

```yaml
---
name: pr-summary
description: Summarize changes in a pull request
context: fork
agent: Explore
---
## Pull request context
- PR diff: !`gh pr diff`
- PR comments: !`gh pr view --comments`
```

### Skill Directory Structure

```
my-skill/
  SKILL.md           # Main instructions (required)
  template.md        # Template for Claude to fill in
  examples/
    sample.md        # Example output showing expected format
  scripts/
    validate.sh      # Script Claude can execute
```

### Where Skills Live

| Level | Path | Applies To |
|---|---|---|
| Enterprise | Managed settings | All org users |
| Personal | `~/.claude/skills/<name>/SKILL.md` | All your projects |
| Project | `.claude/skills/<name>/SKILL.md` | This project only |
| Plugin | `<plugin>/skills/<name>/SKILL.md` | Where plugin enabled |

**Source:** [Claude Code Skills Docs](https://code.claude.com/docs/en/skills)

---

## 10. Context Engineering Principles

### From Anthropic's Engineering Team

The fundamental principle: **"Find the smallest set of high-signal tokens that maximize the likelihood of desired outcomes."**

**Source:** [Anthropic - Effective Context Engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)

### Why Context Size Matters

LLMs operate under an "attention budget" constraint. As context windows grow:
- **Context rot:** degraded recall accuracy with increased token volume
- **Attention scarcity:** n-squared pairwise token relationships create computational strain
- **Position encoding challenges:** models trained on shorter sequences lose precision

### System Prompt Design: Finding the Right Altitude

**Anti-patterns:**
- Hardcoding complex, brittle if-else logic (creates fragility)
- Vague high-level guidance assuming shared context (fails to guide behavior)

**Best practice:** Specific enough to direct behavior, flexible enough to provide strong heuristics. Start with minimal prompts on your best model, then iteratively add clarity based on failure modes.

### Tool Design for Agents

- Clear contracts: unambiguous purpose
- Minimal overlap: avoid duplication causing decision paralysis
- Token efficiency: return information without verbosity
- Descriptive parameters: self-explanatory inputs

### Just-In-Time Retrieval

Agents maintain lightweight identifiers (file paths, URLs, queries) and dynamically load data at runtime. This mirrors human cognition -- maintaining organizational systems rather than memorizing everything.

Claude Code exemplifies hybrid strategy: CLAUDE.md loads initially; glob and grep enable just-in-time file discovery.

### Long-Horizon Task Management

Three strategies:
1. **Compaction:** Summarize conversations nearing limits; maximize recall first, then precision
2. **Structured Note-Taking:** Persistent memory outside context window (NOTES.md files)
3. **Sub-Agent Architectures:** Specialized agents with clean context windows returning condensed summaries

### From Martin Fowler's Team

Context for coding agents falls into three categories:

**Reusable Prompts (Markdown Files):**
- Instructions: "Write an E2E test in the following way..."
- Guidance/rules: "Always write tests that are independent of each other."

**Context Interfaces:**
- Tools (bash, file operations)
- MCP Servers (APIs, databases)
- Skills (on-demand documentation and scripts)

**Workspace Files:**
- Code readability and structure IS context
- "AI-friendly codebase design" maximizes natural context

### Decision Architecture: Who Loads Context?

| Method | Who Decides | Example |
|---|---|---|
| LLM-Driven | Agent decides when to load | Skills |
| Human-Triggered | Developer explicitly invokes | Slash commands |
| Software-Determined | Lifecycle events trigger | Hooks |

### The "Illusion of Control" Caveat

Despite terminology suggesting certainty, "we can never be certain of anything" with LLMs involved. Think in probabilities. Context engineering significantly increases probability of useful results but requires appropriate human oversight.

**Source:** [Martin Fowler - Context Engineering for Coding Agents](https://martinfowler.com/articles/exploring-gen-ai/context-engineering-coding-agents.html)

---

## 11. ETH Zurich Research: What Actually Works

### Study Overview

Researchers built AGENTbench: 138 real-world Python tasks from niche repositories, testing Claude 3.5 Sonnet, Codex GPT-5.2, GPT-5.1 mini, and Qwen Code across three conditions: no context file, LLM-generated file, and human-written file.

**Source:** [InfoQ Coverage](https://www.infoq.com/news/2026/03/agents-context-file-value-review/) and [arxiv paper](https://arxiv.org/html/2602.11988v1)

### Key Findings

**LLM-generated files HURT performance:**
- Reduced task success rate by average of 3%
- Increased agent steps taken
- Increased inference costs by over 20%

**Human-written files only marginally help:**
- Average 4% increase in task success rate
- Paradoxically increased steps and costs by up to 19%
- Architectural overviews did NOT help agents locate relevant files faster

### Why Performance Degraded

Agents "generally followed the instructions" but this led to **unnecessary thoroughness**: more testing and broader exploration without improving outcomes. Extra context forced reasoning without yielding better solutions.

### Recommendations

1. **Omit LLM-generated context files entirely** (e.g., don't use `/init` without heavy editing)
2. **Limit human-written instructions to non-inferable details**: highly specific tooling, custom build commands, non-obvious gotchas
3. The practical test: **"Can the agent discover this on its own by reading your code? If yes, delete it."**

### The Addy Osmani Insight

"Coding agents aren't new hires. They can grep the entire codebase before you finish typing your prompt. What they need isn't a map. They need to know where the landmines are."

**What auto-generated content produces vs what actually earns inclusion:**

| Auto-Generated (Delete) | Actually Useful (Keep) |
|---|---|
| Directory structure | Tool requirements (`uv` for packages) |
| Tech stack overview | Non-obvious conventions and gotchas |
| Module explanations | Warnings about deprecated code sections |
| Standard architectural patterns | Custom middleware that differs from standard |
| Anything in README or config files | Build commands with non-standard flags |

**Source:** [Addy Osmani - Stop Using /init for AGENTS.md](https://addyosmani.com/blog/agents-md/)

### Lulla et al. Contrasting Study

Found that AGENTS.md files reduced runtime by 28.64% and token consumption by 16.58% -- **but only when human-authored**. This confirms: hand-crafted beats auto-generated.

---

## 12. Anti-Patterns and Common Mistakes

### The Top Anti-Patterns

#### 1. Over-Specified CLAUDE.md
**Problem:** If your CLAUDE.md is too long, Claude ignores half of it because important rules get lost in the noise.
**Fix:** Ruthlessly prune. If Claude already does something correctly without the instruction, delete it or convert it to a hook.

#### 2. Using Agent Config as a Linter
**Problem:** "Never send an LLM to do a linter's job." Code style guidelines waste tokens and context. LLMs are comparably expensive and incredibly slow compared to traditional linters.
**Fix:** Use Biome, ESLint, Prettier for style enforcement. Optionally set up hooks that run formatters and present errors for Claude to fix.

#### 3. Auto-Generating Without Refinement
**Problem:** `/init` produces generic, bloated content. CLAUDE.md is the highest leverage point.
**Fix:** Carefully hand-craft each line. Start from `/init` output but ruthlessly edit.

#### 4. Kitchen Sink Sessions
**Problem:** Starting with one task, asking something unrelated, going back. Context fills with irrelevant information.
**Fix:** `/clear` between unrelated tasks.

#### 5. Correcting Over and Over
**Problem:** Claude does something wrong, you correct, it's still wrong, you correct again. Context polluted with failed approaches.
**Fix:** After two failed corrections, `/clear` and write a better initial prompt incorporating what you learned.

#### 6. Trust-Then-Verify Gap
**Problem:** Claude produces plausible-looking implementation that doesn't handle edge cases.
**Fix:** Always provide verification (tests, scripts, screenshots). If you can't verify it, don't ship it.

#### 7. Infinite Exploration
**Problem:** Asking Claude to "investigate" without scoping. Claude reads hundreds of files, filling context.
**Fix:** Scope narrowly or use subagents so exploration doesn't consume main context.

#### 8. Static Monolithic Files
**Problem:** A single AGENTS.md cannot adapt to different task types. Performance optimization hints matter for backend work but waste tokens on CSS refactoring.
**Fix:** Use hierarchical/path-scoped files, skills, or rules with activation conditions.

#### 9. Anchoring Effect
**Problem:** Including tools or patterns in config creates cognitive bias. If your file mentions tRPC despite limited modern use, the model treats legacy information equally to current practices.
**Fix:** Remove outdated references. Keep only current, actively-used patterns.

#### 10. Duplicating Discoverable Information
**Problem:** Including directory structure, tech stack overviews, module explanations that the agent can find by reading package.json, README, or running `ls`.
**Fix:** Only include what the agent CANNOT discover on its own.

### What Makes Files Fail (from 2500-repo Analysis)

- Generic personas without specialized focus
- Missing executable commands or command flags
- Abstract style guidance without concrete examples
- Unclear file system permissions
- No distinction between "ask first" and "never do"
- Omitting project-specific tech stack versions
- Vague stacks like "React project" instead of "React 18 with TypeScript 5.4, Vite 5.2, Tailwind CSS 3.4"

---

## 13. Real-World Examples and Repositories

### Curated Collections

**awesome-claude-md** ([josix/awesome-claude-md](https://github.com/josix/awesome-claude-md))
Curated collection of exemplary CLAUDE.md files from leading open-source projects including:
- **OpenAI Agents Python** - Industry-standard agent coordination patterns
- **Basic Memory** - MCP integration with FastAPI and SQLAlchemy
- **Overreacted.io (Dan Abramov)** - Technical depth with personality, Next.js + MDX
- **Pydantic GenAI Prices** - Expert data processing pipeline patterns
- **Anthropic Quickstarts** - Multi-project Python/TypeScript/React examples
- **Cloudflare Workers SDK** - Monorepo and testing excellence patterns
- **Citadel Protocol** - Security-focused DeFi documentation

**awesome-claude-code** ([hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code))
Skills, hooks, slash-commands, agent orchestrators, applications, and plugins for Claude Code.

**awesome-cursorrules** ([PatrickJS/awesome-cursorrules](https://github.com/PatrickJS/awesome-cursorrules))
Configuration files for 50+ frameworks: Angular, Next.js, React, Vue, FastAPI, Django, Flask, Rails, SwiftUI, Flutter, Solidity, Kubernetes, and more.

**awesome-copilot** ([github/awesome-copilot](https://github.com/github/awesome-copilot))
Community-contributed instructions for Azure, .NET, C#, Python, TypeScript, accessibility, security, and more.

**awesome-agents-md** ([Ischca/awesome-agents-md](https://github.com/Ischca/awesome-agents-md))
Real-world AGENTS.md files, templates, and guides for OpenAI Codex-based agents.

**awesome-agent-skills** ([VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills))
1000+ agent skills from official dev teams (Anthropic, Google Labs, Vercel, Stripe, Cloudflare, Netlify, Sentry, Expo, Hugging Face, Figma).

### Notable Individual Examples

- **SteadyStart** by steadycursor: Clear style, permissions, Claude's role, communications, documentation directives
- **Basic Memory** by basicmachines-co: AI-human collaboration framework with MCP for bidirectional LLM-markdown communication
- **Meridian**: Zero-config Claude Code setup with enforced task scaffolding, structured memory, persistent context after compaction
- **ClaudeForge**: CLAUDE.md generator aligned with Anthropic best practices

### Recommended Agent Personas (from GitHub Blog)

- **@docs-agent**: Reads source code; generates API docs to `docs/` only; validates with markdownlint
- **@test-agent**: Writes comprehensive tests; executes test commands; forbidden from removing failing tests
- **@lint-agent**: Auto-fixes formatting and style; never modifies code logic
- **@api-agent**: Creates endpoints; modifies routes freely; requires approval for schema changes
- **@dev-deploy-agent**: Restricted to dev builds; requires approval for risky operations

---

## 14. Templates and Frameworks

### Basic Template (from gradually.ai)

```markdown
# [Project Name]

[One-sentence project description]

## Tech Layers
- **Framework**: [e.g., Next.js, React, Vue]
- **Language**: [e.g., TypeScript, Python]
- **Database**: [e.g., PostgreSQL, MongoDB]
- **Styling**: [e.g., Tailwind, CSS Modules]
- **Testing**: [e.g., Jest, Vitest, Pytest]

## Project Structure
src/
  [important folder]/   # [Description]
  [another folder]/     # [Description]
  [config files]        # [Description]

## Development
[install command]        # Install dependencies
[dev command]           # Development server
[build command]         # Production build
[test command]          # Run tests

## Code Standards
- [Standard 1, e.g., "TypeScript strict mode"]
- [Standard 2, e.g., "Follow ESLint rules"]

## Project-Specific Rules
- [Rule 1, e.g., "API calls only via services/"]
- [Rule 2, e.g., "Styling only with Tailwind"]

## Common Mistakes to Avoid
- DON'T: [Common mistake]
- ALWAYS: [Best practice]
```

### Six-Level Capability Framework (from DEV Community)

A maturity model for agent configuration:

| Level | Name | Description |
|---|---|---|
| L0 | Absent | No instruction file exists |
| L1 | Basic | File exists and is version-controlled; may contain `/init` boilerplate |
| L2 | Scoped | Explicit MUST/MUST NOT constraints using RFC 2119 language |
| L3 | Structured | Multiple referenced files organized by concern |
| L4 | Abstracted | Path-scoped rule loading (different rules for different directories) |
| L5 | Maintained | L4 + active upkeep, backbone file mapping, staleness tracking |
| L6 | Adaptive | Skills directory, MCP servers, dynamic capability loading |

**Distribution:** Most setups cluster at L1-L2. Some reach L3. L4+ is rare -- not due to difficulty, but pattern visibility.

**Source:** [DEV Community - CLAUDE.md From Basic to Adaptive](https://dev.to/cleverhoods/claudemd-best-practices-from-basic-to-adaptive-9lm)

### Ruflo Wiki Template System

Comprehensive templates organized by:
- **Project type:** Web, Mobile, API, AI/ML, Data Science, DevOps
- **Architecture:** Microservices, Monolithic, Serverless, Containerized
- **Methodology:** TDD, Agile/Scrum, DDD, CI/CD Focused
- **Language/Framework:** JS/Node, Python, Java/Spring, React/Next, TypeScript, Rust
- **Organization size:** Solo, Small (2-5), Medium (6-20), Enterprise (20+)

Universal template sections:
1. CRITICAL RULES
2. PROJECT CONTEXT
3. DEVELOPMENT PATTERNS
4. SWARM ORCHESTRATION
5. MEMORY MANAGEMENT
6. DEPLOYMENT & CI/CD
7. MONITORING & ANALYTICS
8. SECURITY & COMPLIANCE

**Source:** [Ruflo Wiki](https://github.com/ruvnet/ruflo/wiki/CLAUDE-MD-Templates)

---

## 15. Cross-Tool Strategy

### Recommended Multi-Tool Directory Layout

```
your-project/
  AGENTS.md                              # Universal instructions (widest support)
  CLAUDE.md                              # Claude-specific additions (optional)
  .github/
    copilot-instructions.md             # Copilot-specific (optional)
    instructions/
      react.instructions.md             # Scoped by file type
  .cursor/
    rules/
      general.mdc                       # Cursor-specific rules
      frontend.mdc
      backend.mdc
  .windsurf/
    rules/
      rules.md                          # Windsurf-specific
  .gemini/
    GEMINI.md                           # Gemini-specific
  .claude/
    skills/
      api-conventions/SKILL.md          # On-demand Claude skills
      fix-issue/SKILL.md
    agents/
      security-reviewer.md             # Custom subagents
```

### Pragmatic Recommendation

1. **Start with AGENTS.md** as your universal baseline (widest cross-tool support)
2. **Add CLAUDE.md** when you need Claude-specific features (@imports, skills integration)
3. **Keep overlap minimal** between tool-specific files
4. **If using only Claude Code**, CLAUDE.md alone is sufficient
5. **Rule-porter tool** exists to convert `.mdc` rules to CLAUDE.md, AGENTS.md, or Copilot format

### Convergence Trend

The industry is converging on "markdown file at project root." AGENTS.md has the best name for convergence because it's vendor-neutral. But the content principles are universal regardless of filename.

---

## 16. Key Takeaways for UltraContext

### The Most Important Findings

1. **Less is more -- dramatically so.** The ETH Zurich research proves that bloated config files actively hurt performance. Auto-generated files reduce success rates. Every line must earn its place.

2. **Only include what agents CANNOT discover.** The test: "Can the agent find this by reading your code?" If yes, delete it. Agents need to know where the landmines are, not a map of the territory.

3. **Commands and examples beat prose.** One code snippet showing your style outperforms three paragraphs describing it. Executable commands with full flags are the single most valuable content.

4. **Three-tier boundaries are essential.** Always do / Ask first / Never do. This framework appears across every successful implementation.

5. **Progressive disclosure is the winning architecture.** Root file provides orientation. Subdirectory files provide scoped details. Skills provide on-demand knowledge. This mirrors how human memory works.

6. **Use deterministic tools for deterministic tasks.** Don't use LLMs for linting, formatting, or style enforcement. Use hooks and scripts. Reserve agent config for things only an LLM can do.

7. **Emphasis language matters.** "MUST use TypeScript strict mode" enforces behavior. "Prefer TypeScript" suggests optional behavior. RFC 2119 language significantly improves compliance.

8. **Context is a finite, precious resource.** Anthropic's own guidance centers everything on this: the context window fills fast, and performance degrades as it fills. Every token in CLAUDE.md competes with the actual task.

9. **Hand-crafted beats auto-generated.** The Lulla study showed 28% runtime reduction and 16% token savings -- but only with human-authored files. ETH Zurich showed LLM-generated files hurt. Invest the human effort.

10. **Iterate based on observed failures.** Don't try to be comprehensive upfront. Start minimal, observe Claude's mistakes, add instructions that prevent those specific mistakes. Treat config like code: review it when things go wrong, prune regularly.

### What UltraContext's Skill Should Generate

Based on this research, an ideal agent configuration generator should:

1. **Analyze the codebase** for non-inferable information only (custom build commands, unusual patterns, gotchas)
2. **Keep output under 200 lines** with a preference for under 100
3. **Lead with executable commands** (build, test, lint, deploy) including full flags
4. **Show code examples** rather than describe patterns in prose
5. **Include three-tier boundaries** (always/ask/never)
6. **Support progressive disclosure** -- root orientation pointing to detailed docs elsewhere
7. **Use imperative/RFC 2119 language** for rules
8. **Exclude what agents can discover** -- no directory trees, no standard patterns, no README duplication
9. **Support multiple output formats** -- CLAUDE.md, AGENTS.md, .cursorrules/.mdc, copilot-instructions.md
10. **Provide a quality scoring/audit system** based on the L0-L6 maturity framework

---

## Sources

### Official Documentation
- [Anthropic - Best Practices for Claude Code](https://code.claude.com/docs/en/best-practices)
- [Anthropic - Effective Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [Anthropic - Claude Code Skills](https://code.claude.com/docs/en/skills)
- [AGENTS.md Specification](https://agents.md/)
- [Cursor Rules Documentation](https://docs.cursor.com/context/rules)
- [GitHub Copilot Custom Instructions](https://copilot-instructions.md/)
- [Gemini CLI - GEMINI.md](https://google-gemini.github.io/gemini-cli/docs/cli/gemini-md.html)
- [Windsurf Cascade Memories](https://docs.windsurf.com/windsurf/cascade/memories)
- [Aider Conventions](https://aider.chat/docs/usage/conventions.html)

### Research and Analysis
- [GitHub Blog - How to Write a Great agents.md (2500 repos)](https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/)
- [ETH Zurich - Evaluating AGENTS.md (InfoQ)](https://www.infoq.com/news/2026/03/agents-context-file-value-review/)
- [ETH Zurich - arxiv paper](https://arxiv.org/html/2602.11988v1)
- [Martin Fowler - Context Engineering for Coding Agents](https://martinfowler.com/articles/exploring-gen-ai/context-engineering-coding-agents.html)
- [Addy Osmani - Stop Using /init for AGENTS.md](https://addyosmani.com/blog/agents-md/)

### Best Practices and Guides
- [HumanLayer - Writing a Good CLAUDE.md](https://www.humanlayer.dev/blog/writing-a-good-claude-md)
- [DEV Community - CLAUDE.md From Basic to Adaptive](https://dev.to/cleverhoods/claudemd-best-practices-from-basic-to-adaptive-9lm)
- [gradually.ai - How to Create the Perfect CLAUDE.md](https://www.gradually.ai/en/claude-md/)
- [Builder.io - How to Write a Good CLAUDE.md File](https://www.builder.io/blog/claude-md-guide)
- [GitHub Blog - 5 Tips for Copilot Instructions](https://github.blog/ai-and-ml/github-copilot/5-tips-for-writing-better-custom-instructions-for-copilot/)
- [DeployHQ - Every AI Config File Explained](https://www.deployhq.com/blog/ai-coding-config-files-guide)
- [ranthebuilder - Claude Code Best Practices from Real Projects](https://ranthebuilder.cloud/blog/claude-code-best-practices-lessons-from-real-projects/)

### Community Collections
- [josix/awesome-claude-md](https://github.com/josix/awesome-claude-md) - Exemplary CLAUDE.md files
- [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) - Claude Code resources
- [PatrickJS/awesome-cursorrules](https://github.com/PatrickJS/awesome-cursorrules) - Cursor rules for 50+ frameworks
- [github/awesome-copilot](https://github.com/github/awesome-copilot) - Copilot custom instructions
- [Ischca/awesome-agents-md](https://github.com/Ischca/awesome-agents-md) - AGENTS.md examples
- [VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills) - 1000+ agent skills
- [ruvnet/ruflo Wiki](https://github.com/ruvnet/ruflo/wiki/CLAUDE-MD-Templates) - CLAUDE.md template system
- [Aider-AI/conventions](https://github.com/Aider-AI/conventions) - Community convention files
- [cursorrules.org](https://cursorrules.org/) - Cursor rules generator
- [shanraisshan/claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice) - Reference implementation
