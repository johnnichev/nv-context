# Advanced CLAUDE.md Patterns & Context Engineering Research

**Date**: 2026-04-04
**Research Scope**: Elite-level CLAUDE.md configurations, hooks, skills, subagents, workflows, and context engineering patterns from the most advanced practitioners in the wild.

---

## Table of Contents

1. [The Boris Cherny Workflow (Creator of Claude Code)](#1-the-boris-cherny-workflow)
2. [CLAUDE.md Structure & Architecture](#2-claudemd-structure--architecture)
3. [Progressive Disclosure Pattern](#3-progressive-disclosure-pattern)
4. [Path-Specific Rules (.claude/rules/)](#4-path-specific-rules)
5. [Skills System Deep Dive](#5-skills-system-deep-dive)
6. [Hooks System Deep Dive](#6-hooks-system-deep-dive)
7. [Custom Subagents](#7-custom-subagents)
8. [Agent Teams (Experimental)](#8-agent-teams)
9. [Worktree & Parallel Execution Patterns](#9-worktree--parallel-execution-patterns)
10. [Spec-Driven Development & Plan Mode](#10-spec-driven-development--plan-mode)
11. [Compounding Engineering Pattern](#11-compounding-engineering-pattern)
12. [Python Library Development Patterns](#12-python-library-development-patterns)
13. [Monorepo Patterns](#13-monorepo-patterns)
14. [Real-World CLAUDE.md Examples](#14-real-world-claudemd-examples)
15. [Elite Practitioner Insights](#15-elite-practitioner-insights)
16. [Key Takeaways & Synthesis](#16-key-takeaways--synthesis)

---

## 1. The Boris Cherny Workflow

**Source**: [howborisusesclaudecode.com](https://howborisusesclaudecode.com/), Boris Cherny's Threads posts, [HN discussion](https://news.ycombinator.com/item?id=46407967)

Boris Cherny created Claude Code as a side project in September 2024. In 30 days he landed **259 PRs, 497 commits, 40k lines added, 38k lines removed** -- every single line written by Claude Code + Opus 4.5.

### Core Parallel Execution Strategy

- Runs **5 simultaneous Claude instances** in numbered terminal tabs (1-5)
- Additionally runs **5-10 sessions on claude.ai/code**
- Initiates sessions from **iPhone via Claude iOS app** in mornings, resuming on desktop
- Uses `--teleport` flag to move sessions between devices

### Model & Reasoning

- Exclusively uses **Opus 4.5 with thinking mode** for everything
- Rationale: superior tool use and reduced steering requirements make it faster overall despite higher token costs
- Uses `/effort max` for deepest reasoning

### CLAUDE.md Approach

- Team maintains a **shared CLAUDE.md checked into git**, updated multiple times weekly
- During code reviews, tags `@.claude` on PRs to **auto-append learnings** via GitHub Action
- This implements **"Compounding Engineering"** -- each correction becomes permanent context
- Example content: `"Always use bun, not npm. Before creating PRs, run lint and tests."`
- **Surprisingly vanilla** -- Boris doesn't over-customize; Claude Code works well out of the box

### Workflow Patterns

1. **Plan Mode First**: Complex tasks start with `Shift+Tab` twice to enter plan mode. Iterates until solid, then switches to auto-accept mode. Foundation for successful 1-shot implementations.
2. **Slash Commands**: Custom commands in `.claude/commands/` include `/commit-push-pr`. Commands support inline Bash for pre-computation.
3. **Subagents**: code-simplifier, verify-app, oncall-guide, build-validator, code-architect
4. **Verification**: 2-3x quality improvement. Uses Chrome extension for frontend, test suites for backend.

### Hooks Configuration

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "bun run format || true"
          }
        ]
      }
    ]
  }
}
```

Additional hooks: SessionStart (dynamic context loading), PermissionRequest (route approvals), Stop (nudge continuation), PostCompact (re-inject critical instructions).

### Permissions (NOT --dangerously-skip-permissions)

Pre-allows safe commands via `/permissions`:
```
Bash(bun run build:*), Bash(bun run test:*), Bash(gh pr checks:*), Edit(/docs/**)
```

### Tool Integrations (MCP)

- Slack MCP for searching/posting messages
- BigQuery CLI for analytics (hasn't written SQL in 6+ months)
- Sentry for error log retrieval

### Advanced Features

- **Git Worktrees**: `claude --worktree feature-name` for parallel isolation
- **Custom Agents**: `.claude/agents/ReadOnly.md` with custom name, color, tool set
- **Voice Mode**: Primary coding method, 3x faster prompts via dictation
- **Auto Mode** (`--enable-auto-mode`): Safety classifiers auto-approve safe operations
- **`/simplify`**: Runs parallel quality-improvement agents
- **`/batch`**: Executes code migrations via dozens of isolated worktree agents
- **`/loop`**: Schedule recurring tasks up to 3 days unattended
- **`/btw`**: Mid-task side-chain questions without interrupting work
- **`--bare` flag**: 10x faster SDK startup by skipping discovery
- **`--add-dir`**: Grant access to additional repositories

### Skills Framework (9 Types)

1. Library & API Reference
2. Product Verification
3. Data & Analysis
4. Business Automation
5. Scaffolding & Templates
6. Code Quality & Review
7. CI/CD & Deployment
8. Incident Runbooks
9. Infrastructure Ops

---

## 2. CLAUDE.md Structure & Architecture

### Official Anthropic Best Practices

**Source**: [code.claude.com/docs/en/best-practices](https://code.claude.com/docs/en/best-practices)

#### The Single Most Important Constraint

> Most best practices are based on one constraint: **Claude's context window fills up fast, and performance degrades as it fills.**

#### What To Include vs Exclude

| Include | Exclude |
|---------|---------|
| Bash commands Claude can't guess | Anything Claude can figure out by reading code |
| Code style rules that differ from defaults | Standard language conventions Claude already knows |
| Testing instructions and preferred test runners | Detailed API documentation (link instead) |
| Repository etiquette (branch naming, PR conventions) | Information that changes frequently |
| Architectural decisions specific to your project | Long explanations or tutorials |
| Developer environment quirks (required env vars) | File-by-file descriptions of the codebase |
| Common gotchas or non-obvious behaviors | Self-evident practices like "write clean code" |

#### Emphasis Techniques

- Add emphasis with `IMPORTANT` or `YOU MUST` to improve adherence
- Check CLAUDE.md into git for team contribution
- The file compounds in value over time
- Treat CLAUDE.md like code: review when things go wrong, prune regularly

#### The Pruning Test

For each line ask: *"Would removing this cause Claude to make mistakes?"* If not, cut it.

#### @imports Syntax

```markdown
See @README.md for project overview and @package.json for available npm commands.

# Additional Instructions
- Git workflow: @docs/git-instructions.md
- Personal overrides: @~/.claude/my-project-instructions.md
```

#### File Locations (Priority Order)

1. `~/.claude/CLAUDE.md` -- applies to all sessions
2. `./CLAUDE.md` -- project root, check into git
3. `./CLAUDE.local.md` -- personal project notes (gitignored)
4. Parent directories -- monorepo hierarchical loading
5. Child directories -- loaded on-demand when working in subdirectories

### The HumanLayer Analysis

**Source**: [humanlayer.dev/blog/writing-a-good-claude-md](https://www.humanlayer.dev/blog/writing-a-good-claude-md)

#### Three Onboarding Dimensions

- **WHAT**: Technical stack, project structure, codebase architecture
- **WHY**: Project purpose and rationale for components
- **HOW**: Practical execution instructions (package managers, verification, tests)

#### The Attention Problem

Claude Code's harness includes this system reminder:
> "IMPORTANT: this context may or may not be relevant to your tasks. You should not respond to this context unless it is highly relevant to your task."

Claude **selectively ignores** instructions deemed irrelevant. This means bloated files cause important rules to be skipped.

#### Instruction Capacity

> Frontier thinking LLMs can follow approximately **150-200 instructions** with reasonable consistency.

Claude Code's system prompt already uses ~50 instructions, leaving ~100-150 for your CLAUDE.md.

#### Key Recommendations

1. **Never use `/init`** -- manually craft each line (highest leverage point)
2. **Never send an LLM to do a linter's job** -- use Stop hooks with formatters
3. **Reference with pointers, not @imports** -- "For complex usage, see path/to/docs.md" instead of embedding entire files
4. **Keep under 60 lines** (HumanLayer's own file) to 300 lines (community consensus)

---

## 3. Progressive Disclosure Pattern

**Source**: [alexop.dev/posts/stop-bloating-your-claude-md-progressive-disclosure-ai-coding-tools](https://alexop.dev/posts/stop-bloating-your-claude-md-progressive-disclosure-ai-coding-tools/)

### Three-Layer Architecture

#### Layer 1: CLAUDE.md (Always Loaded) -- ~50 lines (~500 tokens)

Contents:
- Project overview (2-3 sentences)
- Essential commands (`pnpm dev`, `pnpm lint:fix`, `pnpm typecheck`)
- Stack summary (framework versions)
- Directory structure
- **Critical instruction**: "Before starting any task, identify which docs below are relevant and read them first."

**Rule**: Only include universal context. No style rules, no testing conventions, no formatting.

#### Layer 2: `/docs` Files (On-Demand) -- 200-500 tokens per file

Situational knowledge loaded when referenced:
- `nuxt-content-gotchas.md` -- Non-obvious framework behaviors
- `testing-strategy.md` -- When to use which test type
- `SYSTEM_KNOWLEDGE_MAP.md` -- Architecture overview

**Critical pattern**: Without explicit "read these first" instruction, Claude won't automatically consult these files.

#### Layer 3: `.claude/agents` (Specialized Contexts) -- 300-800 tokens per agent

Domain specialists loaded only when needed:
- `nuxt-content-specialist.md`
- `nuxt-ui-specialist.md`
- `vue-specialist.md`

Agents fetch official documentation dynamically via `llms.txt`.

### The `/learn` Skill Pattern

Implements continuous learning feedback loop:
1. Claude struggles with something previously solved
2. Run `/learn` skill
3. Skill analyzes conversation for reusable, non-obvious insights
4. Proposes placement in `/docs` (new file or existing)
5. Requests approval before saving
6. Next session: Claude reads relevant doc before working

Over time, `/docs` becomes a curated knowledge base of exactly what AI tools get wrong in your codebase.

### Skills Activation Reliability Warning

> Vercel's evals found skills achieved only **79% pass rate** vs 100% for docs embedded in AGENTS.md. Skills performed no better than baseline when left to trigger naturally.

**Recommendation**: Use explicit pointers in CLAUDE.md rather than relying on skill triggers.

### Cross-Tool Compatibility

```bash
ln -s CLAUDE.md agents.md
```

Both Claude Code and Cursor read the same configuration.

---

## 4. Path-Specific Rules

**Source**: [code.claude.com/docs/en/memory](https://code.claude.com/docs/en/memory), community reports

### .claude/rules/ Directory

Markdown files in `.claude/rules/` provide modular organization:

```
.claude/rules/
  api-conventions.md
  frontend-patterns.md
  database-rules.md
  testing-standards.md
```

### Path Frontmatter

Rules can be scoped to specific files using YAML frontmatter:

```yaml
---
paths:
  - "src/api/**/*.ts"
  - "lib/**/*.ts"
---
# API Development Rules

Use RESTful naming conventions...
```

### Key Behaviors

- Rules **without** `paths` frontmatter are loaded at launch (same priority as CLAUDE.md)
- Path-scoped rules trigger when Claude **reads** files matching the pattern
- The `.claude/rules/` directory supports symlinks for shared rules

### Current Limitation

Path-based rules are only injected into context when Claude reads a file matching the pattern -- **not when writing/creating** a file matching the same pattern.

---

## 5. Skills System Deep Dive

**Source**: [code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills)

### Anatomy of a Skill

```
my-skill/
  SKILL.md           # Main instructions (required)
  template.md        # Template for Claude to fill in
  examples/
    sample.md        # Example output
  scripts/
    validate.sh      # Script Claude can execute
```

### Frontmatter Reference

| Field | Description |
|-------|-------------|
| `name` | Display name, becomes `/slash-command` |
| `description` | Tells Claude when to use it (front-load key use case, <250 chars) |
| `argument-hint` | Autocomplete hint: `[issue-number]` |
| `disable-model-invocation` | `true` = only user can invoke (for side-effect workflows) |
| `user-invocable` | `false` = hidden from `/` menu (background knowledge) |
| `allowed-tools` | Tools without permission prompts when skill is active |
| `model` | Model override when skill is active |
| `effort` | Effort level override (`low`, `medium`, `high`, `max`) |
| `context` | `fork` = run in subagent isolation |
| `agent` | Subagent type for `context: fork` (`Explore`, `Plan`, custom) |
| `hooks` | Hooks scoped to skill lifecycle |
| `paths` | Glob patterns limiting when skill activates |
| `shell` | `bash` (default) or `powershell` |

### Dynamic Context Injection

The `` !`command` `` syntax runs shell commands before skill content is sent:

```yaml
---
name: pr-summary
description: Summarize changes in a pull request
context: fork
agent: Explore
allowed-tools: Bash(gh *)
---

## Pull request context
- PR diff: !`gh pr diff`
- PR comments: !`gh pr view --comments`
- Changed files: !`gh pr diff --name-only`

## Your task
Summarize this pull request...
```

### String Substitutions

| Variable | Description |
|----------|-------------|
| `$ARGUMENTS` | All arguments when invoking |
| `$ARGUMENTS[N]` | Specific argument by index |
| `$N` | Shorthand for `$ARGUMENTS[N]` |
| `${CLAUDE_SESSION_ID}` | Current session ID |
| `${CLAUDE_SKILL_DIR}` | Directory containing SKILL.md |

### Bundled Skills

| Skill | Purpose |
|-------|---------|
| `/batch <instruction>` | Large-scale parallel changes across codebase in worktrees |
| `/claude-api` | Load API reference for project language |
| `/debug [description]` | Enable debug logging and troubleshoot |
| `/loop [interval] <prompt>` | Run prompt repeatedly on interval |
| `/simplify [focus]` | Three parallel review agents for reuse/quality/efficiency |

### Invocation Control Matrix

| Frontmatter | You invoke | Claude invokes | When loaded |
|-------------|-----------|----------------|-------------|
| (default) | Yes | Yes | Description always, full on invoke |
| `disable-model-invocation: true` | Yes | No | Not in context until you invoke |
| `user-invocable: false` | No | Yes | Description always, full on invoke |

### Skills Discovery

Skills from nested `.claude/skills/` directories are auto-discovered. In a monorepo, `packages/frontend/.claude/skills/` is found when editing files in `packages/frontend/`.

### Pro Tip

> To enable extended thinking in a skill, include the word "ultrathink" anywhere in your skill content.

---

## 6. Hooks System Deep Dive

**Source**: [code.claude.com/docs/en/hooks-guide](https://code.claude.com/docs/en/hooks-guide), [code.claude.com/docs/en/hooks](https://code.claude.com/docs/en/hooks)

### Complete Hook Event Catalog

| Event | When it fires | Matcher filters |
|-------|---------------|-----------------|
| `SessionStart` | Session begins/resumes | `startup`, `resume`, `clear`, `compact` |
| `UserPromptSubmit` | Before prompt processing | No matcher |
| `PreToolUse` | Before tool execution | Tool name: `Bash`, `Edit\|Write`, `mcp__.*` |
| `PermissionRequest` | Permission dialog appears | Tool name |
| `PermissionDenied` | Auto mode classifier denies | Tool name |
| `PostToolUse` | After tool succeeds | Tool name |
| `PostToolUseFailure` | After tool fails | Tool name |
| `Notification` | Claude sends notification | `permission_prompt`, `idle_prompt`, `auth_success` |
| `SubagentStart` | Subagent spawned | Agent type |
| `SubagentStop` | Subagent finishes | Agent type |
| `TaskCreated` | Task created via TaskCreate | No matcher |
| `TaskCompleted` | Task marked complete | No matcher |
| `Stop` | Claude finishes responding | No matcher |
| `StopFailure` | Turn ends due to API error | Error type |
| `TeammateIdle` | Agent team teammate going idle | No matcher |
| `InstructionsLoaded` | CLAUDE.md/.claude/rules loaded | Load reason |
| `ConfigChange` | Config file changes during session | Config source |
| `CwdChanged` | Working directory changes | No matcher |
| `FileChanged` | Watched file changes on disk | Filename |
| `WorktreeCreate` | Worktree being created | No matcher |
| `WorktreeRemove` | Worktree being removed | No matcher |
| `PreCompact` | Before context compaction | `manual`, `auto` |
| `PostCompact` | After compaction completes | `manual`, `auto` |
| `Elicitation` | MCP server requests input | MCP server name |
| `ElicitationResult` | After user responds to MCP | MCP server name |
| `SessionEnd` | Session terminates | Reason |

### Hook Types

1. **`"type": "command"`** -- Shell command (most common)
2. **`"type": "http"`** -- POST to HTTP endpoint
3. **`"type": "prompt"`** -- Single-turn LLM evaluation (Haiku default)
4. **`"type": "agent"`** -- Multi-turn subagent verification with tool access

### Exit Code Semantics

- **Exit 0**: Action proceeds. Stdout added to context for UserPromptSubmit/SessionStart.
- **Exit 2**: Action blocked. Stderr becomes Claude's feedback.
- **Other**: Action proceeds. Stderr logged but not shown.

### Most Impactful Hook Patterns

#### Auto-format after edits (Boris Cherny pattern)
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.file_path' | xargs npx prettier --write"
          }
        ]
      }
    ]
  }
}
```

#### Block protected files
```bash
#!/bin/bash
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
PROTECTED_PATTERNS=(".env" "package-lock.json" ".git/")
for pattern in "${PROTECTED_PATTERNS[@]}"; do
  if [[ "$FILE_PATH" == *"$pattern"* ]]; then
    echo "Blocked: $FILE_PATH matches protected pattern '$pattern'" >&2
    exit 2
  fi
done
exit 0
```

#### Re-inject context after compaction (critical for long sessions)
```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "compact",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Reminder: use Bun, not npm. Run bun test before committing. Current sprint: auth refactor.'"
          }
        ]
      }
    ]
  }
}
```

#### Desktop notifications
```json
{
  "hooks": {
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "osascript -e 'display notification \"Claude Code needs your attention\" with title \"Claude Code\"'"
          }
        ]
      }
    ]
  }
}
```

#### Prompt-based Stop hook (LLM verification)
```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Check if all tasks are complete. If not, respond with {\"ok\": false, \"reason\": \"what remains to be done\"}."
          }
        ]
      }
    ]
  }
}
```

#### Agent-based verification hook
```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "agent",
            "prompt": "Verify that all unit tests pass. Run the test suite and check the results. $ARGUMENTS",
            "timeout": 120
          }
        ]
      }
    ]
  }
}
```

#### Auto-approve ExitPlanMode
```json
{
  "hooks": {
    "PermissionRequest": [
      {
        "matcher": "ExitPlanMode",
        "hooks": [
          {
            "type": "command",
            "command": "echo '{\"hookSpecificOutput\": {\"hookEventName\": \"PermissionRequest\", \"decision\": {\"behavior\": \"allow\"}}}'"
          }
        ]
      }
    ]
  }
}
```

#### Filter by tool arguments (`if` field, v2.1.85+)
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "if": "Bash(git *)",
            "command": ".claude/hooks/check-git-policy.sh"
          }
        ]
      }
    ]
  }
}
```

### Hook Precedence

When multiple hooks return conflicting decisions, Claude Code picks the **most restrictive**: deny > ask > allow. Text from `additionalContext` is kept from every hook.

### Critical: Stop Hook Infinite Loop Prevention

```bash
#!/bin/bash
INPUT=$(cat)
if [ "$(echo "$INPUT" | jq -r '.stop_hook_active')" = "true" ]; then
  exit 0  # Allow Claude to stop
fi
# ... rest of hook logic
```

---

## 7. Custom Subagents

**Source**: [code.claude.com/docs/en/sub-agents](https://code.claude.com/docs/en/sub-agents)

### Built-in Subagents

| Agent | Model | Tools | Purpose |
|-------|-------|-------|---------|
| **Explore** | Haiku (fast) | Read-only | File discovery, code search, codebase exploration |
| **Plan** | Inherits | Read-only | Codebase research for planning |
| **general-purpose** | Inherits | All | Complex multi-step tasks requiring exploration + modification |

### Frontmatter Fields

| Field | Description |
|-------|-------------|
| `name` | Display name (required) |
| `description` | When to use (required) |
| `tools` | Allowed tool list |
| `disallowedTools` | Denied tool list |
| `model` | `opus`, `sonnet`, `haiku` |
| `permissionMode` | Permission level |
| `mcpServers` | MCP server config |
| `hooks` | Scoped hooks |
| `maxTurns` | Maximum tool-use turns |
| `skills` | Preloaded skills |
| `initialPrompt` | First prompt on spawn |
| `memory` | Persistent memory config |
| `effort` | Reasoning effort level |
| `background` | Run without blocking main conversation |
| `isolation` | `worktree` for parallel file safety |
| `color` | UI identification color |

### Example: Security Reviewer

```markdown
---
name: security-reviewer
description: Reviews code for security vulnerabilities
tools: Read, Grep, Glob, Bash
model: opus
---
You are a senior security engineer. Review code for:
- Injection vulnerabilities (SQL, XSS, command injection)
- Authentication and authorization flaws
- Secrets or credentials in code
- Insecure data handling

Provide specific line references and suggested fixes.
```

### Preloading Skills into Subagents

```yaml
---
name: api-builder
description: Build REST APIs following project conventions
skills:
  - api-conventions
  - testing-standards
---
```

Full skill content is injected at startup (unlike regular sessions where only descriptions are loaded).

### Scope Priority (Highest to Lowest)

1. Managed settings (organization)
2. `--agents` CLI flag (session)
3. `.claude/agents/` (project)
4. `~/.claude/agents/` (user)
5. Plugin agents directory

### Background Agents

```yaml
---
name: watcher
description: Monitor for issues in background
background: true
---
```

Runs without blocking the main conversation.

### Shrivu Shankar's "Master-Clone" Pattern

Instead of creating highly specialized custom subagents, use Claude's built-in `Task(...)` to spawn **clones** of the general agent. This preserves holistic reasoning while maintaining context efficiency. Custom subagents "gatekeep context" from the main agent and force rigid human-defined workflows.

---

## 8. Agent Teams (Experimental)

**Source**: [code.claude.com/docs/en/agent-teams](https://code.claude.com/docs/en/agent-teams)

### Enable

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
```

### Architecture

| Component | Role |
|-----------|------|
| **Team lead** | Main session that creates team, spawns teammates, coordinates |
| **Teammates** | Separate Claude Code instances with own context windows |
| **Task list** | Shared work items teammates claim and complete |
| **Mailbox** | Inter-agent messaging system |

### vs Subagents

| | Subagents | Agent Teams |
|---|-----------|-------------|
| **Context** | Own window, results return to caller | Own window, fully independent |
| **Communication** | Report back only | Teammates message each other directly |
| **Coordination** | Main agent manages all | Shared task list, self-coordination |
| **Best for** | Focused tasks, result-only | Complex work requiring discussion |
| **Token cost** | Lower | Higher |

### Best Use Cases

1. **Research and review**: Multiple teammates investigate different aspects simultaneously
2. **New modules/features**: Each teammate owns a separate piece
3. **Debugging with competing hypotheses**: Test different theories in parallel
4. **Cross-layer coordination**: Frontend, backend, tests each owned by different teammate

### Quality Gate Hooks for Teams

- `TeammateIdle`: Exit code 2 to keep teammate working
- `TaskCreated`: Exit code 2 to prevent task creation
- `TaskCompleted`: Exit code 2 to prevent premature completion

### Display Modes

- **In-process**: All in main terminal, `Shift+Down` to cycle
- **Split panes**: Each teammate gets own pane (requires tmux or iTerm2)

### Practical Guidance

- Start with 3-5 teammates
- 5-6 tasks per teammate is optimal
- Teammates load CLAUDE.md, MCP, and skills -- but NOT the lead's conversation history
- Avoid file conflicts: break work so each teammate owns different files

---

## 9. Worktree & Parallel Execution Patterns

### Built-in Worktree Support

```bash
# Named worktree
claude --worktree feature-auth

# Auto-named
claude --worktree

# Combine with tmux
claude --worktree feature-auth --tmux
```

Worktrees created at `<repo>/.claude/worktrees/<name>/`, branch from `origin/HEAD`.

### Subagent Worktrees

```yaml
---
name: refactorer
isolation: worktree
---
```

Each subagent gets its own worktree, automatically cleaned up when done.

### .worktreeinclude (Copy Gitignored Files)

```text
.env
.env.local
config/secrets.json
```

Files matching patterns AND gitignored are copied to new worktrees.

### Shell Alias Pattern (Boris Cherny)

```bash
alias za="cd /path/to/worktree-a && claude"
alias zb="cd /path/to/worktree-b && claude"
alias zc="cd /path/to/worktree-c && claude"
```

### The Fan-Out Pattern (Large Migrations)

```bash
for file in $(cat files.txt); do
  claude -p "Migrate $file from React to Vue. Return OK or FAIL." \
    --allowedTools "Edit,Bash(git commit *)"
done
```

### Writer/Reviewer Pattern

| Session A (Writer) | Session B (Reviewer) |
|---------------------|----------------------|
| `Implement rate limiter` | |
| | `Review rate limiter in @src/middleware/rateLimiter.ts` |
| `Address review feedback: [paste]` | |

---

## 10. Spec-Driven Development & Plan Mode

### The Four-Phase Workflow

**Source**: [agentfactory.panaversity.org](https://agentfactory.panaversity.org/docs/General-Agents-Foundations/spec-driven-development), [alexop.dev](https://alexop.dev/posts/spec-driven-development-claude-code-in-action/)

#### Phase 1: Specify
Provide high-level description of what you're building. Agent generates detailed spec focused on user journeys and success criteria.

#### Phase 2: Plan
Provide desired stack, architecture, and constraints. Agent generates comprehensive technical plan.

#### Phase 3: Research
Claude acts as AI dev team. You are product owner, Claude is tech lead, subagents are developers.

#### Phase 4: Implement
Task tool distributes work. Each subagent implements, tests, and creates PRs.

### Plan Mode in Practice

```bash
# Start in plan mode
claude --permission-mode plan

# Or switch during session: Shift+Tab twice
```

In Plan Mode, Claude uses read-only operations and `AskUserQuestion` to gather requirements before proposing a plan. Press `Ctrl+G` to open plan in text editor for direct editing.

### The Interview Pattern

```text
I want to build [brief description]. Interview me in detail using the AskUserQuestion tool.

Ask about technical implementation, UI/UX, edge cases, concerns, and tradeoffs. Don't ask obvious questions, dig into the hard parts I might not have considered.

Keep interviewing until we've covered everything, then write a complete spec to SPEC.md.
```

Then start a fresh session to execute the spec with clean context.

### GitHub Spec Kit

GitHub open-sourced [spec-kit](https://github.com/github/spec-kit) -- a toolkit for spec-driven development that works with Claude Code, Copilot, and Gemini CLI.

### Key Insight

> Review at phase gates, not during implementation. This reduces approval overhead, minimizes context switching, and produces better results.

---

## 11. Compounding Engineering Pattern

**Source**: [agentic-patterns.com](https://www.agentic-patterns.com/patterns/compounding-engineering-pattern/), [compounding-engineering-plugin](https://github.com/mbiskach/compounding-engineering-plugin)

### Core Concept

Traditional engineering: each feature makes the next harder. Compounding engineering: each feature makes the next **easier**.

### Four Implementation Mechanisms

1. **System Prompts/CLAUDE.md** -- Global standards and conventions
2. **Slash Commands** -- Encapsulated repeatable workflows
3. **Subagents** -- Specialized validators for distinct concerns
4. **Hooks** -- Automated preventative checks blocking regressions

### Post-Feature Codification

After every feature:
- Update documentation with new standards
- Create commands for recurring workflows
- Develop specialized validation agents
- Implement automated preventative checks
- Encode requirements into tests

### Auto-Update via PR Reviews

```
@.claude tag on PRs --> GitHub Action --> Updates CLAUDE.md
```

A feedback codifier agent extracts lessons from PR comments, storing them in CLAUDE.md. Every PR teaches the system, every bug becomes a permanent lesson, every code review updates defaults.

### Trade-offs

**Advantages**: Accelerating productivity, knowledge preservation, improved onboarding, reduced repeated mistakes, living documentation

**Disadvantages**: Requires post-feature discipline, ongoing prompt maintenance, risk of over-specification, system prompts grow large without pruning

---

## 12. Python Library Development Patterns

### The Instructor Library CLAUDE.md

**Source**: [github.com/instructor-ai/instructor/blob/main/CLAUDE.md](https://github.com/instructor-ai/instructor/blob/main/CLAUDE.md)

Key patterns from a real production Python library:
- Uses `uv` for package management: `uv pip install -e ".[dev,anthropic]"`
- Testing: `uv run pytest tests/ -n auto` (parallel execution)
- Type checking: `uv run ty check` for incremental validation
- Linting: `uv run ruff check` and `uv run ruff format`
- **No mocking allowed** -- tests make real API calls
- Conventional commits: `feat(anthropic): add Claude 3.5 support`
- Architecture: Factory pattern, Mode system, Patching mechanism

### The minimaxir Python Code Quality Guidelines

**Source**: [gist.github.com/minimaxir/c274d7cc12f683d93df2b1cc5bab853c](https://gist.github.com/minimaxir/c274d7cc12f683d93df2b1cc5bab853c)

Comprehensive Python agent guidelines:
- **`uv`** for package management, `.venv` creation
- **polars** over pandas (always)
- **orjson** for JSON operations
- **tqdm** for progress bars with contextual descriptions
- **ruff** for formatting/linting (88 char line length)
- **mypy** for static type checking
- **pytest** with Arrange-Act-Assert pattern
- Mandatory type hints, docstrings, PEP 8
- 4-space indentation, snake_case functions, PascalCase classes
- Max 5 parameters per function, single responsibility
- Never silently swallow exceptions
- Use dataclasses for simple containers
- Prefer composition over inheritance
- f-strings for formatting, list comprehensions, generators

### Python Project CLAUDE.md Template Pattern

```markdown
# Project Name

## Stack
- Python 3.12+, uv for package management
- pytest for testing, ruff for linting
- Type checking with ty or mypy

## Commands
- Install: `uv sync --dev`
- Test: `uv run pytest tests/`
- Lint: `uv run ruff check . && uv run ruff format .`
- Type check: `uv run ty check` or `uv run mypy .`

## Architecture
- src/ layout for library code
- tests/ mirrors src/ structure
- Modern typing: `str | int` not `Union[str, int]`
- Pydantic v2 for data models

## Conventions
- Async/await patterns throughout
- Meaningful variable names, comprehensive docstrings
- No mutable default arguments
- Context managers for resource management
- Arrange-Act-Assert test pattern

## Gotchas
- [Project-specific non-obvious behaviors]
```

### The Browser-Use Monorepo Example

**Source**: [gist.github.com/pirate/ef7b8923de3993dd7d96dbbb9c096501](https://gist.github.com/pirate/ef7b8923de3993dd7d96dbbb9c096501)

Real monorepo Python CLAUDE.md patterns:
- Python projects use `uv`: `uv sync --dev --all-extras`
- Pre-commit hooks: `uv run pre-commit run --all-files`
- Async/await patterns throughout for thread-safety
- Pydantic v2 models with strict validation and `ConfigDict`
- Separate logging into private `_log_()` methods
- **Runtime assertions** for critical invariants (don't rely on unit tests alone)
- **Real objects** instead of mocks (except for LLM calls)
- `pytest-httpserver` for HTML test serving
- Write failing test first, implement minimal code, run full suite
- Field aliasing for renaming: `Field(validation_alias=AliasChoices('old_name'))`

---

## 13. Monorepo Patterns

### Hierarchical CLAUDE.md Loading

```
root/CLAUDE.md              <-- Always loaded
root/frontend/CLAUDE.md     <-- Auto-loads when working in frontend/
root/backend/CLAUDE.md      <-- Auto-loads when working in backend/
root/shared/CLAUDE.md       <-- Auto-loads when working in shared/
```

All levels contribute content simultaneously. Files from working directory and above load at launch; subdirectories load as you work in them.

### Real Example: 47,000-word to 8,900-character Reduction

**Source**: [dev.to/anvodev](https://dev.to/anvodev/how-i-organized-my-claudemd-in-a-monorepo-with-too-many-contexts-37k7)

Before: Single 47,000-word file exceeding all limits.

After:
| File | Size |
|------|------|
| Main CLAUDE.md | 8,902 chars |
| Frontend CLAUDE.md | 8,647 chars |
| Backend CLAUDE.md | 7,892 chars |
| Core CLAUDE.md | 7,277 chars |

**80% reduction** while improving relevance.

### The Conditional Loading Pattern

Instead of `@docs/frontend-guideline.md` (loads everything):
```markdown
See docs/frontend-guideline.md for detailed frontend guidelines.
```

This keeps initial context lightweight while making supplementary materials available on-demand.

### Monorepo Skills Discovery

Skills from nested `.claude/skills/` are auto-discovered:
```
packages/frontend/.claude/skills/  <-- found when editing packages/frontend/ files
packages/backend/.claude/skills/   <-- found when editing packages/backend/ files
```

---

## 14. Real-World CLAUDE.md Examples

### awesome-claude-md Repository

**Source**: [github.com/josix/awesome-claude-md](https://github.com/josix/awesome-claude-md)

Top picks:
- **OpenAI Agents Python** -- Multi-agent framework CLAUDE.md
- **Basic Memory** -- MCP integration patterns
- **Overreacted.io** -- Next.js/React/MDX with personality
- **Pydantic GenAI Prices** -- Data processing pipeline patterns
- **Citadel Protocol** -- Security-first DeFi architecture
- **Cloudflare Workers SDK** -- Monorepo patterns
- **Anthropic Quickstarts** -- Multi-project organization by AI experts
- **GoMall** -- RIPER-5 AI methodology

### Claude Code Ultimate Guide Repository

**Source**: [github.com/FlorianBruniaux/claude-code-ultimate-guide](https://github.com/FlorianBruniaux/claude-code-ultimate-guide)

Contains:
- **24,000+ lines** of documentation across 10 sections
- **228 templates**: 9 agent personas, 26 slash commands, 31 hooks, 14 skills
- **271-question assessment** across 9 categories
- **41 Mermaid diagrams** visualizing concepts
- **Threat intelligence database** with 24 CVEs and 655 malicious skill patterns
- TDD, SDD, BDD, and GSD methodology comparisons

### awesome-claude-code Repository

**Source**: [github.com/hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code)

Curated list of skills, hooks, slash-commands, agent orchestrators, applications, and plugins.

---

## 15. Elite Practitioner Insights

### Shrivu Shankar ("How I Use Every Claude Code Feature")

**Source**: [blog.sshh.io/p/how-i-use-every-claude-code-feature](https://blog.sshh.io/p/how-i-use-every-claude-code-feature)

Key insights:
- **13KB CLAUDE.md** for professional work -- only documents tools used by 30%+ of engineers
- **Start with guardrails, not a manual** -- expand based on what agent gets wrong
- **Never embed docs via @** -- bloats context windows
- **Never use negative-only constraints** -- always provide alternatives
- **Block-at-commit, not block-at-write** -- PreToolUse hooks on `Bash(git commit)` checking for `/tmp/agent-pre-commit-pass` created only after tests pass
- **Skills are bigger than MCP** -- formalization of the "scripting layer"
- **Master-Clone over Lead-Specialist** -- use built-in Task() over rigid custom subagents
- **"Shoot and forget"** philosophy -- judge by final PR, not how it gets there
- **Data-driven flywheel**: Bugs -> Improved CLAUDE.md/CLIs -> Better Agent

### Dex Horthy (HumanLayer, coined "Context Engineering")

**Source**: [x.com/dexhorthy](https://x.com/dexhorthy/status/1978676162495688719)

- Published the foundational superthread on advanced Claude Code usage and context engineering
- Key principle: **LLMs are stateless** -- the only way to improve output is optimizing input
- **Build context once, reuse many times** -- don't re-explain architecture in every session
- **Fork baseline sessions** -- establish context, then branch for specific tasks
- Coined the term **"Context Engineering"** in April 2025
- Inspired claude-loop and multiple community frameworks

### Community Tips (45+ Tips Collection)

**Source**: [github.com/ykdojo/claude-code-tips](https://github.com/ykdojo/claude-code-tips)

Notable advanced tips:
- Custom status line scripts
- Cutting the system prompt in half
- Using Gemini CLI as Claude Code's minion
- Claude Code running itself in a container
- Breaking down complex problems into solvable sub-problems
- Using `/clear` aggressively between unrelated tasks

---

## 16. Key Takeaways & Synthesis

### The Meta-Pattern: Context is Everything

Every elite pattern ultimately optimizes for one thing: **getting the right context into Claude's window at the right time**. The context window is the single most important resource to manage.

### Architecture Summary for selectools

Based on all research, the ideal setup for a Python library like selectools:

#### CLAUDE.md (Root -- ~50-80 lines)

```markdown
# selectools

AI agent framework for tool selection. Python 3.12+, uv, pytest, ruff.

## Commands
- Install: `uv sync --dev`
- Test: `uv run pytest tests/ -x`
- Single test: `uv run pytest tests/test_specific.py::test_name -x`
- Lint: `uv run ruff check . && uv run ruff format .`
- Type check: `uv run ty check`

## Architecture
- src/selectools/ -- core library
- Modern Python typing (str | int, not Union)
- Async/await patterns throughout
- Pydantic v2 for data models

## Critical Rules
- IMPORTANT: Run tests after every change
- IMPORTANT: No mocks except for LLM API calls
- Use Arrange-Act-Assert test pattern
- Write failing test first, then implement

Before starting any task, identify which docs in docs/ are relevant and read them.
```

#### Progressive Disclosure Hierarchy

```
CLAUDE.md                        # Always loaded (~50 lines)
docs/architecture.md             # Read on demand
docs/testing-strategy.md         # Read on demand
docs/agent-patterns.md           # Read on demand
.claude/rules/python-style.md    # Path-scoped to *.py
.claude/rules/test-rules.md      # Path-scoped to tests/**
.claude/skills/fix-issue/        # Manual invoke only
.claude/skills/release/          # Manual invoke only
.claude/agents/security-reviewer.md
.claude/agents/test-runner.md
```

#### Essential Hooks

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.file_path' | xargs ruff format 2>/dev/null || true"
          }
        ]
      }
    ],
    "SessionStart": [
      {
        "matcher": "compact",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Reminder: Use uv, not pip. Run uv run pytest after changes. selectools is a Python library.'"
          }
        ]
      }
    ],
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "osascript -e 'display notification \"Claude Code needs attention\" with title \"selectools\"'"
          }
        ]
      }
    ]
  }
}
```

### The Hierarchy of Leverage

1. **Verification loops** (highest leverage) -- tests, linters, screenshots
2. **CLAUDE.md** (persistent context) -- short, focused, compounding
3. **Hooks** (deterministic enforcement) -- format, block, notify
4. **Skills** (on-demand knowledge) -- task-specific workflows
5. **Subagents** (context isolation) -- exploration, review, specialized tasks
6. **Plan mode** (strategic alignment) -- research before implementation
7. **Worktrees** (parallel execution) -- multiple features simultaneously
8. **Agent teams** (collaborative coordination) -- complex multi-perspective work

### Universal Anti-Patterns

1. **Kitchen sink CLAUDE.md** -- over 200 lines, important rules get lost
2. **Using @imports for large docs** -- bloats every session's context
3. **Correcting over and over** -- /clear after 2 failed corrections, write better prompt
4. **Trust-then-verify gap** -- always provide verification (tests, scripts, screenshots)
5. **Infinite exploration** -- scope investigations narrowly or use subagents
6. **Negative-only constraints** -- always provide alternatives to prohibited approaches
7. **Style rules in CLAUDE.md** -- use linters/formatters via hooks instead
8. **Auto-generating CLAUDE.md** -- manually craft for highest leverage

---

## Sources

### Official Documentation
- [Best Practices](https://code.claude.com/docs/en/best-practices)
- [Skills System](https://code.claude.com/docs/en/skills)
- [Hooks Guide](https://code.claude.com/docs/en/hooks-guide)
- [Hooks Reference](https://code.claude.com/docs/en/hooks)
- [Subagents](https://code.claude.com/docs/en/sub-agents)
- [Agent Teams](https://code.claude.com/docs/en/agent-teams)
- [Common Workflows](https://code.claude.com/docs/en/common-workflows)
- [Memory (CLAUDE.md)](https://code.claude.com/docs/en/memory)
- [Settings](https://code.claude.com/docs/en/settings)

### Boris Cherny
- [How Boris Uses Claude Code](https://howborisusesclaudecode.com/)
- [Boris Cherny on Threads](https://www.threads.com/@boris_cherny)
- [HN Discussion on 259 PRs](https://news.ycombinator.com/item?id=46407967)

### Community Leaders
- [Dex Horthy - Context Engineering Superthread](https://x.com/dexhorthy/status/1978676162495688719)
- [Shrivu Shankar - Every Claude Code Feature](https://blog.sshh.io/p/how-i-use-every-claude-code-feature)
- [HumanLayer - Writing a Good CLAUDE.md](https://www.humanlayer.dev/blog/writing-a-good-claude-md)
- [AlexOp - Progressive Disclosure](https://alexop.dev/posts/stop-bloating-your-claude-md-progressive-disclosure-ai-coding-tools/)

### Curated Collections
- [awesome-claude-md](https://github.com/josix/awesome-claude-md)
- [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code)
- [claude-code-ultimate-guide](https://github.com/FlorianBruniaux/claude-code-ultimate-guide)
- [claude-code-tips (45 tips)](https://github.com/ykdojo/claude-code-tips)

### Patterns & Frameworks
- [Compounding Engineering Pattern](https://www.agentic-patterns.com/patterns/compounding-engineering-pattern/)
- [Spec-Driven Development](https://agentfactory.panaversity.org/docs/General-Agents-Foundations/spec-driven-development)
- [GitHub Spec Kit](https://github.com/github/spec-kit)
- [Parallel AI Coding with Git Worktrees](https://docs.agentinterviews.com/blog/parallel-ai-coding-with-gitworktrees/)

### Python-Specific
- [Instructor Library CLAUDE.md](https://github.com/instructor-ai/instructor/blob/main/CLAUDE.md)
- [minimaxir Python Code Quality Guidelines](https://gist.github.com/minimaxir/c274d7cc12f683d93df2b1cc5bab853c)
- [pydevtools CLAUDE.md Template](https://pydevtools.com/handbook/how-to/how-to-use-the-pydevtools-claude-md-template/)
- [Browser-Use Monorepo CLAUDE.md](https://gist.github.com/pirate/ef7b8923de3993dd7d96dbbb9c096501)

### Blog Posts & Articles
- [Spec-Driven Development with Claude Code](https://alexop.dev/posts/spec-driven-development-claude-code-in-action/)
- [Claude Code Worktrees Guide](https://claudefa.st/blog/guide/development/worktree-guide)
- [Subagent Best Practices](https://claudefa.st/blog/guide/agents/sub-agent-best-practices)
- [30 Tips for Agent Teams](https://getpushtoprod.substack.com/p/30-tips-for-claude-code-agent-teams)
