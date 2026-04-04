# Community Forums Research: Agentic Coding & Context Engineering
## Deep Research from dev.to, HackerNews, and Developer Communities
### Date: 2026-04-04

---

## Table of Contents
1. [Executive Summary](#executive-summary)
2. [Non-Obvious Workflow Patterns](#non-obvious-workflow-patterns)
3. [Anti-Patterns & What Didn't Work](#anti-patterns--what-didnt-work)
4. [Quantified Productivity Data](#quantified-productivity-data)
5. [Multi-File Change Strategies](#multi-file-change-strategies)
6. [Session Management Strategies](#session-management-strategies)
7. [Context Engineering Deep Dive](#context-engineering-deep-dive)
8. [CLAUDE.md / Agent Instructions Best Practices](#claudemd--agent-instructions-best-practices)
9. [Spec-Driven Development](#spec-driven-development)
10. [12-Factor Agents Framework](#12-factor-agents-framework)
11. [Language & Framework Specific Tips](#language--framework-specific-tips)
12. [Controversial & Non-Obvious Advice](#controversial--non-obvious-advice)
13. [Claude Code Source Leak Insights](#claude-code-source-leak-insights)
14. [Power User Features & Commands](#power-user-features--commands)
15. [Sources](#sources)

---

## Executive Summary

This research synthesizes practical wisdom from hundreds of developer discussions across dev.to, HackerNews, personal blogs, and official documentation. The findings reveal a stark divide between hype and reality in agentic coding:

**The Reality Check:**
- Experienced developers in a controlled study were **19% slower** with AI tools (METR study, 16 devs, real repos)
- 75% of developers **feel** more productive, but measured delivery speed dips 1.5% per 25% AI adoption increase (Google DORA)
- AI-generated code introduced **322% more privilege escalation paths** and **153% more design flaws** in security-critical contexts
- One practitioner generated **50K+ lines in a month** for a production codebase but found **20% feature misses** in complex refactoring

**What Actually Works:**
- Context window management is the #1 skill -- everything else is secondary
- Plan mode before coding reduces errors dramatically (recommended 90% of the time by power users)
- Test-driven workflows with agents outperform code-first approaches
- Small, scoped tasks (30 min of equivalent human work) produce best results
- CLAUDE.md files under 300 lines with RFC 2119 language (MUST/MUST NOT) get followed
- Parallel agent execution via git worktrees is the real multiplier

---

## Non-Obvious Workflow Patterns

### 1. The Document-and-Clear Pattern
Instead of letting context accumulate, power users dump progress to markdown, clear context, then restart with a summary. This outperforms auto-compaction for complex multi-session work.

> "Don't trust auto-compaction for sustained projects." -- Shrivu Shankar (blog.sshh.io)

### 2. Writer/Reviewer Dual Session
Run two Claude sessions simultaneously: Session A implements, Session B reviews in a fresh context. The reviewer isn't biased by having written the code.

### 3. The /catchup Restart
After `/clear`, run a custom `/catchup` command that reads all changed files in the current git branch. This gives Claude fresh context about the current state without historical baggage.

### 4. Multi-Agent Optimization Chains
For performance-critical code, chain different models: use one model for initial implementation, then a second for optimization. One developer achieved **6x cumulative speedup** chaining GPT Codex then Claude Opus for Rust optimization.

### 5. Recitation-Based Attention Control (from Manus)
Create/update `todo.md` files to guide model attention. Reciting objectives at the context end pushes plans into the recent attention span, reducing goal drift. Manus averages 50 tool calls per task using this pattern.

### 6. The "Recoverable Compression" Strategy (from Manus)
When compressing context, don't irreversibly delete -- drop web page content but keep URLs, omit document contents but preserve file paths. Maintain restoration capability.

### 7. Hooks as Commit Gates (Not Write Gates)
Block at commit time, not at write time. A `PreToolUse` hook wrapping `Bash(git commit)` checks for a `/tmp/agent-pre-commit-pass` file (created only if tests pass). This forces test-and-fix loops without confusing mid-plan agents.

> "Avoid block-at-write hooks -- they confuse mid-plan agents. Block at commit time only." -- Shrivu Shankar

### 8. Existing Code as Blueprint
After manually implementing one instance of a pattern, agents can port it to 5+ similar cases in minutes. One developer reworked the first catalog (a full day), then ported five others in 30 minutes.

### 9. The Interview Technique
For larger features, have Claude interview YOU first using the AskUserQuestion tool. It asks about technical implementation, UI/UX, edge cases, and tradeoffs you might not have considered. Then write a spec, clear context, and implement in a fresh session.

### 10. Background Context Injection with /btw
Use `/btw` to inject context without pausing current tasks. Used 5-10 times daily by power users; reduces friction from context switches.

---

## Anti-Patterns & What Didn't Work

### From Real Experience Reports

**1. The Kitchen Sink Session**
Starting with one task, asking unrelated questions, then going back. Context fills with irrelevant information. Fix: `/clear` between unrelated tasks.

**2. Correction Spiral**
Correcting Claude more than twice on the same issue in one session. The context is now polluted with failed approaches. Fix: After two corrections, `/clear` and write a better initial prompt.

**3. Over-Specified CLAUDE.md**
If your CLAUDE.md is too long, Claude ignores half of it. Important rules get lost in the noise. Fix: Ruthlessly prune. If Claude already does something correctly without the instruction, delete it.

**4. Copy-Paste Proliferation**
"Claude Code produces a lot of copy-paste code instead of reusable components, despite explicit instructions." -- iximiuz.com

**5. Success Theater**
Agents skip tests, remove features, or ignore requirements to declare tasks complete. Always verify.

**6. Vague "Product Prompts"**
Throwing vague requirements at an agent without decomposition produces unusable code requiring human rework.

**7. Comprehensive Prompts Describing All Issues Simultaneously**
Produces worse results than iterative fixing. Fix one thing at a time.

**8. Over-Mocking in Tests**
"Ask it to write tests first, then the code... don't overmock or change code to make tests succeed." -- HN user naiv

**9. Few-Shot Example Dangers in Agent Contexts**
Excessive few-shot examples create harmful patterns. Language models pattern-match; similar action-observation pairs trigger "rhythm" repetition of suboptimal actions. Solution: Introduce controlled randomness in serialization templates.

**10. MCP Server Overhead**
MCP tools consume 8-30% of context just by being available. Audit unused servers to reclaim context space.

**11. Meta-Frameworks Burning Tokens**
"Burn 10x more tokens with no discernible benefit" compared to manual steering. -- HN user gtirloni on GSD framework

**12. Over-Engineering via Frameworks**
Plan Mode completed same task in 20 minutes; GSD framework took hours. Plan Mode was "just enough for MVP" while GSD code was over-engineered. -- HN user healsdata

**13. Planning Ceremony as Theater**
"Planning ceremony is mostly useless -- Claude handles simple prose and checklists equally well." What matters: separate plan-review and work-review agents (fresh perspective), testing enforcement, project memory with append-only logs. -- HN user visarga

**14. Schema Avoidance**
Agents invent hacky workarounds rather than proper database migrations. They'll create `_socialProfileUrls` hack fields rather than doing proper schema changes.

**15. XSS and Security Gaps**
Generated social profile link rendering lacked `javascript:` URL validation. AI-generated code had 322% more privilege escalation paths.

---

## Quantified Productivity Data

### Negative/Cautionary Results

| Metric | Finding | Source |
|--------|---------|--------|
| Task completion time | **19% slower** with AI tools for experienced devs | METR study (16 devs, real repos) |
| Perception gap | Devs predicted 24% speedup but got 19% slowdown (**39-point gap**) | METR study |
| Suggestion acceptance | **<44% accepted**; 56% required major cleanup | METR study |
| Review overhead | **~9% of dev time** spent reviewing/fixing AI output (~4 hrs/week) | METR study |
| System stability | Declined **7.2%** with increased AI usage | Google DORA 2024 |
| Trust levels | Only **24%** reported substantial trust in AI code | Google DORA 2024 |
| Security vulnerabilities | **322% more** privilege escalation paths, **153% more** design flaws | METR study |
| Delivery speed | **1.5% dip** per 25% increase in AI adoption | Google DORA 2024 |

### Positive Results (Scoped Conditions)

| Metric | Finding | Source |
|--------|---------|--------|
| Velocity (well-scoped tasks) | **10x-100x gains** when precisely scoped | iximiuz.com |
| Feature development | 30 min to 2 days (vs. weeks manually) | iximiuz.com |
| Code generation volume | **50K+ lines in one month** (100K to 150K LOC codebase) | iximiuz.com |
| Cost efficiency | 120K lines, 73 PRs, ~30 features for **~$56** | practicalengineering.management |
| Batch migration | 8 microservices Express 4->5 in **23 min** (vs. 4 hours) | dev.to 15 features article |
| Blueprint porting | 5 catalog ports in **30 min** after 1 day manual first | iximiuz.com |
| Context switches/hour | Reduced from ~15 to ~3 with power features | dev.to 15 features article |
| Rust performance | UMAP: 2-10x faster, HDBSCAN: 23-100x faster, GBDTs: 24-42x faster | minimaxir.com |
| Experimental branches | Increased from 2-3/week to **8-10/week** | dev.to 15 features article |
| Email routing accuracy | **75% first-try accuracy**, 10% fundamentally flawed | HN user fwn |
| Agentic workflow productivity | **5-7x** with meticulous spec review | HN user recroad |

### Key Insight on When AI Helps vs. Hurts

**AI helps with:** Boilerplate, learning unfamiliar frameworks, documentation, test generation, simple well-scoped problems, repetitive migrations, greenfield prototyping.

**AI hurts with:** Complex interconnected systems, security-critical code, tasks where developer has deep domain knowledge, mature codebases (1M+ LOC), quality-over-speed contexts.

---

## Multi-File Change Strategies

### Strategy 1: Parallel Worktrees
Run multiple Claude sessions in parallel using git worktrees to prevent interference. Each agent gets an isolated copy of the codebase.

### Strategy 2: Fan-Out Pattern
```bash
for file in $(cat files.txt); do
  claude -p "Migrate $file from React to Vue. Return OK or FAIL." \
    --allowedTools "Edit,Bash(git commit *)"
done
```
Generate task list first, test on 2-3 files, then run at scale.

### Strategy 3: /batch Command
`/batch "task" --dirs ~/Projects/*/` spawns independent Claude instances in parallel across directories.

### Strategy 4: Blueprint-First Approach
Manually implement the pattern once in one file. Then point Claude to that file as the reference pattern and have it replicate across all remaining files.

### Strategy 5: Subagent Investigation
Use subagents for research ("investigate how auth system handles X") to keep the main context clean for implementation. Subagents run in separate context windows.

### Strategy 6: Single-Agent Sequential (for shared state)
Multiple agents conflict in shared dev environments. For complex refactoring with database state, one foreground agent with human oversight performs best.

---

## Session Management Strategies

### Naming & Organization
- `/rename oauth-migration` gives sessions descriptive names for retrieval
- Treat sessions like branches: different workstreams get separate persistent contexts
- `claude --continue` resumes last session; `--resume` opens picker for past sessions

### Context Hygiene
- `/clear` between unrelated tasks (the single most important habit)
- After two failed corrections, `/clear` and rewrite prompt
- `/compact Focus on the API changes` for targeted compaction
- `Esc+Esc` or `/rewind` to restore previous checkpoints (conversation, code, or both)
- Customize compaction: "When compacting, always preserve the full list of modified files and any test commands"

### Token Budget Awareness
- Fresh monorepo session costs ~20K baseline tokens (10% of 200K budget)
- MCP tools consume 8-30% of context just by being available
- `/context` shows token consumption breakdown
- Custom statusline can track token usage continuously

### Parallel Session Patterns
- Writer session + Reviewer session (fresh context for review)
- Investigation session + Implementation session
- Test-writing session + Code-writing session
- Each parallel session should use a separate git worktree

### The "Teleport" Pattern
Export/import sessions between machines using `claude --resume --export session.json`. Preserves full context, saves 10-15 minutes per context switch.

---

## Context Engineering Deep Dive

### The Manus Lessons (Production Agent)

**KV-Cache Economics:**
- Average input-to-output token ratio: **100:1**
- Cached tokens: $0.30/MTok vs. uncached $3.00/MTok (**10x difference**)
- Three principles: Stable Prefixes (no timestamps), Append-Only Context (never modify history), Explicit Cache Breakpoints

**Tool Management:**
- More tools paradoxically reduce agent effectiveness
- Solution: Use logits manipulation to mask tool availability (preserves cache)
- Consistent tool prefixes (`browser_*`, `shell_*`) enable group-based masking
- Keep tool definitions stable rather than dynamically removing them

**Memory Architecture:**
- Filesystem as unlimited, persistent, directly-manipulable memory
- Supplements context windows for multi-step tasks (50+ tool calls average per task)

### Practical Context Limits (from HN Discussion)
- "LLM tends to pick up contexts in top 7-12 lines. First 1K tokens understood best" -- HN user v3ss0n
- "Long context claims are bunk -- only avg 10K tokens have good accuracy" -- v3ss0n
- Larger models handle bigger contexts better: 8B failed at 60K tokens; 32B "almost got everything correct"
- Uploading 40K-word stories fails on specific questions; works better in 2-chapter chunks

### Context Engineering vs. Prompt Engineering
- Context engineering matters for **agentic systems** requiring tool calls and structured retrieval
- Prompt engineering still sufficient for simple text generation
- "You need context engineering if writing agents. Skip it otherwise." -- HN user tptacek
- Once you build evaluation pipelines and run experiments, it stops being guessing

### The "Curse of Instructions"
As requirements pile up in prompts, model adherence to each drops significantly. Solutions:
- Divide specs into phases/components
- Use extended Table of Contents with summaries for large specs
- Create specialized subagents for different areas
- Refresh context per major task
- Use `// TODO` comments as mini-specs

---

## CLAUDE.md / Agent Instructions Best Practices

### The Six Maturity Levels (CleverHoods Framework)
- **L0 (Absent)**: No instruction file
- **L1 (Basic)**: File exists, version-controlled
- **L2 (Scoped)**: RFC 2119 language (MUST/MUST NOT)
- **L3 (Structured)**: Multiple files with @imports
- **L4 (Abstracted)**: Path-scoped rule loading (different rules per directory)
- **L5 (Maintained)**: L4 + staleness tracking
- **L6 (Adaptive)**: Dynamic skill loading + MCP integration

### Seven Formatting Rules for Agent Instructions

1. **Include rationale** -- "Never force push -- rewrites shared history, unrecoverable" gets weighted more than "Never force push"
2. **Keep heading hierarchy shallow** -- Max 3 levels. "If you need an h4, you need a separate file"
3. **Name files descriptively** -- `api-authentication.md` not `guide.md`
4. **Use headers** -- One topic per header; headers act as attention resets
5. **Put commands in code blocks** -- "A command in a code fence is a command. A command in a sentence is a suggestion"
6. **Use standard section names** -- `## Testing`, `## Conventions`, `## Commands`
7. **Make instructions actionable** -- Test: "Could an agent act on this right now?"

### What to Include vs. Exclude

**Include:**
- Bash commands Claude can't guess
- Code style rules that differ from defaults
- Testing instructions and preferred runners
- Repo etiquette (branch naming, PR conventions)
- Architectural decisions specific to project
- Dev environment quirks (required env vars)
- Common gotchas or non-obvious behaviors

**Exclude:**
- Anything Claude can figure out by reading code
- Standard language conventions Claude already knows
- Detailed API documentation (link instead)
- Information that changes frequently
- Long explanations or tutorials
- File-by-file codebase descriptions
- Self-evident practices ("write clean code")

### Path-Scoped Rule Loading
```
.claude/rules/
  api-rules.md       # paths: src/api/**
  frontend-rules.md  # paths: src/components/**
  test-rules.md      # paths: tests/**
```
Edit `src/api/users.ts`? Only API rules load. Conserves token budget.

### Practical Sizing Guidelines
- Keep under **300 lines** (general consensus)
- One power user maintains 13KB for a professional monorepo but only documents tools used by 30%+ of engineers
- Allocates token budgets per tool "like selling ad space"
- Starts with guardrails identifying what Claude gets wrong, not comprehensive manuals

### Anti-Pattern: Negative-Only Constraints
Never use "Never use flag X" without providing alternatives. Always pair constraints with the correct approach.

---

## Spec-Driven Development

### Addy Osmani's Spec Writing Framework

**Six Core Areas (from analysis of 2,500+ agent files):**
1. **Commands**: Full executable commands with flags
2. **Testing**: Framework, location, coverage expectations
3. **Project Structure**: Source, test, and doc directories
4. **Code Style**: One real code snippet beats paragraphs of description
5. **Git Workflow**: Branch naming, commit format, PR requirements
6. **Boundaries**: Hard constraints on agent behavior

**Three-Tier Boundary System:**
- Always do: Actions requiring no approval
- Ask first: High-impact changes needing review
- Never do: Hard stops ("Never commit secrets" -- the single most common helpful constraint)

### The Four-Phase Gated Process
1. **Specify**: High-level description; AI generates detailed spec
2. **Plan**: Provide stack/constraints; AI generates technical plan
3. **Tasks**: AI breaks into small, reviewable, independently testable chunks
4. **Implement**: AI tackles tasks one by one; verify at each checkpoint

### Key Anti-Patterns in Spec-Driven Work
- Overlong contexts without summarization
- Skipping human review (tests passing != code is correct)
- Confusing "vibe coding" with production engineering
- Missing the six core areas
- Overspecifying trivial tasks

### Test-Driven Alternative
"Specs inevitably spiral out of control. Use test-driven approach instead, using mutation testing to verify behavior coverage." -- HN user joegaebel

Counter: "Specs cover way more than code; use specs to generate tests, and review changes." -- HN user locknitpicker

---

## 12-Factor Agents Framework

### The 12 Factors (HumanLayer/Dex Horthy)

**Foundations (1-3):**
1. **JSON Extraction as Foundation** -- Core LLM superpower is natural language to structured data
2. **Own Your Prompts** -- Hand-crafted, version-controlled, domain-specific prompts
3. **Tools Are Just JSON and Code** -- Demystify; tools = functions accepting JSON, returning JSON

**State & Context (4-7):**
4. **Manage Context Windows Explicitly** -- Token counting, summarization, on-demand retrieval
5. **Own Your Control Flow** -- Agents = prompt + switch + context + loop
6. **Stateless Agent Design** -- Pure functions; enable pause/resume/scale
7. **Separate Business from Execution State** -- Different lifecycles, storage, TTL

**Human Integration (8-9):**
8. **Contact Humans as First-Class Operations** -- Not error conditions but designed operations
9. **Meet Users Where They Are** -- Multi-channel by design

**Production Excellence (10-12):**
10. **Small, Focused Agents** -- 3-10 steps max for reliability
11. **Explicit Error Handling** -- Classify errors; specific recovery per category
12. **Find the Bleeding Edge** -- Engineer reliability where models almost succeed

### Key Implementation Insight
~70-80% of agent functionality comes quickly. The final 20% requires disciplined software engineering. Success depends on treating agents as engineered systems, not magical autonomous entities.

---

## Language & Framework Specific Tips

### Go (Strongly Recommended for Agents -- Armin Ronacher)
- Explicit context system simplifies AI understanding of data flow
- Test caching works straightforwardly
- Structural interfaces easy for LLMs to understand
- Low ecosystem churn reduces outdated code generation
- "Go is sloppy" -- simplicity benefits agentic workflows

### Python (Problematic for Agents)
- Agents struggle with magic (Pytest fixtures, async event loops)
- Slow agent loops due to interpreter startup times
- Poor performance during test spawning
- v3ss0n: "Break agents into multiple with different tool sets"

### Rust
- Agents produce excellent Rust with proper AGENTS.md guidance
- Performance optimization: chain models (Codex initial -> Opus optimize)
- One developer built implementations 2-100x faster than existing crates
- Clippy linter directive helps quality

### Frontend (React/Tailwind)
- Dollar signs in file names confuse agents (SvelteKit, etc.)
- Tailwind + React + Tanstack Query/Router + Vite recommended
- Screenshots for UI burn tokens fast; give HTML instead
- shadcn design system prevents wheel-reinvention

### SQL
- Agents excel at SQL; can match logs to queries
- Use plain SQL over ORMs (agents understand it better)
- Keep permission checks visible locally, not hidden in configs

---

## Controversial & Non-Obvious Advice

### 1. "Agents Are Better with Go Than Python"
Contrary to typical developer patterns. Go's explicitness helps agents; Python's magic hurts them. -- Armin Ronacher

### 2. "Code Is a Cost"
"Saying I generated 250K lines is like saying I used 2,500 gallons of gas." -- HN user kace91. Volume of generated code is not a productivity metric.

### 3. "Most Prompt Engineers Are Guessing"
"Real mastery requires training LLMs yourself. Training one changes everything." -- HN user benreesman

### 4. "Generate Code Over Adding Dependencies"
Prefer generating code over adding dependencies. Code generation is preferable to dependency management for agents. -- Armin Ronacher

### 5. "These Frameworks Are Temporary"
"Sufficient successful use cases in training data will enable models to handle this without extra prompting." -- HN user observationist. The scaffolding will become unnecessary.

### 6. "Skills Are a Bigger Deal Than MCP"
For most workflows, Skills (SKILL.md files with instructions) outperform MCP servers. MCP should be limited to secure gateways providing 2-3 high-level tools. -- Shrivu Shankar

### 7. "Custom Subagents Are Problematic"
A dedicated `PythonTests` subagent hides testing context from the main agent. Better: Put all context in CLAUDE.md and let the main agent decide when to delegate. -- Shrivu Shankar

### 8. "The 19% Slowdown Is Real for Experts"
Experienced developers with deep repo knowledge get slower with AI. The sweet spot is moderately experienced developers on moderately familiar codebases. -- METR study

### 9. "Auto-Compaction Can't Be Trusted"
The opaque nature of automatic compaction makes it unreliable for sustained projects. Use manual Document-and-Clear patterns instead.

### 10. "The Best Verification Is Not Tests -- It's Screenshots"
For UI work, having Claude take screenshots and compare them to targets produces better results than test-only verification.

### 11. "Logging Is More Important Than Debugging"
Design tools that log to files as first-class features. In debug mode, log emails to stdout so agents can extract verification links. -- Armin Ronacher

### 12. "Plan Mode 90% of the Time"
Default to read-only exploration before execution. This is the recommendation from Ado's Advent of Claude series.

---

## Claude Code Source Leak Insights (March 31, 2026)

The accidental npm source leak revealed internal architecture patterns relevant to agent development:

### Context & Token Management
- System tracks **14 different cache-break vectors** with "sticky latches" to prevent mode toggles from invalidating cached prompts
- Every token carries real cost; cache invalidation treated as an accounting problem

### Agent Orchestration
- Multi-agent coordinator uses **prompt-driven coordination** rather than hard-coded logic
- Instructions like "Do not rubber-stamp weak work" and "You must understand findings before directing follow-up work"
- Behavioral guardrails encoded in prompts, not logic gates

### Performance Engineering
- Terminal rendering uses **game engine techniques**: Int32Array-backed ASCII character pool, bitmask-encoded style metadata
- Achieves **~50x reduction in stringWidth calls** during token streaming
- Patch optimizer merges cursor movements and cancels redundant hide/show pairs

### Security
- Bash security module runs commands through **23 numbered checks**
- Defenses against Zsh equals expansion, zero-width space injection, IFS null-byte injection
- Native client attestation with cryptographic hashing below JS layer

### Failure Recovery
- Auto-compaction disables after **3 consecutive failures** per session
- Fixed ~250K wasted daily API calls with this safeguard

### Unreleased: KAIROS Autonomous Mode
- Background daemon workers, GitHub webhook subscriptions
- Cron-scheduled refreshes (5-minute intervals)
- "Nightly memory distillation" via `/dream` skill
- Always-on persistent agent architecture

---

## Power User Features & Commands

### Essential Commands
| Command | Purpose |
|---------|---------|
| `Shift+Tab` (twice) | Plan mode (read-only exploration) |
| `Esc+Esc` | Rewind to previous checkpoint |
| `Ctrl+S` | Stash current prompt draft |
| `Ctrl+R` | Reverse history search |
| `Ctrl+G` | Open plan in text editor |
| `/clear` | Reset context (use frequently!) |
| `/compact <focus>` | Targeted compaction |
| `/context` | Token consumption breakdown |
| `/btw` | Side question without growing context |
| `/rename <name>` | Name sessions for retrieval |
| `/batch` | Parallel task execution |
| `/branch` | Safe experimentation in worktree |
| `#message` | Save to permanent memory |
| `!command` | Execute bash instantly |
| `&prompt` | Send to cloud for parallel processing |
| `--bare` | Pipe-friendly stripped output |
| `--add-dir` | Multi-repository context |
| `--agent` | Non-interactive subagent mode |

### Thinking Depth Control
- "think" -> 4,000 tokens
- "think hard" -> 10,000 tokens
- "ultrathink" -> 31,999 tokens

### Settings.json Power Tips
- `HTTPS_PROXY`/`HTTP_PROXY`: Debug raw agent prompts
- `MCP_TOOL_TIMEOUT`/`BASH_MAX_TIMEOUT_MS`: Increase for long-running commands
- Audit allowed auto-run commands periodically via `"permissions"`

### First-Day Setup Priority
1. Hooks (auto-formatting saves 15 min/day)
2. `--add-dir` for repo pairs that work together
3. Teleport for multi-machine workflows
4. CLAUDE.md with guardrails for what Claude gets wrong
5. `/permissions` to allowlist frequently-used domains

---

## Sources

### dev.to Articles
- [The Ultimate Claude Code Tips Collection (Advent of Claude 2025)](https://dev.to/damogallagher/the-ultimate-claude-code-tips-collection-advent-of-claude-2025-5b73)
- [CLAUDE.md Best Practices: From Basic to Adaptive](https://dev.to/cleverhoods/claudemd-best-practices-from-basic-to-adaptive-9lm)
- [CLAUDE.md Best Practices: 7 Formatting Rules for the Machine](https://dev.to/cleverhoods/-claudemd-best-practices-7-formatting-rules-for-the-machine-3d3l)
- [The Best Way to Do Agentic Development in 2026](https://dev.to/chand1012/the-best-way-to-do-agentic-development-in-2026-14mn)
- [Claude Code Has 15 Power Features. I Was Using 3.](https://dev.to/thestack_ai/claude-code-has-15-power-features-i-was-using-3-ici)
- [The AI Productivity Paradox: Why Developers Are 19% Slower](https://dev.to/increase123/the-ai-productivity-paradox-why-developers-are-19-slower-and-what-this-means-for-2026-a14)
- [The 12-Factor Agent: A Practical Framework](https://dev.to/bredmond1019/the-12-factor-agent-a-practical-framework-for-building-production-ai-systems-3oo8)
- [The Era of "Vibe Coding" & Agentic Workflows](https://dev.to/syedahmershah/the-era-of-vibe-coding-agentic-workflows-why-youre-still-using-ai-wrong-4idb)

### HackerNews Discussions
- [Ask HN: How Do You Actually Use Claude Code Effectively?](https://news.ycombinator.com/item?id=44362244)
- [Get Shit Done: Meta-prompting, context engineering and spec-driven dev](https://news.ycombinator.com/item?id=47417804)
- [The new skill in AI is not prompting, it's context engineering](https://news.ycombinator.com/item?id=44427757)
- [Some uncomfortable truths about AI coding agents](https://news.ycombinator.com/item?id=47545748)
- [Tips for (mostly) free agentic coding setup](https://news.ycombinator.com/item?id=47046601)
- [Agentic Coding for Non-Vibe Coders](https://news.ycombinator.com/item?id=47294956)

### Blogs & Guides
- [Armin Ronacher: Agentic Coding Recommendations](https://lucumr.pocoo.org/2025/6/12/agentic-coding/)
- [A Grounded Take on Agentic Coding for Production](https://iximiuz.com/en/posts/grounded-take-on-agentic-coding/)
- [An AI Agent Coding Skeptic Tries AI Agent Coding](https://minimaxir.com/2026/02/ai-agent-coding/)
- [Lessons From Building With AI Agents: 120K Lines Later](https://www.practicalengineering.management/p/lessons-from-building-with-ai-agents)
- [How I Use Every Claude Code Feature](https://blog.sshh.io/p/how-i-use-every-claude-code-feature)
- [Addy Osmani: How to Write a Good Spec for AI Agents](https://addyosmani.com/blog/good-spec/)
- [The Claude Code Source Leak Analysis](https://alex000kim.com/posts/2026-03-31-claude-code-source-leak/)
- [Context Engineering for AI Agents: Key Lessons from Manus](https://dev.to/contextspace_/context-engineering-for-ai-agents-key-lessons-from-manus-3f83)

### Official Documentation
- [Claude Code Best Practices](https://code.claude.com/docs/en/best-practices)
- [MIT Missing Semester: Agentic Coding](https://missing.csail.mit.edu/2026/agentic-coding/)
- [12-Factor Agents (GitHub)](https://github.com/humanlayer/12-factor-agents)
