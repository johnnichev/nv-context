# Practitioner Wisdom: Agentic Coding & Context Engineering
## Deep Research from Reddit, Hacker News, Community Forums, and Developer Blogs
### Compiled: 2026-04-04

---

## Table of Contents

1. [What Practitioners Actually Put in CLAUDE.md/AGENTS.md](#1-what-practitioners-actually-put-in-claudemdagentsmd)
2. [Workflows That Dramatically Improve Agent Output](#2-workflows-that-dramatically-improve-agent-output)
3. [Common Mistakes People Made and Fixed](#3-common-mistakes-people-made-and-fixed)
4. [How Power Users Structure Repos for AI Agents](#4-how-power-users-structure-repos-for-ai-agents)
5. [Managing Long Sessions and Context Window Limits](#5-managing-long-sessions-and-context-window-limits)
6. [Skills, Hooks, and MCP Servers in Practice](#6-skills-hooks-and-mcp-servers-in-practice)
7. [Real Before/After Stories](#7-real-beforeafter-stories)
8. [Controversial and Non-Obvious Advice](#8-controversial-and-non-obvious-advice)
9. [Advanced Context Engineering Techniques](#9-advanced-context-engineering-techniques)
10. [Task Decomposition Patterns](#10-task-decomposition-patterns)
11. [Tool-Specific Community Wisdom](#11-tool-specific-community-wisdom)
12. [Sources](#12-sources)

---

## 1. What Practitioners Actually Put in CLAUDE.md/AGENTS.md

### The Golden Rules (Converged Community Consensus)

**Keep it SHORT. Ruthlessly.**
- Anthropic recommends under 200 lines. Community consensus is under 300 lines, shorter is better.
- HumanLayer's own root CLAUDE.md is less than 60 lines.
- Reddit consensus: start with 20-30 lines and add rules ONLY when you catch yourself repeating instructions.
- "If your CLAUDE.md is too long, Claude ignores half of it because important rules get lost in the noise."
- Research shows frontier LLMs can follow ~150-200 instructions with reasonable consistency. Claude's system prompt already consumes ~50 of those slots. Every instruction you add degrades ALL instructions uniformly.

**What to Include (The WHAT/WHY/HOW Framework)**
- **WHAT**: Tech stack, project structure, codebase map. Critical for monorepos -- identify apps, shared packages, and their purposes.
- **WHY**: The project's purpose and what different parts accomplish.
- **HOW**: Instructions for working on the project (e.g., "use bun instead of node"), running tests, verifications, compilation steps.

**What NOT to Include**
- Code snippets (they go stale fast -- use `file:line` references instead)
- Code style guidelines (use linters/formatters instead -- LLMs are expensive linters)
- Anything Claude already does correctly without being told
- Task-specific instructions (use Skills for those)
- Anything that can be enforced by hooks (make it deterministic, not probabilistic)

### Practical CLAUDE.md Structure (Distilled from Multiple Power Users)

```markdown
# Project Name
Brief 2-4 sentence description of what this project does and who it's for.

# Tech Stack
- Language: TypeScript (strict mode)
- Framework: Next.js 15 App Router
- Styling: Tailwind CSS
- Database: PostgreSQL via Drizzle ORM
- Testing: Vitest + Playwright

# Commands
- `bun run dev` -- start dev server
- `bun run test` -- run all tests
- `bun run lint` -- lint + typecheck
- `bun run build` -- production build

# Architecture
- /src/app -- Next.js routes
- /src/lib -- shared utilities
- /src/db -- database schema and queries
- /src/components -- React components

# Conventions
- Named exports only (no default exports)
- Functions under 40 lines
- Collocate tests next to source files
- Use Drizzle for all database queries (no raw SQL)

# Guard Rails
- NEVER modify .env files
- NEVER commit secrets or credentials
- Always run tests before committing
- Ask before adding new dependencies
```

### Hierarchical CLAUDE.md (For Monorepos/Large Projects)

Power users place CLAUDE.md at multiple directory levels:
- Root CLAUDE.md: project-wide rules and architecture map
- `src/api/CLAUDE.md`: API-specific conventions
- `src/components/CLAUDE.md`: component patterns and testing requirements
- Claude prioritizes the most specific (closest) file

### Progressive Disclosure Strategy (From HumanLayer)

Don't cram everything into CLAUDE.md. Create separate docs:

```
agent_docs/
  |- building_the_project.md
  |- running_tests.md
  |- code_conventions.md
  |- service_architecture.md
```

Tell Claude which files exist and let it decide what's relevant for the current task. This keeps context lean while making deep knowledge accessible on demand.

### AGENTS.md (GitHub's Format -- Lessons from 2,500+ Repos)

GitHub analyzed 2,500+ repositories and found the most effective AGENTS.md files cover six core areas:
1. **Executable commands** (with flags, not just tool names)
2. **Testing frameworks** (specific commands like `pytest -v`, not just "run tests")
3. **Project structure** (file organization map)
4. **Code style examples** (real code, not descriptions)
5. **Git workflows** (branching, commit message format)
6. **Clear boundaries** (three-tier: always do / ask first / never do)

**The most common and effective constraint across all repos:** "Never commit secrets."

**Key pattern: Show, don't tell.** Real code snippets outperform lengthy descriptions. Include both good and bad examples for maximum clarity.

---

## 2. Workflows That Dramatically Improve Agent Output

### The Research-Plan-Implement Pattern (Universal Consensus)

This is THE most agreed-upon workflow across all communities. Every experienced practitioner converges on it.

**Phase 1: Research**
- Have the agent deeply read relevant code and write findings to a persistent file (e.g., `research.md`)
- Use language like "deeply," "in great detail," "intricacies" to prevent surface-level skimming
- Write findings to disk, not chat -- they become your review surface
- Human reviews research output to catch fundamental misunderstandings BEFORE they propagate

**Phase 2: Planning**
- Request detailed `plan.md` with approach, code snippets, file paths, and trade-offs
- Use custom markdown files instead of built-in plan mode for full control
- Share reference implementations from open-source projects alongside plan requests

**Phase 3: The Annotation Cycle (Boris Tane's Key Innovation)**
1. Claude writes the plan
2. You review in your editor and add inline notes directly into the document
3. Send Claude back: "I added a few notes. Address all notes and update accordingly. Don't implement yet."
4. Repeat 1-6 times until satisfied
5. Request granular task breakdown with todo list

**Phase 4: Implementation**
- Use a standardized prompt: "Implement it all. When done with a task or phase, mark it as completed in the plan document. Do not stop until all tasks are completed."
- Keep corrections terse during execution -- reference existing code patterns
- Revert and re-scope rather than patching bad approaches

**Key insight from Boris Tane:** "Never let Claude write code until you've reviewed and approved a written plan. This separation of planning and execution is the single most important thing."

### The Throw-Away First Draft Strategy

For difficult features:
1. Create a branch
2. Let Claude write end-to-end while you observe
3. Compare output against requirements
4. Discard code but keep insights about Claude's decision-making patterns
5. Write sharper second-pass prompts informed by what you observed

### Test-Driven Development with Agents

1. Have the agent write tests from input/output pairs (be explicit you're doing TDD)
2. Tell agent to run tests and confirm failure -- explicitly prohibit implementation
3. Commit tests when satisfied
4. Request implementation that passes tests WITHOUT modifying them
5. Commit implementation once passing

**Community insight:** "Tests are the single highest-leverage thing you can provide. Include tests, screenshots, or expected outputs so Claude can check itself."

### The Spec-Based Interview Workflow

1. Start with a minimal spec or prompt
2. Ask Claude to interview you (using AskUserQuestionTool)
3. Claude asks clarifying questions to flesh out requirements
4. This produces a comprehensive spec document
5. Start a NEW session to execute the spec with fresh context

**Why it works:** Having AI ask clarifying questions before generating code saves tokens because you avoid revision cycles. One revision cycle costs more than a focused interview.

### Dual-Model Review

Have one model write code, then a different model critique it:
- Use Opus 4.5 for execution (faster feedback loops)
- Have GPT-5.2-Codex review for bugs
- Or reverse: Claude plans, Gemini reviews

This cross-pollination catches model-specific blind spots.

---

## 3. Common Mistakes People Made and Fixed

### Mistake 1: Throwing Massive Tasks at the Agent

**What happens:** Cascading failures, lost context, inconsistent implementations.
**The fix:** Break tasks into 3-5 file chunks. Test after each phase. "Large monolithic requests fail -- developers who asked AIs for huge swaths of code ended up with inconsistent, duplicate logic."

### Mistake 2: Not Committing Before Agent Work

**Horror story from Cursor forum:** "Agent modified 30 files; couldn't identify which caused login feature breakage."
**The fix:** ALWAYS commit before using the agent. Use `git diff` to review changes. `git reset --hard` if problems emerge. Work on feature branches, never main.

### Mistake 3: Letting the Agent Keep Running Through Errors

**What happens:** Agent encounters missing dependencies, creates fake ones, compounds problems exponentially.
**The fix:** Hit ESC immediately when seeing red errors. Don't let the agent charge ahead based on mistakes. Assess, adjust instructions, restart fresh.

### Mistake 4: Trusting AI Code Without Review

**From Cursor forum:** "Production database got wiped because I trusted Agent-generated code without verification."
**The fix:** Always run tests, scan git diffs, check for TODO comments, verify edge cases, review for security issues before committing. "The faster the agent works, the more important your review process becomes."

### Mistake 5: Using CLAUDE.md as a Linter

**Why it fails:** LLMs are expensive, slow, probabilistic linters. Style guidelines bloat context and degrade performance.
**The fix:** Use auto-fixing linters (Biome, Prettier, Ruff, ESLint). Use Claude Code Stop hooks to run formatters automatically. Let Claude learn patterns from existing code.

### Mistake 6: Auto-Generating CLAUDE.md with /init

**From HumanLayer:** "Avoid /init or auto-generation tools. Since this file affects every interaction and artifact, invest time crafting each line carefully. A poor instruction compounds through research -> plan -> code phases, creating exponential degradation."

### Mistake 7: Not Using .cursorignore / .claudeignore

**What happens:** Agent scans node_modules and irrelevant directories, slowing down by 70% and getting distracted by irrelevant code.
**The fix:** Configure exclusions for node_modules/, dist/, build/, .next/, .git/.

### Mistake 8: Over-Relying on Sub-Agents

**From practitioners:** Parallel sub-agents (like 10 Explore agents) cause UI flickering and can overwhelm. Use them purposefully for truly independent tasks, not as default behavior.

### Mistake 9: Not Monitoring Context Usage

**The numbers:** At 70% context, Claude starts losing precision. At 85%, hallucinations increase. At 90%+, responses become erratic.
**The fix:** Never exceed 60% context for complex work. Use `/context` to monitor. Compact proactively at 50-60%, not reactively at 90%.

### Mistake 10: The Vibe Coding Trap

**The 80/20 wall:** AI-generated code works brilliantly for the first 80% of a project. The last 20% -- edge cases, integrations, production hardening -- is where projects die. That last 20% requires exactly the coding skills AI promised you wouldn't need.

---

## 4. How Power Users Structure Repos for AI Agents

### Minimize Package Complexity
- Avoid "package explosion" with micro-packages
- Keep 2-3 major packages (frontend, backend, shared) instead of 10+
- "Each package adds cognitive overhead as the agent must understand not just the code but relationships between packages"

### Flatten Directory Hierarchies
- Reduce deep nesting; use shallow, semantically meaningful structures
- Co-locate related files (components with their tests, types, utilities)
- Standard component structure:
  - `Component.tsx` (implementation)
  - `Component.test.tsx` (tests)
  - `Component.types.ts` (type definitions)
  - `Component.utils.ts` (helpers)

### Eliminate Re-export Indirection
- Avoid multiple levels of index.ts files re-exporting
- Import directly: `src/components/forms/inputs/TextInput` instead of chained exports
- Limit re-exports to package boundaries only

### Consolidate Configuration at Root
- Define ESLint, Prettier, TypeScript configs once at monorepo root
- Self-contained, independent configs per package (avoid inheritance chains)
- Consistent patterns reduce agent confusion

### Use Discriminated Unions (TypeScript)
- Use `kind` discriminators for type safety
- Enable exhaustive pattern matching
- "Discriminated unions make it impossible to handle a user without checking what kind they are"

### Prefer Simplicity (Armin Ronacher's Advice)
- "Do the dumbest possible thing that will work"
- Use descriptive, longer function names over clever class hierarchies
- Avoid inheritance and complex abstractions
- "Use plain SQL" -- agents write excellent SQL and can match it against logs
- Keep permission checks locally visible; hidden checks get forgotten during expansion

### Language Selection for AI Agents (Armin Ronacher)
- **Go is optimal for backend**: explicit context system, incremental test caching, simple type system, low ecosystem churn
- **Avoid Python for agents**: magic features (Pytest fixtures) confuse agents, runtime complexity (async, event loops) generates incorrect code
- **Frontend**: Tailwind + React + TanStack Query/Router + Vite

### The AI-Friendliness Principle
"When your AI assistant makes mistakes interpreting your codebase, consider that a signal that your code organization might be confusing. New team members will have similar confusion points."

**Measurable impact (from Ben Houston):**
- Typesafe declarations improved route success rates from ~60% to ~100%
- Flatter structures reduced feature implementation time
- Consistent patterns reduced component modification time by ~30%

---

## 5. Managing Long Sessions and Context Window Limits

### The Numbers That Matter
- At 70% context: precision drops noticeably
- At 85%: hallucinations increase
- At 90%+: responses become erratic
- **Safe operating range:** Stay below 60% for complex work, 70-80% acceptable for simple tasks

### Proactive Compaction (Not Reactive)

**Manual compaction beats automatic:** When invoked proactively, the model still has clear recall of the full conversation and produces better summaries that preserve high-level decisions, recent code changes, and general trajectory.

**Automatic compaction pitfall:** Benchmarks showed sessions degrading to 18 minutes per task after auto-compaction, versus 4.5 minutes via manual copy-paste into fresh chat. Reddit advice: start fresh sessions at natural breakpoints.

### The HANDOFF.md Pattern

Before starting fresh conversations, create HANDOFF.md documenting:
- Current project state and architecture
- What was accomplished and what failed
- Key decisions made and reasoning
- Specific next steps with implementation details
- Files that need attention

This becomes the "resume" for the next session.

### The Filesystem as Extended Memory

**Every multi-step task gets state files:**
- `explored_files.md` -- what was investigated
- `hypothesis.md` -- current working theory
- `next_steps.md` -- prioritized action items

If context compacts, re-read these files. They're your extended memory.

### The Five-Document System (Russ Poldrack's Workflow)

1. **PRD** -- Functional and non-functional requirements
2. **CLAUDE.md** -- Agent memory file
3. **PLANNING.md** -- Architecture and dependencies
4. **TASKS.md** -- Milestone-based task list and progress tracker
5. **SCRATCHPAD.md** -- Ongoing development notes

Custom slash commands:
- `/freshstart` -- loads all five docs at session start
- `/summ+commit` -- updates TASKS.md and SCRATCHPAD.md, then commits
- `/clear` -- clears context window

**Session management ritual:** When context reaches 50% or at milestone completion, run `/summ+commit` -> `/clear` -> `/freshstart`.

### Boris Tane's Single-Session Approach

Alternatively: run everything in a single long session. The continuous context allows Claude to build understanding through research, annotation cycles, and implementation sequentially. Context compaction preserves the plan document in full fidelity. (This works when the plan document serves as the primary anchor.)

### Quick Context Refresh

For long sessions (60+ minutes): proactive context preservation every 30 minutes prevents drift. A quick refresh beats reactive recovery.

### Recitation as Attention Control

Maintain todo.md or plan files, updating them step-by-step. This keeps objectives in the model's recent context window, preventing drift in long agent loops (typically 50+ tool calls).

---

## 6. Skills, Hooks, and MCP Servers in Practice

### Hooks: The Deterministic Backbone

Hooks are THE way to enforce rules Claude can't ignore. Unlike CLAUDE.md instructions (which are probabilistic), hooks are deterministic -- they run automatically at specific lifecycle points.

**Essential Hooks Everyone Should Have:**

**1. Auto-Format on File Edit (PostToolUse)**
```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "npx prettier --write \"$(jq -r '.tool_input.file_path' <<< \"$(cat)\")\""
      }]
    }]
  }
}
```

**2. Block Destructive Commands (PreToolUse)**
Blocks patterns: `rm -rf /`, `DROP TABLE`, `--force`, `push.*--force`

**3. Protect Sensitive Files (PreToolUse)**
Blocks writes to `.env`, secrets directories, lock files, `.git`

**4. Desktop Notification When Done (Notification)**
macOS: `osascript -e 'display notification "Task complete" with title "Claude Code" sound name "Glass"'`

**5. Enforce Tests on Stop**
Stop hook that verifies tests pass before allowing session to end. Critical: check `stop_hook_active` to prevent infinite loops.

**6. Post-Compaction Context Injection (SessionStart)**
After compaction, inject reminders about branch info, tool preferences, and recent commits.

**7. Auto-Approve Safe Operations (PreToolUse)**
Auto-allow Read, Glob, Grep, WebSearch, WebFetch -- all read-only operations.

**Hook Configuration Tips:**
- Three levels: user (~/.claude/settings.json), project (.claude/settings.json), local (.claude/settings.local.json)
- Exit codes: 0 = success, 2 = block, other = non-blocking error
- Shell profile output can corrupt JSON -- wrap in `if [[ $- == *i* ]]`
- Always set reasonable timeouts; use `async: true` for non-blocking

### Skills: On-Demand Context Loading

Skills are the answer to "my CLAUDE.md is too long." They load context only when relevant.

**SKILL.md Structure:**
```yaml
---
name: deploy-to-staging
description: Deploy the application to the staging environment
---
# Deploy to Staging

## Prerequisites
- Ensure all tests pass
- Verify branch is up-to-date with main

## Steps
1. Run `bun run build`
2. Run deployment script: `./scripts/deploy-staging.sh`
3. Verify health check: `curl https://staging.example.com/health`
```

**Real-World Skills Examples:**
- **ton-analyst** -- Writes Dune SQL queries for blockchain analysis; includes schema knowledge and API polling (~200 lines)
- **crosspost** -- Publishes across Telegram, Ghost, and Twitter/X in three languages
- **reddit-fetch** -- Routes through Gemini CLI via tmux when Claude can't access Reddit directly
- **laravel-simplifier** -- Refines code for simplicity/readability
- **laravel-debugger** -- Bug tracking and diagnosis
- **task-planner** -- Breaks large tasks into steps

**Skills vs Slash Commands:**
- Slash commands are built-in fixed-logic operations (/clear, /compact, /help)
- Skills are prompt-based capabilities that can spawn subagents, accept arguments, use specific tools
- Skills auto-activate when Claude determines they're relevant. Slash commands require manual invocation.
- Skills are converging to absorb slash commands in future updates.

### MCP Servers: Practical Recommendations

**Most Useful MCP Servers (Community Consensus):**

1. **Context7** -- Injects up-to-date, version-specific documentation directly into prompts. Prevents hallucination of deprecated APIs.
2. **GitHub MCP** -- Repository management, PR reviews, issue tracking without leaving Claude.
3. **Brave Search / DuckDuckGo** -- Real-time web search. DuckDuckGo needs no API key.
4. **Playwright** -- Browser automation for testing. "Playwright generally works better than Claude's native browser integration for non-visual tasks."
5. **Sequential Thinking** -- Step-by-step problem decomposition. Good for complex debugging.
6. **Filesystem** -- Direct file operations (useful in sandboxed environments).

**Critical Warning on MCP Token Consumption:**
MCP servers consume 67,000 tokens before any work begins. System prompts, tool definitions, and schemas eat 30-40K tokens at session start. Tool Search reduced this 46.9% (51K to 8.5K tokens), but it's still a significant tax.

**Armin Ronacher's MCP Warning:** "Minimize MCP usage; only adopt it when standard CLI tools prove unreliable." Each MCP tool definition pre-loads into context, bloating it. Prefer `gh` CLI over GitHub MCP when possible.

### Subagents: Parallel Execution

**Configuration:**
- Set `CLAUDE_CODE_SUBAGENT_MODEL` to control sub-agent model
- Common pattern: main session on Opus for reasoning, sub-agents on Sonnet for focused tasks, Haiku for quick lookups
- Specify `model: "haiku"` in Task tool for cost/latency optimization

**Domain-Based Routing:**
- Frontend agent: React components and UI
- Backend agent: API routes and business logic
- Database agent: Schema and migrations

**Key Insight:** Claude uses sub-agents conservatively by default. Be explicit: "Launch parallel sub-agents for these independent tasks."

**Context Inheritance:**
- General-purpose and Plan sub-agents inherit full context
- Explore sub-agents start fresh (appropriate for independent searches)

---

## 7. Real Before/After Stories

### Story 1: MCP Token Bloat Fix
**Before:** 51K tokens consumed by MCP tool definitions before any work started
**After:** Tool Search feature reduced to 8.5K tokens (46.9% reduction)
**Impact:** Meaningful improvement, but community notes "it's still a tax competitors don't charge"

### Story 2: Route Success Rate
**Before:** ~60% success rate on route implementations with convention-based patterns
**After:** ~100% success rate after switching to typesafe discriminated unions
**Change:** Replaced implicit filename-based exports with explicit type declarations

### Story 3: Blockchain Report Automation
**Before:** 30-page report with 15 charts and 40+ queries would take 5 days manually
**After:** Completed in one evening using voice notes -> Telegram -> Claude Code pipeline
**Setup:** Coolify MCP for deployment, Telegram MCP for voice input, custom SQL skills

### Story 4: Context Compaction vs Fresh Sessions
**Before:** 18 minutes per task after auto-compaction cycles degraded session quality
**After:** 4.5 minutes per task using manual copy-paste into fresh Claude Chat
**Lesson:** Proactive manual compaction vastly outperforms automatic compaction

### Story 5: Component Modification Time
**Before:** Agents struggled with deeply nested, inconsistently organized component trees
**After:** ~30% reduction in component modification time after flattening hierarchies and co-locating files
**Change:** Restructured from feature-folder nesting to co-located component/test/types structure

### Story 6: The Annotation Cycle (Boris Tane)
**Before:** Requesting plans and immediately implementing led to solving the wrong problems
**After:** 1-6 annotation cycles between plan and human review eliminated architectural mismatches before implementation began
**Key:** Human annotations in the plan document (domain corrections, approach rejections, redirections)

---

## 8. Controversial and Non-Obvious Advice

### 1. AI Can Actually Slow You Down
A 2025 METR randomized controlled trial showed experienced open-source developers completed tasks **19% slower** with AI assistance. The Reddit community countered this didn't reflect typical rapid prototyping use cases, but the finding stands for mature codebases.

### 2. Don't Vibe Code -- But Don't Over-Plan Either
"Plan + Prototype Balance" -- Spend time planning but also prototype quickly to validate approaches. The throw-away first draft strategy gives you insights without commitment.

### 3. Single-Task Focus Beats Parallelism
Evidence suggests managing even two concurrent agents creates mental context-switching costs that offset time savings. The review bottleneck is real -- reading generated code is harder than writing it.

### 4. Senior Developers Are the Ones Who Benefit Most
"If you come to the table with solid software engineering fundamentals, the AI will amplify your productivity multifold." Experienced developers treat AI output like code from a junior developer -- they refactor, simplify, and constrain the output with years of wisdom.

### 5. Metric Gaming Is Real
Commit count, pull requests, and lines-of-code metrics became useless when agents generate thousands daily. Measure business outcomes, bug rates, and maintenance burden instead.

### 6. Documentation Over Instructions
"Agents work better with comprehensive context and rationale than with procedural step-by-step directives." Tell Claude WHY, not just HOW.

### 7. Negative Instructions Backfire
From Cursor forum: "Avoid negative statements ('avoid duplicating code'). Models associate negative language with poor code patterns from training data. Frame positively with reasoning."

### 8. The "Second Brain" Pattern
Centralize your knowledge base (Obsidian vault, Notion, etc.) and make it accessible to the agent. Voice notes, projects, transcripts -- all accessible, eliminating context-switching between tools. One practitioner runs a 24/7 server agent that processes voice notes via Telegram.

### 9. Use AI Errors as Codebase Feedback
"When your AI assistant makes mistakes interpreting your codebase, consider that a signal that your code organization might be confusing." Treat AI confusion as a code smell.

### 10. The "Eager, Stubborn, Well-Read, Inexperienced" Model
Anthropomorphize your tool accurately: AI is "eager, stubborn, well-read, inexperienced -- won't admit when it doesn't know something." This frames realistic expectations.

### 11. Never Use Agent Mode on Friday Afternoons
From Cursor forum, with humor but serious intent: "Fixing weekend bugs isn't worth it." Time risky agent operations for when you have recovery time.

### 12. Generate Multiple Implementations
Run the same prompt through multiple models or multiple attempts, then combine the best ideas with informed judgment rather than accepting the first output.

### 13. The Review Bottleneck Nobody Talks About
"Claims of massive throughput gains often gloss over review time -- the actual bottleneck in most workflows." When the agent generates code faster, YOU become the bottleneck.

### 14. Technical Debt Kessler Syndrome
"When Claude Code reviews its own previous output without human intervention, quality degrades rapidly -- poor code makes subsequent edits worse." Always have human checkpoints in the loop.

---

## 9. Advanced Context Engineering Techniques

### The Priority Hierarchy for Context Issues
1. **Incorrect information** (worst -- causes confidently wrong code)
2. **Missing information** (causes hallucination)
3. **Excessive noise** (causes drift and lost focus)

### Five Core Strategies (From Martin Fowler's Team)
1. **Selection** -- Choose what goes in
2. **Compression** -- Reduce token footprint
3. **Ordering** -- Put important things where attention is highest
4. **Isolation** -- Separate concerns into different sessions
5. **Format optimization** -- Structure for LLM consumption

### Context Window Utilization Targets
- Simple tasks: 70-80% utilization acceptable
- Complex tasks: maintain 40-60% utilization
- Very complex systems: stay below 50% and compact frequently

### Intentional Compaction Techniques
Replace verbose outputs with structured summaries:
- Convert lengthy file lists into categorized summaries
- Transform detailed logs into extracted error patterns
- Summarize investigation results into key findings
- Document decisions in decision logs rather than transcribing conversations

### Sub-Agents for Context-Clean Discovery
Use fresh context windows (Explore agents) for:
- File searching and grepping
- Codebase summarization
- Dependency tree analysis
- Pattern identification

This keeps parent agent context clean for actual implementation.

### The PRP (Product Requirements Plan) System (Cole Medin)

**Generate-PRP Phase:**
1. Analyzes codebase patterns and identifies similar implementations
2. Fetches API docs, library guides, includes quirks
3. Creates step-by-step implementation plan with validation gates
4. Assigns confidence score (1-10)

**Execute-PRP Phase:**
1. Load complete PRP context
2. Generate detailed task list
3. Execute each component
4. Run validation (tests, linting)
5. Iterate fixing issues
6. Confirm all requirements met

### Context Layering
- **Global context** (CLAUDE.md): Always active, project-wide rules
- **Feature context** (INITIAL.md / specs): Specific to current implementation
- **Example context** (examples/ folder): Behavioral patterns to replicate
- **Blueprint context** (PRP files): Comprehensive implementation guidance

### The Key Insight
"A developer with a clean, well-structured context on a weaker model will outperform one with a cluttered context on a stronger model."

---

## 10. Task Decomposition Patterns

### The Three Task Categories

**Type 1 -- Narrow, straightforward:** Feature flag removal, unit test writing, boilerplate generation. Minimal context needed; usually one right answer.

**Type 2 -- Context-dependent:** Debugging specific errors, function refactoring, query optimization. Requires error messages, code patterns, relevant files.

**Type 3 -- Big, open-ended:** "Build authentication" or "Add photo upload." NEVER assign directly to AI. Decompose into Type 1 and Type 2 tasks first.

### Good vs Bad Prompting

**Bad:** "Fix the authentication bug in user login flow"

**Good (4 focused interactions):**
1. "What's causing this error message?" (show the error)
2. "What changes are needed in auth.js?" (show the file)
3. "Write a test verifying this fix"
4. "Create an issue documenting findings"

### The 30-Minute Rule
Multiple practitioners converge on: maximum 30 minutes of coding work per request. This dramatically improves success rates versus attempting complex refactors in single prompts.

### Staged Generation Pattern
Rather than requesting complete implementations:
1. Generate stub functions first
2. Fill in one function at a time
3. Create implementation plans for human review before execution

### The Incremental Code Review Strategy
Decompose tasks to understood scope levels. Review test cases closely; code review becomes lightweight when you know expected outcomes. Each review takes seconds versus minutes when handling bulk code.

---

## 11. Tool-Specific Community Wisdom

### Claude Code Specific

**Essential Commands:**
- `/usage` -- Check rate limits and quota
- `/compact` -- Manual context compaction (better than automatic)
- `/context` -- Monitor context usage
- `/plan` (Shift+Tab) -- Plan mode for gathering context
- `/review` -- Code review
- `#` key -- Add instructions that auto-incorporate into CLAUDE.md
- `c -c` -- Continue last conversation
- `c -r` -- Resume most recent session

**Keyboard Shortcuts:**
- Escape -- Stop Claude (NOT Ctrl+C, which exits entirely)
- Escape twice -- Show list of previous messages you can jump back to
- Shift+Tab -- Toggle plan mode
- Hold Shift while dragging files -- Reference them in Claude Code
- Ctrl+V (not Cmd+V) -- Paste images from clipboard

**Pro Tricks:**
- Cmd+A/Ctrl+A on any webpage, copy, paste into Claude -- works around access restrictions
- Use `realpath` to get absolute paths for reliable file operations
- Search conversation history in `~/.claude/projects/` as .jsonl files
- Disable commit attribution in settings.json: `{"attribution": {"commit": "", "pr": ""}}`

**Status Line Script (Freek Van der Herten):**
Custom bash script showing repo name + context usage % with color coding:
- Green: <40%
- Yellow: 40-59%
- Red: >=60%

### Cursor Specific

**Essential Configuration:**
- `.cursorignore` for excluding irrelevant directories
- `.cursor/rules/*.mdc` for path-scoped rules
- Use `@` symbol for precise file references
- Set up the quartet at project start: MCPs + Rules + Memories + Auto-run

**Agent Mode vs Chat:**
- Agent ON: multi-file batch operations
- Agent OFF: single-file deep modifications
- Chat: quick questions
- Use faster models (Sonnet) for simple tasks, Opus for complex logic

**Rule-Writing Tips:**
- Frame positively (not "avoid X" but "prefer Y because Z")
- Include activation triggers (keywords, file patterns)
- Add mandatory sections for non-negotiable requirements
- Provide concrete examples of correct vs incorrect approaches
- Include uncertainty handling: "When ambiguous, present 2-3 options with pros/cons"

### Pricing Reality (Reddit Consensus)

- **Claude Pro ($20/mo)**: Exhausts after ~12 heavy prompts. "Best coding tool I've ever used, for the 45 minutes a day I can actually use it."
- **Claude Max ($100/mo)**: Primary daily-driver tier for serious users
- **Claude Max ($200/mo)**: Heavy users still hit weekly caps mid-workweek

**Cost optimization:** Use Claude Code for complex multi-file changes; cheaper tools for simple edits. Batch related changes. Use `claude --resume` to avoid context warmup tax.

---

## 12. Sources

### Blog Posts and Guides
- [Writing a Good CLAUDE.md - HumanLayer Blog](https://www.humanlayer.dev/blog/writing-a-good-claude-md)
- [How I Use Claude Code - Boris Tane](https://boristane.com/blog/how-i-use-claude-code/)
- [Agentic Coding Recommendations - Armin Ronacher](https://lucumr.pocoo.org/2025/6/12/agentic-coding/)
- [My Claude Code Setup: MCP, Hooks, Skills - Okhlopkov](https://okhlopkov.com/claude-code-setup-mcp-hooks-skills-2026/)
- [Best Practices for Claude Code - Official Docs](https://code.claude.com/docs/en/best-practices)
- [Workflows for Agentic Coding - Russ Poldrack](https://russpoldrack.substack.com/p/workflows-for-agentic-coding-and)
- [Best Practices for Coding with Agents - Cursor](https://cursor.com/blog/agent-best-practices)
- [My LLM Coding Workflow Going Into 2026 - Addy Osmani](https://addyosmani.com/blog/ai-coding-workflow/)
- [Context Engineering for Coding Agents - Martin Fowler](https://martinfowler.com/articles/exploring-gen-ai/context-engineering-coding-agents.html)
- [Agentic Coding Best Practices - Ben Houston](https://ben3d.ca/blog/agentic-coding-best-practices)
- [Claude Code 2.0 Guide - Sankalp](https://sankalp.bearblog.dev/my-experience-with-claude-code-20-and-how-to-get-better-at-using-coding-agents/)
- [Avoid These AI Coding Mistakes - PostHog](https://newsletter.posthog.com/p/avoid-these-ai-coding-mistakes)
- [Cursor Agent Tips Learned the Hard Way](https://eastondev.com/blog/en/posts/dev/20260114-cursor-agent-tips/)
- [Task Decomposition for AI - Continue Blog](https://blog.continue.dev/task-decomposition)
- [My Claude Code Setup - Freek Van der Herten](https://freek.dev/3026-my-claude-code-setup)

### GitHub Repositories
- [45+ Claude Code Tips - ykdojo](https://github.com/ykdojo/claude-code-tips)
- [Claude Code Best Practice - shanraisshan](https://github.com/shanraisshan/claude-code-best-practice)
- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code)
- [Context Engineering Intro - Cole Medin](https://github.com/coleam00/context-engineering-intro)
- [Advanced Context Engineering for Coding Agents - HumanLayer](https://github.com/humanlayer/advanced-context-engineering-for-coding-agents)
- [Claude Code Hooks Complete Guide (20+ Examples)](https://dev.to/lukaszfryc/claude-code-hooks-complete-guide-with-20-ready-to-use-examples-2026-dcg)

### GitHub Blog
- [How to Write a Great agents.md - Lessons from 2,500+ Repos](https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/)
- [Context Engineering for Reliable AI Workflows](https://github.blog/ai-and-ml/github-copilot/how-to-build-reliable-ai-workflows-with-agentic-primitives-and-context-engineering/)

### Community Discussions
- [Ask HN: How Do You Actually Use Claude Code Effectively?](https://news.ycombinator.com/item?id=44362244)
- [How I'm Productive with Claude Code - HN](https://news.ycombinator.com/item?id=47494890)
- [Getting Good Results from Claude Code - HN](https://news.ycombinator.com/item?id=44836879)
- [Cursor Forum: AI Rules and Best Practices](https://forum.cursor.com/t/ai-rules-and-other-best-practices/132291)
- [Claude Code Reddit Community Analysis - morphllm](https://www.morphllm.com/claude-code-reddit)
- [Claude Code Reddit Usage Analysis - aitooldiscovery](https://www.aitooldiscovery.com/guides/claude-code-reddit)
- [The 70% Problem: Hard Truths - Addy Osmani](https://addyo.substack.com/p/the-70-problem-hard-truths-about)

### Official Documentation
- [Claude Code Hooks Guide](https://code.claude.com/docs/en/hooks-guide)
- [Claude Code Skills](https://code.claude.com/docs/en/skills)
- [Claude Code Sub-Agents](https://code.claude.com/docs/en/sub-agents)
- [Using CLAUDE.md Files - Anthropic](https://claude.com/blog/using-claude-md-files)
- [Cursor Rules Documentation](https://docs.cursor.com/context/rules)
- [AGENTS.md Specification](https://agents.md/)

---

## Key Takeaways (The TL;DR)

1. **Research -> Plan -> Annotate -> Implement** is the universal best workflow. Never skip planning.

2. **CLAUDE.md should be under 200 lines.** Use Skills for domain-specific knowledge, Hooks for deterministic enforcement, and progressive disclosure for deep docs.

3. **Commit before every agent session.** Feature branches only. Git is your safety net.

4. **Monitor context at all times.** Compact proactively at 50-60%, never let it exceed 70% for complex work.

5. **Break tasks into 30-minute chunks.** Type 1 and 2 tasks only -- decompose Type 3 before assigning.

6. **Tests are your highest-leverage investment.** They give the agent verifiable success criteria and catch mistakes deterministically.

7. **Use hooks for anything that must happen 100% of the time.** Formatting, linting, secret protection, notifications.

8. **Senior developers benefit most.** The skill is in specifications, architecture, and knowing when to intervene -- not in typing speed.

9. **Review is the bottleneck.** Optimize for reviewability: small changes, clear diffs, incremental commits.

10. **Context engineering is the new core competency.** "A developer with clean context on a weaker model outperforms one with cluttered context on a stronger model."
