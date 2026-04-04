# Agentic Coding Workflow Patterns -- Deep Research

**Date:** 2026-04-04
**Scope:** How power users actually work with AI coding agents day-to-day -- not config files, but real workflow patterns.

---

## Table of Contents

1. [The Research-Plan-Implement (RPI) Workflow](#1-the-research-plan-implement-rpi-workflow)
2. [Plan Mode vs Auto Mode vs Just Coding](#2-plan-mode-vs-auto-mode-vs-just-coding)
3. [Session Management -- When to /clear, /compact, and Start Fresh](#3-session-management)
4. [Task Decomposition for Agents](#4-task-decomposition-for-agents)
5. [Subagent Patterns -- When and How](#5-subagent-patterns)
6. [Worktree-Based Parallel Development](#6-worktree-based-parallel-development)
7. [Parallel Agent Sessions (Agent Teams)](#7-parallel-agent-sessions-agent-teams)
8. [Code Review Workflows with AI](#8-code-review-workflows-with-ai)
9. [TDD Workflows with AI Agents](#9-tdd-workflows-with-ai-agents)
10. [Debugging and Failing Tests](#10-debugging-and-failing-tests)
11. [Multi-File Refactoring Strategies](#11-multi-file-refactoring-strategies)
12. [Context Budget Management (The 20% Rule)](#12-context-budget-management)
13. [Harness Engineering](#13-harness-engineering)
14. [Spec-Driven Development (SDD)](#14-spec-driven-development)
15. [Boris Cherny's Workflow (Claude Code Creator)](#15-boris-chernys-workflow)
16. [Addy Osmani's LLM Coding Workflow](#16-addy-osmanis-workflow)
17. [Anthropic's C Compiler Project (16 Parallel Agents)](#17-anthropics-c-compiler-project)
18. [How Top Companies Use AI Agents Internally](#18-how-top-companies-use-ai-agents)
19. [The 12-Factor Agent Principles](#19-the-12-factor-agent-principles)
20. [Hooks and Automation Patterns](#20-hooks-and-automation-patterns)
21. [Key Takeaways and Meta-Patterns](#21-key-takeaways-and-meta-patterns)

---

## 1. The Research-Plan-Implement (RPI) Workflow

**Origin:** Introduced by Dex Horthy / HumanLayer. Now widely adopted as the canonical agentic coding workflow.

### The Three Phases

**Phase 1: Research (Read-Only)**
- Document what exists today -- nothing more
- Output: a research document with git metadata, file/line references, flow descriptions, key components, open questions
- Validation: FAR scale (Factual, Actionable, Relevant) -- every discovery must be fact-based, not assumed
- The agent reads code, greps for patterns, traces call chains, documents dependencies
- Human reviews: "Is this map of the codebase correct?"

**Phase 2: Plan (No Code Changes)**
- Translate research into a phased implementation plan
- Output: markdown document with atomic tasks, each with checkbox, each independently testable
- Example phases: Phase 1: "Add bulk selection UI." Phase 2: "Create confirmation modal." Phase 3: "Implement backend bulk delete API."
- Each phase passes FACTS validation (Feasible, Atomic, Complete, Testable, Scoped)
- Human reviews: "Is this the right plan? Any missing steps?"

**Phase 3: Implement (Mechanical Execution)**
- Execute the plan step-by-step with verification
- This phase should feel "intentionally boring and mechanical"
- If implementation feels creative, something upstream is missing
- Quality gates (tests, builds, lints) must pass after each task
- No hallucinations, no scope creep -- just focused execution

### Why RPI Works
- Slower than jumping straight to code, but quality is dramatically higher
- Forces the agent to understand before acting
- Human checkpoints between phases catch errors early
- You stop directing AI step-by-step and start designing workflows that converge on correct solutions
- The agent's job is systematic execution; the human's job is defining "done" and validating at checkpoints

### Extended Variants
- **QRSPI** (Question, Research, Spec, Plan, Implement) -- adds a question phase for clarification and a spec phase for formal requirements
- **RPI Strategy (Patrick Robinson)** -- formalized with templates and validation checklists

**Sources:**
- [RPI Pattern -- Goose Docs](https://block.github.io/goose/docs/tutorials/rpi/)
- [RPI -- Kilo AI Agentic Engineering](https://path.kilo.ai/introduction/patterns/rpi/)
- [RPI Strategy -- Patrick Robinson](https://patrickarobinson.com/blog/introducing-rpi-strategy/)
- [QRSPI -- Alex Lavaee](https://alexlavaee.me/blog/from-rpi-to-qrspi/)
- [HumanLayer Advanced Context Engineering](https://github.com/humanlayer/advanced-context-engineering-for-coding-agents)

---

## 2. Plan Mode vs Auto Mode vs Just Coding

### Plan Mode (Read-Only Exploration)
- Claude reads files and proposes changes but executes nothing
- **When to use:**
  - Before multi-file changes
  - Unfamiliar codebase areas
  - Architectural decisions
  - Large refactors where the cost of a wrong first move is high
- **How Boris uses it:** Start in Plan mode, iterate until the plan is good, then switch to auto-accept edits mode. Claude can often one-shot the implementation from a good plan.
- **Key insight:** Plan mode prevents Claude from spending 20 minutes confidently solving the wrong problem

### Auto Mode (Supervised Automation)
- Middle path: fewer interruptions, safety classifier checks each action
- **When to use:**
  - Multi-file refactors
  - Dependency updates
  - Test-fix loops
  - Long-running repo-scoped work that stays inside a trusted branch
- **When NOT to use:**
  - Production infrastructure changes
  - Destructive data operations
  - Unclear external system interactions
- **Cost note:** Classifier calls consume additional tokens

### Just Prompting (Direct Execution)
- Default mode for small, well-understood tasks
- Good for: single-file changes, quick fixes, known patterns
- Risk: Claude may solve the wrong problem on complex tasks

### Decision Heuristic
```
Is the task < 1 file and well-understood?  --> Just code it
Is the task multi-file or unfamiliar?       --> Plan mode first
Is the task a long grind (refactor/tests)?  --> Plan then Auto mode
```

**Sources:**
- [Claude Code Common Workflows](https://code.claude.com/docs/en/common-workflows)
- [Auto Mode -- Claude Blog](https://claude.com/blog/auto-mode)
- [Plan Mode in VS Code -- Medium](https://medium.com/@automateandtweak/how-to-use-plan-mode-in-claude-code-vs-code-the-smart-way-to-code-with-ai-a93d1b437646)

---

## 3. Session Management

### When to /clear
- Switching to a completely different part of the codebase
- Context is "poisoned" with incorrect assumptions the model keeps reverting to
- Total task pivot (e.g., backend work to unrelated frontend feature)
- The next task doesn't meaningfully depend on the last ~20 messages
- **Warning:** /clear permanently deletes all session history -- no recovery. Save needed context to CLAUDE.md first
- **Pro tip:** Use `/rename` before `/clear` so you can `/resume` later

### When to /compact
- Completing a distinct phase of work (good checkpoint)
- Context is 60-70% full
- Some prior context is valuable but some is noise -- use `/compact` with a focused prompt
- **Critical insight:** Manual compaction while there's still headroom produces better summaries than waiting for degradation

### Decision Matrix
```
No prior context needed          --> /clear
Prior context mostly relevant    --> /compact
Some useful, some noise          --> /compact with focused prompt
Starting genuinely new work      --> /clear
```

### The "Reset Every 20" Rule
A widely-cited heuristic: reset context every ~20 iterations. Performance craters after 20 back-and-forth exchanges. A fresh start equals fresh code.

### Session Architecture
- **One task per session** is the ideal
- Multiple focused sessions beat one long session
- Don't fight context accumulation -- plan around it
- Use CLAUDE.md for persistence across sessions

**Sources:**
- [Claude Code Context Management Guide -- SitePoint](https://www.sitepoint.com/claude-code-context-management/)
- [Session Management -- Steve Kinney](https://stevekinney.com/courses/ai-development/claude-code-session-management)
- [Context Management Strategies -- Alex Merced](https://iceberglakehouse.com/posts/2026-03-context-claude-code/)

---

## 4. Task Decomposition for Agents

### Core Principle
If you can't articulate the task in ONE sentence with ONE measurable outcome, split it.

### Decomposition Strategy
1. **Identify independent workstreams** -- what can run in parallel vs. what must be sequenced
2. **Make tasks atomic** -- each task should be completable and testable in isolation
3. **Define "done" for each task** -- measurable verification criteria
4. **Order by dependency** -- some tasks unlock others

### When to Use Multiple Agents
- Task is too large for a single context window
- Multiple independent workstreams exist
- Speed is a priority and parallel execution helps
- Different domains of expertise are needed (frontend/backend/database)

### Practical Patterns
- **Domain-Based Splitting:** Frontend agent, Backend agent, Database agent
- **Phase-Based Splitting:** Research agent, Planning agent, Implementation agent, Testing agent
- **File-Based Splitting:** Agent per module or directory

### Task Sizing Rule
Tasks should be small enough that:
- The agent can hold the full context
- You can understand the output
- Tests can verify correctness
- Failure can be isolated and debugged

### Tools Available
- Claude Code's Tasks API: TaskCreate, TaskUpdate, TaskList, TaskDelete
- CLAUDE_CODE_TASK_LIST_ID env var for multi-session coordination
- Third-party orchestrators (claude-flow, claude-code-workflow-orchestration)

**Sources:**
- [Task Decomposition Strategy -- MCP Market](https://mcpmarket.com/tools/skills/task-decomposition-strategy)
- [Claude Code Agent Teams -- MindStudio](https://www.mindstudio.ai/blog/what-is-claude-code-agent-teams)
- [Claude Code Experiment: Atomic Task Breakdown -- Medium](https://medium.com/@levi_stringer/claude-code-one-shot-or-slow-down-bcb6283990d0)

---

## 5. Subagent Patterns

### What Subagents Are
Separate Claude instances spawned by the main agent for specific jobs. Each operates in its own context window with a custom system prompt, specific tool access, and independent permissions.

### Hub-and-Spoke Model
Main agent (hub) coordinates specialized subagents (spokes). Each subagent works independently and returns results. The main agent's context stays clean.

### Key Patterns

**1. Research Delegation**
- Spawn a subagent to research a codebase area
- Returns a summary, not raw file contents
- Keeps main context clean for planning/implementation

**2. Domain-Based Parallel Delegation**
```
Frontend agent  --> React components, UI state, forms
Backend agent   --> API routes, server actions, business logic
Database agent  --> Schema, migrations, queries
```

**3. Explore-Plan-Execute**
- Subagent explores the codebase
- Main agent reviews findings and plans
- Subagent(s) execute implementation

### Configuration
- Project agents: `.claude/agents/` (repo-specific, shareable with team)
- User agents: `~/.claude/agents/` (across all projects)
- Defined as Markdown files with YAML frontmatter
- Claude delegates automatically based on the `description` field

### Limitations
- Subagents cannot spawn other subagents (no nesting)
- For nested delegation, use Skills or chain subagents from main conversation
- Subagents have their own context window -- they don't share the parent's

### When to Use Subagents vs. Just Doing It
```
Simple task, fits in context     --> Just do it
Research-heavy task              --> Subagent for research
Multi-domain task                --> Parallel subagents
Context getting full             --> Delegate to subagent to keep main clean
```

**Sources:**
- [Create Custom Subagents -- Claude Code Docs](https://code.claude.com/docs/en/sub-agents)
- [Sub-Agent Delegation Patterns -- Medium](https://medium.com/@richardhightower/claude-code-subagents-and-main-agent-coordination-a-complete-guide-to-ai-agent-delegation-patterns-a4f88ae8f46c)
- [Parallel vs Sequential Sub-Agents -- ClaudeFast](https://claudefa.st/blog/guide/agents/sub-agent-best-practices)
- [VoltAgent Awesome Subagents](https://github.com/VoltAgent/awesome-claude-code-subagents)

---

## 6. Worktree-Based Parallel Development

### The Core Idea
Git worktrees let you create multiple working directories from a single repository, each linked to a different branch. Combined with AI agents, this enables true parallel development without branch-switching overhead or file conflicts.

### Practical Setup
1. Create worktrees: `git worktree add ../feature-auth feature/auth`
2. Open each worktree in a separate terminal tab
3. Run an independent Claude Code session in each
4. Each session gets its own git checkout, its own branch, its own context

### Why This Matters for AI
- When an AI agent is working on one feature, you don't want it accidentally referencing or modifying files from another feature branch
- All worktrees share the same Git history -- commits in any worktree are available to all others
- No context bleed between features
- Equivalent to assigning each feature to a different team member

### Boris Cherny's Setup
- 5 git checkouts (worktrees) numbered 1-5
- 5 Claude Code terminal tabs
- System notifications when any Claude needs input
- Plus 5-10 additional sessions on claude.ai/code

### Claude Code Built-In Support
- Subagents support `isolation: worktree` in frontmatter for automatic worktree isolation
- VS Code added worktree support in July 2025

### Tooling Ecosystem
- **agentree**: Quick worktree creation for AI workflows
- **git-worktree-runner (CodeRabbit)**: Works with Claude and other AI tools
- **worktree-cli**: MCP server integration for Claude Code

**Sources:**
- [Git Worktrees Changed My AI Agent Workflow -- Nx Blog](https://nx.dev/blog/git-worktrees-ai-agents)
- [From 3 Worktrees to N -- Laurent Kempe](https://laurentkempe.com/2026/03/31/from-3-worktrees-to-n-ai-powered-parallel-development-on-windows/)
- [Git Worktrees for Multi-Feature Development -- Nick Mitchinson](https://www.nrmitchi.com/2025/10/using-git-worktrees-for-multi-feature-development-with-ai-agents/)
- [Parallel AI Coding with Git Worktrees -- Steve Kinney](https://stevekinney.com/courses/ai-development/git-worktrees)

---

## 7. Parallel Agent Sessions (Agent Teams)

### Architecture
Multiple Claude instances work in parallel on a shared codebase without active human intervention. Different from subagents (which are within a single session) -- agent teams are independent sessions that coordinate.

### Coordination Mechanisms
- **Shared task list**: CLAUDE_CODE_TASK_LIST_ID env var
- **Lock-file mechanism**: Agents claim tasks to avoid duplication
- **Git-based coordination**: Each agent works on its own branch, merges back
- **Docker isolation**: Each agent in its own container (Anthropic's approach)

### Real-World Example: Anthropic's C Compiler
- 16 parallel Claude agents
- ~2,000 sessions, $20,000 in API costs
- Produced 100,000-line Rust-based C compiler
- Can compile Linux kernel, QEMU, FFmpeg, SQLite, PostgreSQL, Redis
- 99% pass rate on GCC torture test suite

### Key Insight from the C Compiler Project
> "Validation became the primary control plane."

Agents relied on robust test suites and "known-good oracles" to verify progress. Without strong validation, parallel agents diverge and produce conflicting or broken code.

### Practical Tips
- Each agent needs its own isolated environment
- Strong test suites are non-negotiable for parallel work
- Include progress reporting and timeout mechanisms
- Claude "can't tell time" -- left alone, it will spend hours running tests instead of making progress. The harness needs to enforce time limits.

**Sources:**
- [Building a C Compiler with Parallel Claudes -- Anthropic](https://www.anthropic.com/engineering/building-c-compiler)
- [Multi-Agent Orchestration: 10+ Claude Instances -- DEV](https://dev.to/bredmond1019/multi-agent-orchestration-running-10-claude-instances-in-parallel-part-3-29da)
- [Embracing the Parallel Coding Agent Lifestyle -- Simon Willison](https://simonwillison.net/2025/Oct/5/parallel-coding-agents/)
- [How to Run Claude Code in Parallel -- Ona](https://ona.com/stories/parallelize-claude-code)

---

## 8. Code Review Workflows with AI

### AI-First Review Flow (2026 Standard)
1. Developer opens PR
2. AI tool immediately analyzes changes (within seconds)
3. AI provides feedback on bugs, security, performance, style
4. Human reviewer focuses on architecture, business logic, trade-offs
5. AI catches what humans miss; humans catch what AI can't judge

### Claude Code for Self-Review
- Before submitting: ask Claude to review your diff
- `claude "Review the changes in this branch against main. Focus on correctness, edge cases, and potential regressions."`
- Claude reads the diff, traces affected code paths, identifies risks

### Multi-Agent Review Pipeline
```
Planner agent   --> Verifies alignment with spec
Security agent  --> Checks for vulnerabilities
Test agent      --> Validates test coverage
Style agent     --> Enforces conventions
```

### Key Insight
AI review catches issues before merge at scale -- but human oversight on architecture and business logic remains critical. The highest-impact integration points:
- AI-assisted code review (catches issues before merge)
- AI test generation (increases coverage without manual effort)
- AI pair programming (accelerates coding 25-50% on routine tasks)

**Sources:**
- [AI-Powered Code Review 2026 -- Prepare Frontend](https://preparefrontend.com/blog/blog/ai-powered-code-review-quality-assurance-2026)
- [5 AI Code Review Predictions 2026 -- Qodo](https://www.qodo.ai/blog/5-ai-code-review-pattern-predictions-in-2026/)
- [AI Pair Programming -- Felo](https://felo.ai/blog/ai-pair-programming-claude-code/)

---

## 9. TDD Workflows with AI Agents

### Why TDD + AI Is Powerful
- Tests provide an explicit, verifiable target for the AI
- The automated feedback loop means Claude can self-correct and iterate faster
- TDD channels the agent's capabilities into producing robust, testable code
- Claude performs best when it can verify its own work

### The Red-Green-Refactor Cycle with Claude
1. **Red:** Describe desired functionality, ask Claude to write tests first. Confirm tests fail.
2. **Green:** Ask Claude to write minimal code to pass the tests
3. **Refactor:** Clean up while keeping tests green

### Critical Insight: Context Pollution
Claude's default behavior is implementation-first. When you try to force TDD in a single context window, the implementation "bleeds" into the test logic. Solutions:
- Use explicit prompting: "Write ONLY the tests. Do NOT write any implementation."
- Use separate subagents for test writing vs. implementation
- Use the Double Loop approach (acceptance tests outer, unit tests inner)

### Double Loop TDD (ATDD/TDD)
- Outer loop: One acceptance test RED at a time
- Inner loop: One unit test RED at a time
- Provides clear structure for both human and AI

### Practical Workflow
```
1. Write spec / describe feature
2. Ask Claude to write failing test
3. Verify test fails (Red)
4. Ask Claude to make it pass with minimal code (Green)
5. Ask Claude to refactor (Refactor)
6. Repeat
```

### Available Tools
- `/tdd` slash command skill (custom or from aibuilder.sh)
- TDD Agent -- Double Loop Claude Code Agent
- claude-flow TDD integration

**Sources:**
- [TDD with Claude Code -- Steve Kinney](https://stevekinney.com/courses/ai-development/test-driven-development-with-claude)
- [Forcing Claude Code to TDD -- alexop.dev](https://alexop.dev/posts/custom-tdd-workflow-claude-code-vue/)
- [Taming GenAI Agents with TDD -- Nathan Fox](https://www.nathanfox.net/p/taming-genai-agents-like-claude-code)
- [TDD with Claude -- Ultimate Guide](https://github.com/FlorianBruniaux/claude-code-ultimate-guide/blob/main/guide/workflows/tdd-with-claude.md)

---

## 10. Debugging and Failing Tests

### Systematic Debugging Methodology (4-Phase)
Achieves ~95% first-time fix rate vs ~40% with ad-hoc approaches.

**Phase 1: Observe**
- Read the full error message and stack trace
- Identify which assertion failed and why
- Check test setup correctness
- Verify test data and mocks/fixtures

**Phase 2: Hypothesize**
- Form hypotheses about root cause (not symptoms)
- Never apply symptom-focused patches that mask underlying problems

**Phase 3: Verify**
- Test each hypothesis systematically
- Use Plan Mode first for complex bugs -- Claude analyzes errors without making changes

**Phase 4: Fix and Prevent**
- Fix the root cause
- Ask Claude to explain WHY the bug occurred
- Update CLAUDE.md with relevant guidelines
- Add regression tests

### Core Principle
> "No fixes without root cause investigation first."

Understanding WHY something fails before attempting to fix it is the most important principle. Resist the urge to let Claude start patching immediately.

### Practical Tips
- Start by pasting the full error message and stack trace
- Ask Claude to analyze before acting
- Use `/clear` if Claude keeps reverting to an incorrect hypothesis
- For flaky tests: ask Claude to identify non-deterministic factors

**Sources:**
- [Systematic Debugging Skill](https://github.com/ChrisWiles/claude-code-showcase/blob/main/.claude/skills/systematic-debugging/SKILL.md)
- [Claude Code Debugging Guide](https://github.com/RiyaParikh0112/claude-code-playbook/blob/main/docs/troubleshooting/debugging-guide.md)
- [Fix Software Bugs Faster with Claude](https://claude.com/blog/fix-software-bugs-faster-with-claude)
- [Best Practices -- Claude Code Docs](https://code.claude.com/docs/en/best-practices)

---

## 11. Multi-File Refactoring Strategies

### Why Large Refactors Fail with AI
- Treated as monolithic tasks -- agents need clear, bounded work
- Context window exhaustion before completion
- No validation between steps
- Conflicting changes across files

### Multi-Step Refactoring Workflow
1. **Impact Planning:** Identify all affected files and symbols
2. **Dependency Analysis:** Identify independent components (can be parallelized)
3. **Suggestion Phase:** Generate proposed diffs per file
4. **Approval and Execution:** Human approves, agent applies
5. **Validation:** Tests and type checking after each step
6. **Rollback Capability:** For failed refactors

### Multi-Agent Architecture for Refactoring
```
Orchestrator Agent  --> Manages overall workflow
Architect Agent     --> Analyzes dependencies, plans sequence
Implementer Agents  --> Execute changes (can be parallel for independent files)
Validator Agent     --> Runs tests, type checking after each change
```

### Key Success Factors
- Run in small batches, validate diffs, refine prompts, scale incrementally
- **80-90% automation with human checkpoints outperforms 100% automation**
- Each change should be independently verifiable
- Use Plan Mode to map the refactor before touching any code

### Practical Heuristic
```
< 3 files       --> Single agent, direct execution
3-10 files       --> Plan mode first, then sequential execution
10-50 files      --> Multi-agent with domain splitting
50+ files        --> Parallel agents with worktree isolation
```

**Sources:**
- [Automate Multi-File Refactoring with AI -- Augment Code](https://www.augmentcode.com/learn/automate-multi-file-code-refactoring-with-ai-agents-a-step-by-step-guide)
- [Parallel AI Agents for Massive Refactors -- Tessl](https://tessl.io/blog/use-automated-parallel-ai-agents-for-massive-refactors/)
- [AI Large-Scale Refactoring -- Atlassian](https://www.atlassian.com/blog/developer/how-to-effectively-utilise-ai-to-enhance-large-scale-refactoring)
- [Enterprise Multi-File Refactoring -- Augment Code](https://www.augmentcode.com/tools/enterprise-multi-file-refactoring-why-ai-breaks-at-scale)

---

## 12. Context Budget Management

### The 20% Rule
> Never use the final 20% of your context window for complex, multi-file tasks.

Memory-intensive operations (refactoring, feature implementation, debugging) require substantial working memory to track relationships between components. Quality notably declines when approaching context limits.

### Context Budget Strategy
```
0-60%    --> Full performance. Do complex work here.
60-70%   --> Run /compact proactively. Good checkpoint.
70-80%   --> Finish current task, then /compact or /clear
80-100%  --> Quality degradation zone. Only simple tasks.
Last 20% --> Reserved. Do NOT attempt complex work.
```

### Practical Token Savings (40-70% reduction)
1. **Pre-session:** Exclude build artifacts with .claudeignore
2. **CLAUDE.md:** Keep under 200 lines. Use @imports for details.
3. **Progressive disclosure:** Don't load everything upfront. Tell Claude where to find info.
4. **Subagent delegation:** Heavy research in subagents keeps main context clean
5. **Scoped tasks:** One task per session
6. **Proactive /compact:** At task completion checkpoints, not as a last resort

### The "Reset Every 20" Heuristic
Track iterations. Reset proactively around 20 back-and-forth exchanges rather than waiting for quality degradation. Fresh start = fresh code.

### CLAUDE.md for Persistence
When Claude starts fresh (after /clear or new terminal), CLAUDE.md ensures it has standing context immediately without burning tokens on setup messages. This is the bridge between session brevity and continuity.

**Sources:**
- [Claude Code Token Management Hacks -- MindStudio](https://www.mindstudio.ai/blog/claude-code-token-management-hacks-2)
- [Claude Code Token Management: Save 50-70% -- Richard Porter](https://richardporter.dev/blog/claude-code-token-management)
- [Context Window -- MindStudio](https://www.mindstudio.ai/blog/context-window-claude-code-manage-consistent-results)
- [Context Management -- ClaudeFast](https://claudefa.st/blog/guide/mechanics/context-management)

---

## 13. Harness Engineering

### Definition
> Agent = Model + Harness

The harness is everything in an AI agent except the model itself. It channels the model's power productively.

### Two Control Types

**Guides (Feedforward Controls)** -- Anticipate unwanted outputs and prevent them
- CLAUDE.md instructions
- System prompts
- Skill descriptions
- Tool schemas and constraints

**Sensors (Feedback Controls)** -- Allow the agent to self-correct
- Test suites
- Linters
- Type checkers
- Build verification
- Screenshots for UI work

### Impact
LangChain's coding agent jumped from 52.8% to 66.5% on Terminal Bench 2.0 -- from Top 30 to Top 5 -- by changing nothing about the model, only the harness.

### Progressive Disclosure in Harness Design
- Agents start with a small, stable entry point
- Taught where to look for more information
- Load domain knowledge only when triggered
- ClaudeFast's Code Kit recovers ~15,000 tokens per session using this pattern

### Key Components
- Context engineering (what info the agent sees)
- Evaluation (how you measure agent performance)
- Observability (how you see what the agent is doing)
- Orchestration (how you coordinate multiple agents)
- Safe autonomy (guardrails and permissions)
- Software architecture (how the system is structured)

**Sources:**
- [Harness Engineering -- Martin Fowler](https://martinfowler.com/articles/harness-engineering.html)
- [Skill Issue: Harness Engineering -- HumanLayer](https://www.humanlayer.dev/blog/skill-issue-harness-engineering-for-coding-agents)
- [Building Effective AI Coding Agents -- arXiv](https://arxiv.org/abs/2603.05344)
- [Harness Engineering -- OpenAI](https://openai.com/index/harness-engineering/)
- [Anatomy of an Agent Harness -- LangChain](https://blog.langchain.com/the-anatomy-of-an-agent-harness/)

---

## 14. Spec-Driven Development (SDD)

### The Five-Stage SDD Workflow
1. **Spec Authoring** -- Write a structured PRD, not a loose pile of notes
2. **Planning** -- AI analyzes requirements, generates design and implementation plans
3. **Task Breakdown** -- Coding agent breaks spec into actionable, atomic tasks
4. **Implementation** -- Agent tackles tasks one by one (or in parallel)
5. **Validation** -- Drift detection ensures implementation matches spec

### How to Write a Good Spec (Addy Osmani)
- Treat it as a structured document with clear sections
- Include: goals, non-goals, success criteria, technical constraints, API contracts, edge cases
- Embed the spec in workflows so the agent can't proceed until validated
- Changes propagate automatically to task breakdowns and tests

### Tools Available
- **Amazon Kiro**: Built-in SDD workflow with predefined phases
- **GitHub Spec-Kit**: Open-source toolkit for SDD
- **Claude Code / Cursor**: More flexible, requires finding your own workflow

### Key Benefits
- Each task is something you can implement and test in isolation
- Review focused changes, not thousand-line code dumps
- DORA reports 90% developer adoption with 80%+ reporting benefits
- DX measured 3.6 hours per week saved for structured AI users

**Sources:**
- [Spec-Driven Development -- Thoughtworks](https://www.thoughtworks.com/en-us/insights/blog/agile-engineering-practices/spec-driven-development-unpacking-2025-new-engineering-practices)
- [How to Write a Good Spec for AI Agents -- Addy Osmani](https://addyosmani.com/blog/good-spec/)
- [Spec-Driven Development with AI -- GitHub Blog](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)
- [SDD Tools: Kiro, Spec-Kit, Tessl -- Martin Fowler](https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html)
- [Mastering SDD -- Augment Code](https://www.augmentcode.com/guides/mastering-spec-driven-development-with-prompted-ai-workflows-a-step-by-step-implementation-guide)

---

## 15. Boris Cherny's Workflow

Boris Cherny created Claude Code and ships 20-30 PRs/day (~100/week).

### Setup
- 5 parallel Claude Code terminal instances, each with its own git checkout (worktree)
- Tabs numbered 1-5 for easy reference
- System notifications when any Claude needs input
- 5-10 additional sessions on claude.ai/code beyond terminal

### Workflow Pattern
1. **Plan first:** Start in Plan Mode, iterate until the plan is good
2. **Execute:** Switch to auto-accept edits mode. Claude often one-shots the implementation.
3. **Verify:** Claude must have a way to verify its work (tests, type checks, builds)
4. **Ship:** Uses `/commit-push-pr` slash command daily

### Key Principles
- **Verification is the #1 lever:** "The most important thing to get great results out of Claude Code is to give Claude a way to verify its work. If Claude has that feedback loop, it will 2-3x the quality of the final result."
- **CLAUDE.md is shared and living:** Checked into git, whole team contributes multiple times a week. When Claude does something wrong, they add it so it doesn't repeat.
- **Slash commands for inner loops:** Every workflow done many times/day gets a slash command in `.claude/commands/`
- **Surprisingly vanilla setup:** "Claude Code works great out of the box, so I personally don't customize it much."
- **No one correct way:** "Each person on the Claude Code team uses it very differently."

### 22+ Tips from Boris (Key Highlights)
- Give Claude verification criteria -- single highest-leverage practice
- Use worktrees for parallel work
- CLAUDE.md should be < 200 lines with @imports
- Slash commands for repeated workflows
- Hooks for automation guardrails
- MCP integrations for external tools

**Sources:**
- [How Boris Uses Claude Code](https://howborisusesclaudecode.com/)
- [Building Claude Code with Boris Cherny -- Pragmatic Engineer](https://newsletter.pragmaticengineer.com/p/building-claude-code-with-boris-cherny)
- [Inside the Development Workflow -- InfoQ](https://www.infoq.com/news/2026/01/claude-code-creator-workflow/)
- [Boris on Threads](https://www.threads.com/@boris_cherny/post/DTBVlMIkpcm/)
- [Boris's Claude Code Tips Collection](https://github.com/shanraisshan/claude-code-best-practice/blob/main/tips/claude-boris-15-tips-30-mar-26.md)

---

## 16. Addy Osmani's Workflow

Google Chrome team engineering manager. Fully embraced "AI-augmented software engineering" (not AI-automated).

### Core Principles
1. **Specs first:** Embed spec in workflow so agent can't proceed until validated
2. **Small iterative chunks:** Each chunk is small enough that AI can handle it within context and you can understand the output
3. **Always review:** Never ship AI code without human review
4. **Quality gates:** More tests, more monitoring, AI-on-AI code reviews

### Chunked Iteration
- Each iteration carries forward context of what's been built
- Incrementally adds to it
- Fits nicely with TDD
- Guards against the model going off the rails
- "Asking for too much in one go risks confusing output"

### Quality Philosophy
> "Design before coding, write tests, use version control, and maintain standards are even MORE important when an AI is writing half your code."

**Sources:**
- [My LLM Coding Workflow Going Into 2026 -- Addy Osmani](https://addyosmani.com/blog/ai-coding-workflow/)
- [How to Write a Good Spec for AI Agents](https://addyosmani.com/blog/good-spec/)

---

## 17. Anthropic's C Compiler Project

### Project Specs
- 16 parallel Claude Code agents (Claude Opus 4.6)
- ~2,000 sessions
- $20,000 in API costs
- Produced 100,000-line Rust-based C compiler
- Compiles: Linux 6.9 (x86, ARM, RISC-V), QEMU, FFmpeg, SQLite, PostgreSQL, Redis
- 99% pass rate on GCC torture test suite

### Architecture
- Agents in independent Docker containers
- Lock-file mechanism for task claiming (prevents duplicate work)
- Git for version control and coordination
- Robust test suites as "known-good oracles"

### Key Lessons
1. **Validation is the control plane.** Without strong tests, parallel agents diverge.
2. **Claude can't tell time.** Left alone, will spend hours running tests instead of progressing. Harness must enforce time limits.
3. **Progress reporting matters.** Include incremental progress reporting and a `--fast` option for quick validation (1-10% random test sample).
4. **Minimal human intervention.** The system worked largely autonomously, but the harness design was critical to success.

**Sources:**
- [Building a C Compiler with Parallel Claudes -- Anthropic](https://www.anthropic.com/engineering/building-c-compiler)
- [16 Claude Agents Built a C Compiler -- InfoQ](https://www.infoq.com/news/2026/02/claude-built-c-compiler/)

---

## 18. How Top Companies Use AI Agents

### Shopify
- Built internal LLM proxy -- centralized gateway routing all AI requests
- All tools (Claude Code, Copilot) flow through the proxy before reaching models
- Built internal tool "Quick" -- drag-and-drop JS/TS/HTML file deployment for internal tools
- Standardized the infrastructure layer, let teams choose their AI tools

### Vercel
- Testing Claude Sonnet 4.5 in v0, Next.js build pipelines, and Coding Agent Platform
- Released Coding Agent Platform template: multi-agent system running Claude Code, OpenAI Codex CLI, Cursor CLI, or opencode
- Agent plans, executes, and commits changes automatically
- Focus on measurable gains in code quality and build success

### Anthropic Internal
- Claude Code team shares a single CLAUDE.md for their entire repo
- Whole team contributes to it multiple times a week
- When Claude does something wrong, they add it to CLAUDE.md
- Each team member uses Claude Code very differently -- no one "correct" workflow

### Common Theme Across Companies
> "Developers act as orchestrators, guiding AI systems and evaluating output."

The role shift: from writing code to defining what needs to be built, reviewing what the AI produces, and maintaining quality standards.

**Sources:**
- [Inside Shopify's AI-First Engineering Playbook -- Bessemer](https://www.bvp.com/atlas/inside-shopifys-ai-first-engineering-playbook)
- [Collaborating with Anthropic on Claude Sonnet 4.5 -- Vercel](https://vercel.com/blog/collaborating-with-anthropic-on-claude-sonnet-4-5)

---

## 19. The 12-Factor Agent Principles

Inspired by Heroku's 12 Factor Apps. Key insight: most successful AI agents in production are well-engineered traditional software with LLM capabilities carefully sprinkled at key points.

### The Factors (Key Ones)

1. **Natural Language to Structured Output** -- JSON extraction as foundation
2. **Own Your Prompts** -- Don't hide behind framework abstractions
3. **Tools Are Just JSON and Code** -- Structured output schemas, strict validation
4. **Manage Context Windows Explicitly** -- Treat context as a limited cache; 30-60% token savings possible
5. **Own Your Control Flow** -- Don't let the LLM decide everything; deterministic where possible
6. **Stateless Agent Design** -- State externalized, not in the conversation
7. **Separate Business from Execution State** -- Clean separation of concerns
8. **Contact Humans as First-Class Operations** -- Human-in-the-loop is a feature, not a fallback
9. **Meet Users Where They Are** -- Integrate into existing workflows
10. **Small, Focused Agents** -- 3-10 steps max for reliability

### The Agent Formula
> Agent = Prompt + Switch + Context + Loop

### The 70-80% Reliability Wall
Many AI agents hit a wall around 70-80% reliability. The 12-factor approach addresses this by reducing LLM decision-making to carefully chosen moments rather than giving the LLM full autonomy.

**Sources:**
- [12-Factor Agents -- HumanLayer](https://www.humanlayer.dev/12-factor-agents)
- [12-Factor Agents GitHub](https://github.com/humanlayer/12-factor-agents)
- [12-Factor Agent Practical Framework -- DEV](https://dev.to/bredmond1019/the-12-factor-agent-a-practical-framework-for-building-production-ai-systems-3oo8)
- [Agentic Design Patterns](https://agentic-design.ai/patterns/evaluation-monitoring/twelve-factor-agent)

---

## 20. Hooks and Automation Patterns

### What Hooks Are
User-defined shell commands or LLM prompts that execute automatically at specific lifecycle points in Claude Code.

### Key Hook Events
- **PreToolUse**: Before Claude executes an action. Exit code 2 = block, exit 0 = allow.
- **PostToolUse**: After Claude completes an action. Perfect for cleanup, formatting, logging.

### Common Patterns

**Pre-Commit Automation:**
- Auto-run linter/formatter on staged files (ESLint, Prettier, Black)
- Execute relevant unit tests based on changed files
- Scan for accidentally included secrets (API keys, passwords)
- Block commit if any check fails

**Post-Commit Automation:**
- Auto-push to remote branch
- Trigger CI/CD pipeline
- Send notification (Slack, email)
- Update task tracker

**File Edit Hooks:**
- Auto-format after every file edit
- Run type checker after TypeScript changes
- Validate schema after migration file changes

### Configuration
```json
// ~/.claude/settings.json (global) or .claude/settings.json (project)
{
  "hooks": {
    "PreToolUse": [...],
    "PostToolUse": [...]
  }
}
```

### Key Benefit
Hooks encode team-specific development workflows as deterministic guardrails. They fire every time, regardless of what Claude "decides" to do.

**Sources:**
- [Automate Workflows with Hooks -- Claude Code Docs](https://code.claude.com/docs/en/hooks-guide)
- [Building My First Claude Code Hooks -- Cameron Westland](https://cameronwestland.com/building-my-first-claude-code-hooks-automating-the-workflow-i-actually-want/)
- [Claude Code Hooks Tutorial -- Blake Crosley](https://blakecrosley.com/blog/claude-code-hooks-tutorial)
- [Claude Code Hooks -- DataCamp](https://www.datacamp.com/tutorial/claude-code-hooks)

---

## 21. Key Takeaways and Meta-Patterns

### The Universal Workflow Formula
```
Brief --> Delegate --> Review --> Ship
```
This is the "Director's workflow" that Claude Code was built for. Not "prompt --> get code --> iterate."

### The Five Highest-Leverage Practices

1. **Give Claude verification criteria.** Tests, type checks, builds, screenshots. This is the single most impactful practice. Claude 2-3x better with feedback loops.

2. **Separate planning from execution.** Plan Mode or RPI workflow. Never let Claude write code until you've reviewed and approved a written plan.

3. **One task per session.** Scope narrowly. Use /clear between unrelated tasks. Multiple focused sessions beat one long session.

4. **Use CLAUDE.md as living documentation.** Check into git. Whole team contributes. When Claude makes a mistake, document it. Keep under 200 lines with @imports.

5. **Parallel sessions for throughput.** Git worktrees + multiple Claude instances = 5-15x throughput. Each session isolated, each branch independent.

### The Maturity Ladder

**Level 1: Prompt-and-Pray**
- Ask Claude to do things, hope for the best
- No verification, no planning, no context management

**Level 2: Structured Prompting**
- Clear instructions, context in CLAUDE.md
- Manual review of all output
- Single session, sequential work

**Level 3: Workflow Engineering**
- RPI workflow (Research-Plan-Implement)
- Plan Mode before execution
- TDD integration
- Proactive context management (/compact at 60-70%)
- Slash commands for repeated workflows

**Level 4: Multi-Agent Orchestration**
- Parallel sessions with worktrees
- Subagent delegation for research/specialized tasks
- Hooks for automated quality gates
- Shared task lists for coordination
- Domain-based task decomposition

**Level 5: Agent Teams**
- 10-16 parallel agents
- Automated task claiming and coordination
- Docker isolation per agent
- Validation as primary control plane
- Minimal human intervention, maximum human oversight

### The Recurring Themes

1. **Context is everything.** Context engineering > prompt engineering. What the agent sees determines what it does.
2. **Verification before trust.** Always give the agent a way to check its work.
3. **Small, atomic tasks.** Break everything down until each piece is independently completable and testable.
4. **Plan before code.** The planning phase catches 80% of errors that would be expensive to fix during implementation.
5. **Fresh context = fresh quality.** Don't fight context degradation; plan around it.
6. **Harness over model.** Improving the harness (tools, constraints, validation) often beats waiting for a better model.
7. **Human-in-the-loop at the right moments.** Not every step, but at phase boundaries.
8. **Living documentation.** CLAUDE.md is not a one-time setup; it evolves with every mistake.

### Time-to-Feature Benchmarks (Reported)
- Teams using brief-delegate-review-ship: **4.2 hours from idea to deployed feature** (down from 2-3 days)
- Average revision rounds: **1.8** (down from 5-7)
- Boris Cherny: **20-30 PRs/day** with 5 parallel sessions
- Anthropic C Compiler: **100,000 lines** from 16 agents in ~2 weeks

---

## Appendix A: Resource Links

### Essential Reading
- [How Boris Uses Claude Code](https://howborisusesclaudecode.com/)
- [Advanced Context Engineering for Coding Agents -- HumanLayer](https://github.com/humanlayer/advanced-context-engineering-for-coding-agents)
- [Harness Engineering -- Martin Fowler](https://martinfowler.com/articles/harness-engineering.html)
- [12-Factor Agents -- HumanLayer](https://www.humanlayer.dev/12-factor-agents)
- [My LLM Coding Workflow 2026 -- Addy Osmani](https://addyosmani.com/blog/ai-coding-workflow/)
- [How to Write a Good Spec for AI Agents -- Addy Osmani](https://addyosmani.com/blog/good-spec/)
- [Spec-Driven Development -- Thoughtworks](https://www.thoughtworks.com/en-us/insights/blog/agile-engineering-practices/spec-driven-development-unpacking-2025-new-engineering-practices)
- [Building a C Compiler with Parallel Claudes -- Anthropic](https://www.anthropic.com/engineering/building-c-compiler)

### Official Docs
- [Claude Code Best Practices](https://code.claude.com/docs/en/best-practices)
- [Common Workflows](https://code.claude.com/docs/en/common-workflows)
- [Create Custom Subagents](https://code.claude.com/docs/en/sub-agents)
- [Hooks Guide](https://code.claude.com/docs/en/hooks-guide)
- [Manage Costs](https://code.claude.com/docs/en/costs)

### Community Resources
- [Dex Horthy's Superthread on X](https://x.com/dexhorthy/status/1978676162495688719)
- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code)
- [Claude Code Ultimate Guide](https://github.com/FlorianBruniaux/claude-code-ultimate-guide)
- [Claude Code Best Practice Collection](https://github.com/shanraisshan/claude-code-best-practice)
- [Progressive Disclosure for AI Coding Tools](https://alexop.dev/posts/stop-bloating-your-claude-md-progressive-disclosure-ai-coding-tools/)

### Courses
- [Steve Kinney -- Developing with AI Tools](https://stevekinney.com/courses/ai-development/)

### Tools
- [agentree -- Git worktree manager for AI](https://github.com/coderabbitai/git-worktree-runner)
- [claude-flow -- Iterative Claude sessions](https://github.com/li0nel/claude-loop)
- [VoltAgent Awesome Subagents](https://github.com/VoltAgent/awesome-claude-code-subagents)

---

## Appendix B: Quick Reference Cards

### Starting a New Feature
```
1. Write spec (or have Claude help draft it)
2. /clear to start fresh
3. Plan Mode: "Research the codebase for [feature area]"
4. Review research document
5. Plan Mode: "Create implementation plan for [feature]"
6. Review plan, add notes
7. Execute plan step-by-step with verification
8. Run full test suite
9. Review diff, ship
```

### Starting a Debugging Session
```
1. /clear to start fresh
2. Paste full error message + stack trace
3. "Analyze this error. Do NOT fix yet. Explain root cause."
4. Review analysis
5. "Fix the root cause. Write a regression test."
6. Verify fix
7. Update CLAUDE.md if the bug pattern is recurring
```

### Starting a Refactor
```
1. Plan Mode: "Map all files affected by [refactor]"
2. Review impact analysis
3. Plan Mode: "Create phased plan. Identify independent vs. dependent changes."
4. For independent changes: parallel subagents or worktrees
5. For dependent changes: sequential, with tests between each step
6. Run full test suite after completion
```

### Context Management Checklist
```
[ ] CLAUDE.md is < 200 lines with @imports
[ ] .claudeignore excludes build artifacts
[ ] /compact at 60-70% context usage
[ ] /clear between unrelated tasks
[ ] One task per session
[ ] Subagents for research-heavy side tasks
[ ] /rename sessions before /clear for later /resume
```
