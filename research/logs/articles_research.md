# Context Engineering Research: Comprehensive Literature Review

**Research Date:** 2026-04-04
**Scope:** Context engineering for AI agents, LLMs, and software development
**Total Sources Analyzed:** 30+

---

## Table of Contents

1. [Foundational Definitions & Origins](#1-foundational-definitions--origins)
2. [Anthropic's Official Guide](#2-anthropics-official-guide---effective-context-engineering)
3. [Manus: Production Lessons](#3-manus---production-lessons-in-context-engineering)
4. [Martin Fowler: Coding Agents](#4-martin-fowler---context-engineering-for-coding-agents)
5. [LangChain: The Rise of Context Engineering](#5-langchain---the-rise-of-context-engineering)
6. [LangChain: Context Engineering for Agents (Deep Dive)](#6-langchain---context-engineering-for-agents-deep-dive)
7. [LlamaIndex: Techniques Guide](#7-llamaindex---context-engineering-techniques)
8. [Weaviate: Memory & Retrieval](#8-weaviate---memory-and-retrieval-for-ai-agents)
9. [Philipp Schmid: Context Engineering Part 2](#9-philipp-schmid---context-engineering-part-2)
10. [AGENTS.md Specification](#10-agentsmd-specification)
11. [AGENTS.md: Building Guide (Augment Code)](#11-agentsmd-building-guide-augment-code)
12. [ETH Zurich: Impact of AGENTS.md Files](#12-eth-zurich---impact-of-agentsmd-files)
13. [CLAUDE.md Best Practices (HumanLayer)](#13-claudemd-best-practices-humanlayer)
14. [CLAUDE.md Perfect Guide (Dometrain)](#14-claudemd-perfect-guide-dometrain)
15. [Complete Guide to AI Agent Memory Files](#15-complete-guide-to-ai-agent-memory-files)
16. [Cursor Rules Configuration](#16-cursor-rules-configuration)
17. [Context Window Compaction Strategies](#17-context-window-compaction-strategies)
18. [Inngest: Context Engineering as Software Engineering](#18-inngest---context-engineering-as-software-engineering)
19. [Kubiya: 12-Factor Agent Framework](#19-kubiya---12-factor-agent-framework)
20. [Faros: Context Engineering for Developers](#20-faros---context-engineering-for-developers)
21. [Google ADK: Multi-Agent Framework](#21-google-adk---multi-agent-framework-for-production)
22. [Vellum: Multi-Agent Systems](#22-vellum---multi-agent-systems-with-context-engineering)
23. [Simon Willison's Perspective](#23-simon-willisons-perspective)
24. [Addyo Substack: Engineering Discipline](#24-addyo-substack---bringing-engineering-discipline-to-prompts)
25. [Zep: Memory & Temporal Knowledge Graphs](#25-zep---memory-and-temporal-knowledge-graphs)
26. [CodeConductor: Complete Guide 2026](#26-codeconductor---complete-guide-2026)
27. [IntuitionLabs & Gartner Perspectives](#27-intuitionlabs--gartner-perspectives)
28. [DEV Community: Future of Context Engineering](#28-dev-community---the-future-of-context-engineering)
29. [Prompting Guide: Context Engineering Guide](#29-prompting-guide---context-engineering-guide)
30. [Academic Research Papers](#30-academic-research-papers)
31. [Synthesis: Key Themes & Principles](#31-synthesis-key-themes--principles)
32. [Practical Framework: Building Context Systems](#32-practical-framework-building-context-systems)

---

## 1. Foundational Definitions & Origins

### The Karpathy Definition
- **Source:** https://x.com/karpathy/status/1937902205765607626
- **Author:** Andrej Karpathy (former OpenAI researcher, Tesla AI lead)
- **Date:** June 2025

> "Context engineering is the delicate art and science of filling the context window with just the right information for the next step."

Karpathy endorsed "context engineering" over "prompt engineering" because people associate prompts with short task descriptions in day-to-day LLM use, while in every industrial-strength LLM application, the work involves orchestrating: task descriptions, few-shot examples, RAG, multimodal data, tools, state, history, and compacting all of this.

> "Too much or too irrelevant context can increase costs and degrade performance, and doing this well is highly non-trivial. There's also an art component because of the guiding intuition around LLM psychology."

### The Lutke Definition
- **Source:** https://x.com/tobi/status/1935533422589399127
- **Author:** Tobi Lutke (CEO, Shopify)
- **Date:** June 2025

> "I really like the term 'context engineering' over prompt engineering. It describes the core skill better: the art of providing all the context for the task to be plausibly solvable by the LLM."

### The Gartner Definition (2025)
- **Source:** Gartner (via IntuitionLabs article)
- **Date:** July 2025

> "Context engineering is in, and prompt engineering is out. AI leaders must prioritize context over prompts... This is critical for the relevance, adaptability, and lasting impact of AI."

Gartner defines it as: "designing and structuring the relevant data, workflows and environment so AI systems can understand intent, make better decisions and deliver contextual, enterprise-aligned outcomes -- without relying on manual prompts."

**Key Insight:** The term "context engineering" gained mainstream traction in mid-2025 when these three voices -- Karpathy (technical authority), Lutke (business leader), and Gartner (industry analyst) -- all converged on the same concept independently.

---

## 2. Anthropic's Official Guide - Effective Context Engineering

- **Source:** https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
- **Author:** Anthropic Engineering Team
- **Date:** 2025

### Core Definition

Context engineering differs from prompt engineering by managing the entire token set during LLM inference. It involves "thinking in context": considering the holistic state available to the model and potential behaviors it might generate.

> "Find the smallest possible set of high-signal tokens that maximize the likelihood of some desired outcome."

### The Attention Budget

LLMs have a finite "attention budget" like human working memory. **Context rot** occurs as token count increases -- models lose precision in information recall. Transformer architecture creates n-squared pairwise relationships for n tokens, stretching thin at scale.

### Strategic Components

**System Prompts:**
- Present ideas at the "right altitude" -- the Goldilocks zone between brittle, hardcoded logic and vague guidance
- Organize into distinct sections using XML tags or Markdown headers
- Aim for minimal information that fully outlines expected behavior (minimal does not equal short)
- Test with best-available models first, then add clear instructions based on failure modes

**Tools:**
- Design for clarity -- if engineers can't definitively choose between tools, agents will struggle
- Minimize overlap in functionality; ensure tools are self-contained and robust
- Use descriptive, unambiguous input parameters
- Avoid bloated tool sets covering excessive functionality

**Examples (Few-Shot):**
- Curate diverse, canonical examples showing expected agent behavior
- "For an LLM, examples are the pictures worth a thousand words"
- Avoid stuffing edge cases; focus on representative scenarios

### Just-In-Time Context Strategy

Rather than pre-processing all data upfront, agents maintain lightweight identifiers (file paths, URLs, queries) and dynamically load context at runtime.

**Hybrid Approach (Claude Code):** Retrieves CLAUDE.md files upfront while using grep/glob primitives for just-in-time file access, "effectively bypassing the issues of stale indexing."

### Long-Horizon Task Techniques

**Compaction:** Summarize conversation near context limits and reinitiate with compressed summary. The model preserves "architectural decisions, unresolved bugs, and implementation details while discarding redundant tool outputs."

**Structured Note-Taking:** Agent writes notes persisted outside context window. Examples include to-do lists, NOTES.md files, and game state tracking.

**Sub-Agent Architectures:** Specialized sub-agents handle focused tasks with clean context windows, each exploring extensively (tens of thousands of tokens) but returning condensed summaries (1,000-2,000 tokens).

### Key Takeaway

> "Do the simplest thing that works" remains the best advice. As models improve, design trends toward letting intelligent models act intelligently, with progressively less human curation.

---

## 3. Manus - Production Lessons in Context Engineering

- **Source:** https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus
- **Author:** Manus Team
- **Date:** 2025

### Core Philosophy

Manus chose **in-context learning over fine-tuning** to enable rapid iteration:

> "If model progress is the rising tide, we want Manus to be the boat, not the pillar stuck to the seabed."

### KV-Cache Optimization (Single Most Important Metric)

- Directly impacts latency and cost
- Manus achieves ~100:1 input-to-output token ratio (agents vs. chatbots)
- Cached input tokens: $0.30/MTok vs. uncached: $3.00/MTok -- a **10x difference** with Claude Sonnet
- Keep prompt prefixes stable (even single-token differences invalidate cache)
- Avoid timestamps in system prompts
- Use append-only context structures

### Mask Rather Than Remove Tools

Problem: Dynamic action spaces invalidate KV-cache and confuse models about unavailable tools.

Solution: Use context-aware state machines with **logit masking during decoding** instead of removing tool definitions. Three function-calling modes: Auto, Required, Specified.

### File System as Extended Context

Rather than aggressive compression (which loses information irreversibly), treat the file system as "unlimited in size, persistent by nature, and directly operable by the agent itself." Compression strategies remain **restorable**: preserve URLs even when dropping page content; maintain file paths when omitting contents.

### Attention Manipulation Through Recitation (todo.md Pattern)

Continuously rewrite objectives into the context end, pushing goals into the model's recent attention window. This prevents "lost-in-the-middle" issues without architectural changes.

### Preserve Error Evidence

> "When the model sees a failed action -- and the resulting observation or stack trace -- it implicitly updates its internal beliefs."

Error recovery is an underrepresented metric in academic benchmarks despite being "one of the clearest indicators of true agentic behavior."

### Avoid Few-Shot Pattern Collapse

> "The more uniform your context, the more brittle your agent becomes."

Introduce structured variation in serialization, phrasing, and ordering to prevent agents from overgeneralizing.

### Key Metric

Average task complexity: ~50 tool calls per task. The team rebuilt their agent framework **four times** ("Stochastic Graduate Descent").

---

## 4. Martin Fowler - Context Engineering for Coding Agents

- **Source:** https://martinfowler.com/articles/exploring-gen-ai/context-engineering-coding-agents.html
- **Author:** Martin Fowler / Thoughtworks
- **Date:** 2025-2026

### Core Definition

> "Context engineering is curating what the model sees so that you get a better result."

### Context Categories

**Reusable Prompts:**
- Instructions: Task-oriented prompts ("Write E2E tests following this pattern")
- Guidance: Convention-based rules ("Tests must be independent")

**Context Interfaces:**
- Tools: Built-in capabilities (bash, file search)
- MCP Servers: Custom programs providing structured API/tool access
- Skills: On-demand resources loaded when contextually relevant

### Who Controls Context Loading?

Three approaches with different tradeoffs:
1. **LLM-driven**: Enables unsupervised operation but introduces uncertainty
2. **Human-triggered**: Provides control but reduces automation (slash commands)
3. **Agent software**: Deterministic loading at lifecycle events (hooks)

### Critical Best Practices

- Build context configurations gradually, not all at once
- Start minimal -- modern models often require less context than previous versions
- Despite large context windows, indiscriminate dumping degrades agent effectiveness and increases costs

### The Probability Reality Check

> Phrases like "ensure it does X" or "prevent hallucinations" misrepresent what context engineering achieves. LLM involvement means operating in probabilities, not certainties.

---

## 5. LangChain - The Rise of Context Engineering

- **Source:** https://blog.langchain.com/the-rise-of-context-engineering/
- **Author:** LangChain Team
- **Date:** 2025

### Definition

> Context engineering means constructing dynamic systems that supply the correct information and tools in appropriate formats, enabling LLMs to realistically complete assigned tasks.

### Four Critical Elements

1. Right information (preventing garbage-in-garbage-out failures)
2. Appropriate tools (enabling information lookup and task execution)
3. Proper formatting (clear error messages and digestible tool parameters)
4. Feasibility assessment ("Can the LLM plausibly accomplish this?")

### Key Insight

> Most agent failures stem from insufficient context rather than model inadequacy.

Prompt engineering functions as a subset of context engineering -- assembling dynamic data correctly remains essential, but it is not the primary focus.

---

## 6. LangChain - Context Engineering for Agents (Deep Dive)

- **Source:** https://blog.langchain.com/context-engineering-for-agents/
- **Author:** LangChain Team
- **Date:** 2025

### Four Primary Strategies (Write/Select/Compress/Isolate)

**Write Context:**
- Scratchpads persist within a session (tool calls or state fields)
- Memories span multiple sessions
- Products like ChatGPT, Cursor, and Windsurf auto-generate cross-session memories

**Select Context:**
- Scratchpad access via tool calls or state exposure
- Memory selection through embeddings or knowledge graphs
- Tool selection using RAG-based retrieval (improving accuracy **3-fold** per recent papers)
- Knowledge retrieval through semantic search and AST parsing for codebases

**Compress Context:**
- Claude Code's "auto-compact" summarizes interactions at 95% context window utilization
- Trimming removes older messages using heuristics or trained context pruners

**Isolate Context:**
- Multi-agent architectures split tasks across subagents with separate context windows
- Environmental isolation (sandboxes, state objects) keeps token-heavy data outside the LLM

### Critical Problems

Long-running agents face: **context poisoning** (error compounding), **context distraction** (over-reliance on past behavior), **context confusion** (irrelevant tools/docs), and **context clash** (contradictory information).

---

## 7. LlamaIndex - Context Engineering Techniques

- **Source:** https://www.llamaindex.ai/blog/context-engineering-what-it-is-and-techniques-to-consider
- **Author:** LlamaIndex Team
- **Date:** 2025

### What Comprises Context

The complete context includes: system prompts, user input, short-term memory (chat history), long-term memory, retrieved knowledge base information, tool definitions and responses, structured outputs, and global state/workflow context.

### Key Techniques

**Knowledge Base & Tool Selection:** Rather than single vector stores, modern agents access multiple knowledge bases. Include metadata about available tools in context.

**Context Ordering & Compression:** Sort by relevance/date, summarize before adding to context, rank for optimal consumption.

**Long-Term Memory (LlamaIndex-specific):**
- VectorMemoryBlock: Vector database storage of chat batches
- FactExtractionMemoryBlock: Synthesizes conversation facts
- StaticMemoryBlock: Stores fixed information

**Workflow Engineering:** Break complex tasks into focused steps, control when LLM engagement occurs, insert deterministic logic between calls.

### Practical Takeaway

> Effective context engineering requires asking: "What specific information does this step need?" rather than including everything available.

---

## 8. Weaviate - Memory and Retrieval for AI Agents

- **Source:** https://weaviate.io/blog/context-engineering
- **Author:** Weaviate Team
- **Date:** 2025

### Six Pillars of Context Engineering

1. **Agents**: Orchestrate decisions; dual role as users and architects of context
2. **Query Augmentation**: Refine messy user inputs for downstream processing
3. **Retrieval**: Balance chunk size (small = precise but no context; large = rich but noisy)
4. **Prompting**: Chain-of-Thought, ReAct frameworks combined with retrieved data
5. **Memory Architecture**: Short-term (context window) + Long-term (vector databases)
6. **Tools**: Bridge thought and action via MCP ("USB-C for AI")

### Critical Failure Modes

- **Context Poisoning**: Errors compound as agents reuse contaminated information
- **Context Distraction**: Excessive history causes over-reliance on past behavior
- **Context Confusion**: Irrelevant tools or documents crowd the window
- **Context Clash**: Contradictory information creates paralyzing conflicts

### Memory Management Principles

- Filter what deserves context window presence
- Store information selectively with importance signals
- Periodic pruning using recency and retrieval frequency
- Replace transcripts with compact summaries
- Tailor architecture to specific task requirements

### Key Quote

> "The difference between a flashy demo and a dependable production system isn't about switching to a 'smarter' model. It's about how information is selected, structured, and delivered."

---

## 9. Philipp Schmid - Context Engineering Part 2

- **Source:** https://www.philschmid.de/context-engineering-part-2
- **Author:** Philipp Schmid
- **Date:** 2025-2026

### Critical Problems

**Context Rot**: Performance degrades as context windows fill despite staying within token limits. The effective context window is typically much smaller than advertised -- usually **under 256k tokens** for most models.

**Context Pollution**: Excessive irrelevant, redundant, or conflicting information distracts the LLM.

### Five Core Strategies

**1. Context Compaction & Summarization**
Hierarchy: raw -> compaction -> summarization only when necessary.
- Compaction (Reversible): Strip redundant info; reference file paths instead of full contents
- Summarization (Lossy): Preserve the most recent tool calls in raw format to maintain "rhythm"

**2. Communication Over Context Sharing**
Apply the Go concurrency principle: "Share memory by communicating, don't communicate by sharing memory."

**3. Hierarchical Action Space (Keep Toolsets Small)**
Providing 100+ tools causes context confusion and parameter hallucinations.
- Level 1 (Atomic): ~20 core stable tools
- Level 2 (Sandbox Utilities): General tools like bash
- Level 3 (Code/Packages): Libraries for complex logic chains

**4. Agent-as-Tool Pattern**
Treat sub-agents as deterministic functions. Main agents invoke sub-agents via structured tool calls, receiving structured outputs.

**5. Implementation Best Practices**
- Avoid RAG for tool definitions (breaks KV cache consistency)
- Pre-rot thresholds: Implement compaction before hitting degradation zone (~256k tokens)
- Planning via Agent-as-Tool instead of constantly rewriting todo.md (saves ~30% of tokens)
- "Intern Test" metrics: Binary success/fail on computationally verifiable outcomes

### Key Takeaway

> Performance gains came from **removing complexity**, not adding it. As models strengthen, architects should step back rather than build scaffolding.

---

## 10. AGENTS.md Specification

- **Source:** https://agents.md/ and https://github.com/agentsmd/agents.md
- **Author:** Agentic AI Foundation (Linux Foundation)
- **Date:** Originally August 2025 (OpenAI); donated December 2025

### Purpose

> AGENTS.md is "a README for agents: a dedicated, predictable place to provide the context and instructions" for AI coding agents.

### Specification Details

- Standard Markdown format with no required fields
- Uses any heading hierarchy the maintainer chooses
- Supports nested AGENTS.md files in monorepos (closest file takes precedence)
- Treated as living documentation
- Stewarded by the Agentic AI Foundation under the Linux Foundation

### Common Sections
- Project overview
- Build and test commands
- Code style guidelines
- Testing instructions
- Security considerations
- Commit/PR guidelines
- Deployment steps

### Adoption (as of March 2026)
- 60,000+ open-source repositories contain context files
- Supported by: GitHub Copilot, Cursor, Windsurf, Zed, Warp, VS Code, JetBrains, OpenAI Codex CLI, Google Jules, Gemini CLI, Amp, Devin, Aider, Goose, Kilo Code, Builder.io, RooCode, Augment Code

---

## 11. AGENTS.md Building Guide (Augment Code)

- **Source:** https://www.augmentcode.com/guides/how-to-build-agents-md
- **Author:** Augment Code
- **Date:** 2026

### Critical Finding: Quality Over Quantity

ETH Zurich research revealed that auto-generated context files actually **reduce** task success rates by 0.5-2% while increasing inference costs by 20-23%. LLM-generated files duplicate documentation agents already access independently.

> Only include non-inferable details. Human-curated files provide marginal 4% performance improvements but still incur token overhead.

### What NOT to Include
- Architectural overviews (agents discover these independently)
- Content already in README or existing documentation
- Edge case instructions that rarely apply
- Repository structure descriptions that become stale

### Essential Sections

1. **Stack Definition** with exact versions (e.g., "Framework: Next.js 15 (App Router)")
2. **Executable Commands** placed early (agents reference repeatedly)
3. **Counterintuitive Patterns** with explanations of why they exist
4. **Testing Rules** (mock requirements, determinism expectations)
5. **Permission Boundaries** (three-tier: Always / Ask First / Never)
6. **Non-Standard Tooling** (prioritize tools underrepresented in training data)

### Length Guidelines
- Start under 150 lines
- Upper boundary: ~371 lines before splitting
- Split into subdirectories when exceeding threshold

### File Interoperability

> "CLAUDE.md is a symlink to AGENTS.md" -- prevents divergence in multi-tool teams

Cursor uses `.mdc` files with YAML frontmatter. GitHub Copilot uses `.github/copilot-instructions.md`.

---

## 12. ETH Zurich - Impact of AGENTS.md Files

- **Source:** https://arxiv.org/html/2601.20404v1
- **Author:** ETH Zurich researchers
- **Date:** January 2026

### Research Question
"Does the presence of an AGENTS.md file in the repository root reduce the resources required by an autonomous AI coding agent to complete a development task?"

### Methodology
- 10 repositories with 124 pull requests
- Paired experimental design (with and without AGENTS.md)
- OpenAI Codex (gpt-5.2-codex) as test agent
- Tasks restricted to small changes (<=100 lines, <=5 files)

### Key Results

**With AGENTS.md present:**
- Wall-clock time: median decreased 98.57s -> 70.34s (**28.64% reduction**)
- Output tokens: median decreased 2,925 -> 2,440 (**16.58% reduction**)
- Input tokens: modest 9-10% reduction
- Statistical significance: p<0.05 for time and output tokens

### Conclusion

> "The presence of a root AGENTS.md file is associated with reduced token usage and faster task completion on real pull requests."

**Note:** This contrasts with the earlier ETH Zurich study showing LLM-generated files *hurt* performance -- the distinction is that **human-curated** files help while **LLM-generated** files hinder.

---

## 13. CLAUDE.md Best Practices (HumanLayer)

- **Source:** https://www.humanlayer.dev/blog/writing-a-good-claude-md
- **Author:** HumanLayer Team
- **Date:** 2025-2026

### Core Principle

LLMs are stateless functions with frozen weights. The only knowledge agents have about your codebase is what you provide in tokens. CLAUDE.md is your primary onboarding tool.

### Structure: WHAT, WHY, HOW

- **WHAT**: Tech stack, project structure, codebase map
- **WHY**: Project purpose, component functions
- **HOW**: Toolchain details, verification methods, test execution

### Critical Best Practices

**Less Is More:**
- Frontier LLMs can follow approximately **150-200 instructions** consistently
- Claude Code's system prompt already consumes ~50 instructions (~1/3 of available capacity)
- Keep files under 300 lines; HumanLayer's root file is under 60 lines

**Why Claude Ignores CLAUDE.md:**
Claude Code injects: "IMPORTANT: this context may or may not be relevant to your tasks." As instruction count increases, instruction-following quality decreases **uniformly** -- it doesn't skip newer instructions, it degrades compliance across ALL instructions.

**Progressive Disclosure:**
Create separate markdown files for task-specific guidance and reference them with brief descriptions. Prefer pointer references (`file:line`) over code snippets.

**Don't Use CLAUDE.md as a Linter:**
> "Never send an LLM to do a linter's job." LLMs are expensive and slow vs. deterministic tools.

**Never Auto-Generate via /init:**
CLAUDE.md is the highest-leverage configuration point. Carefully craft each line.

---

## 14. CLAUDE.md Perfect Guide (Dometrain)

- **Source:** https://dometrain.com/blog/creating-the-perfect-claudemd-for-claude-code/
- **Author:** Dometrain
- **Date:** 2025-2026

### Essential Sections

1. **Terminal Commands**: All common dev commands with specific parameters and flags
2. **Workflows**: Feature implementation steps, code review checklists, planning procedures
3. **Coding Standards**: Naming conventions, indentation, comment requirements, test naming
4. **Terminology**: Domain-specific jargon and business terms
5. **Architecture**: Clean Architecture layers, file organization, directory structure
6. **MCP Server Instructions**: When and how to use configured tools

### Living Document Approach

> "Treat it as a living document that you modify and add to over time as you encounter particular behaviors with Claude Code."

### When to Expand Content
Add clarifications when agents:
- Run incorrect commands repeatedly
- Miss specific stylistic conventions
- Store files in wrong directories
- Struggle with domain terminology

### Security
Never include secrets or connection strings. Commit to source control for team consistency.

---

## 15. Complete Guide to AI Agent Memory Files

- **Source:** https://medium.com/data-science-collective/the-complete-guide-to-ai-agent-memory-files-claude-md-agents-md-and-beyond-49ea0df5c5a9
- **Author:** Data Science Collective
- **Date:** 2025-2026

### The Fragmentation Problem

Multiple AI coding tools each demand their own instruction files, creating fragmentation. Developers maintain nearly-identical files across different locations.

### File Landscape

| File | Tool | Notes |
|------|------|-------|
| CLAUDE.md | Claude Code | Loads every session, supports @imports |
| AGENTS.md | Universal | Linux Foundation standard, broadest support |
| .cursorrules / .cursor/rules/*.mdc | Cursor | YAML frontmatter, glob-scoped rules |
| .github/copilot-instructions.md | GitHub Copilot | Also reads AGENTS.md |
| .windsurfrules | Windsurf | Dual structure (global_rules.md) |
| CLAUDE.local.md | Claude Code | Personal, auto-gitignored |

### Claude's Auto-Memory System

Claude writes notes to itself in `~/.claude/projects/<project>/memory/` during sessions. "You write CLAUDE.md, Claude writes MEMORY.md." Only first 200 lines of MEMORY.md load automatically; topic files load on-demand.

### The @imports Feature (Claude-specific)

Supports importing referenced files with `@path/to/file` syntax, enabling recursive references up to 5 levels deep. Allows distributed ownership (frontend team owns `docs/frontend-rules.md`, security team owns `docs/security.md`).

### Multi-Tool Setup Recommendation

- AGENTS.md: shared instructions for all tools
- CLAUDE.md: Claude-specific features (@imports, /init workflow)
- CLAUDE.local.md: personal preferences
- Symlink other tools' files to AGENTS.md for consistency

### Key Insight

> "Every line in CLAUDE.md competes for attention with the actual work. Bad context management is half the reason most AI agents fail in production."

### Bootstrap Approach

1. Run `/init` to generate starter file
2. Delete obvious/unnecessary content
3. Build organically -- when Claude makes wrong assumptions, add to CLAUDE.md permanently
4. Review and optimize every few weeks

---

## 16. Cursor Rules Configuration

- **Source:** https://docs.cursor.com/context/rules-for-ai and https://cursor.com/docs/context/rules
- **Author:** Cursor Team
- **Date:** 2025-2026

### Evolution

The `.cursorrules` file in project root is still supported but will be deprecated. Recommended: `.cursor/rules/*.mdc` files with Rule Type "Always".

### Rule Types

- **User Rules**: Global to Cursor environment, always applied
- **Project Rules**: Stored in `.cursor/rules/` as `.mdc` files, version-controlled
- Rules can be scoped using path patterns, invoked manually, or included based on relevance

### Best Practices

- Write focused, composable rules (under 500 lines per file)
- Reuse rule blocks instead of duplicating prompts
- Unlike ad hoc chat instructions, rules persistently inject guidelines into every AI prompt

---

## 17. Context Window Compaction Strategies

- **Source:** https://wasnotwas.com/writing/context-compaction/
- **Author:** wasnotwas
- **Date:** 2026

### Comparison of Seven AI Coding Agents

| Agent | Fires At | Strategy |
|-------|----------|----------|
| Gemini CLI | 50% | Extract + preserves last 30% verbatim |
| Claude Code | ~89% | Five mechanisms including no-LLM "microcompact" |
| Roo Code | ~86-92% | Non-destructive; preserves undo capability |
| Pi | ~92% | Iterative updates; merges with prior summaries |
| Codex | 90% (hard ceiling) | Delegates to OpenAI server-side `/compact` endpoint |
| opencode | ~96-99% | Marker-based deferred compaction |
| OpenHands | 100 events | Event store architecture; fundamentally different |

### Dominant Pattern (6 of 7 agents)

"Extract" architecture: separate LLM call with full conversation history, append summarization prompt, replace old context with summary.

### Claude Code's Microcompact

During serialization before each API call, if tokens exceed threshold and 20,000+ clearable tokens exist, old tool results are replaced with `[Tool result cleared]` -- no API cost, preserves recent context.

### Roo Code's File Folding

After condensation, files are re-read through tree-sitter to extract function signatures and class declarations (no bodies), injected as structural awareness.

### The Cache Problem

> "Every time a compaction fires, the cache is busted."

One compaction call on a 125,000-token context costs approximately **$0.40** -- equivalent to running 21 warm-cache follow-up turns.

### Experimental Finding

Testing with explicit "preserve everything" nudges yielded **49% more detailed summaries** (+812 tokens) at negligible cost. Yet no production agent currently injects dynamic preservation checklists.

---

## 18. Inngest - Context Engineering as Software Engineering

- **Source:** https://www.inngest.com/blog/context-engineering-is-software-engineering-for-llms
- **Author:** Inngest Team
- **Date:** 2025

### Core Insight

> "The main thing that determines whether an agent succeeds or fails is the quality of the context you give it." (Philip Schmid)

Most agent failures are "context failures" not "model failures."

### Four Critical Components

1. **Tool Selection**: Right quantity, specificity, and definition clarity
2. **State & Memory Management**: Strategic pruning of unnecessary state
3. **Data Integration**: Gathering precise, use-case-specific information
4. **Data Formatting**: YAML preferred over JSON for token efficiency

### Key Principle

Context Engineering represents standardized architectural principles rather than prompting techniques. A flexible, robust orchestration layer forms the foundation.

---

## 19. Kubiya - 12-Factor Agent Framework

- **Source:** https://www.kubiya.ai/blog/context-engineering-ai-agents
- **Author:** Kubiya Team
- **Date:** 2025

### The 12-Factor Agent Framework (adapted from 12-factor app methodology)

**Foundation Factors:**
1. Convert natural language to structured tool calls (JSON)
2. Maintain ownership and control of prompts
4. Treat tools as structured outputs (separate reasoning from execution)

**State & Control Factors:**
3. Own your context window -- curate information for precision
5. Unify execution state and business state
6. Enable launch/pause/resume capabilities
8. Own control flow using traditional programming logic
12. Design agents as stateless reducers with externally managed state

**Human Collaboration Factors:**
7. Use structured tool calls for explicit human contact
11. Trigger agents from multiple channels

**Production Factors:**
9. Compact errors into context window for self-correction
10. Build small, focused micro-agents (3-10 steps)

### Key Insight

> Many "agents" marketed today rely heavily on deterministic code with strategically placed LLM calls, creating an illusion of intelligence. Context engineering enables genuine autonomous behavior.

---

## 20. Faros - Context Engineering for Developers

- **Source:** https://www.faros.ai/blog/context-engineering-for-developers
- **Author:** Faros Team
- **Date:** 2025-2026

### Five Core Strategies

1. **Context Selection**: Retrieve only relevant pieces (auth task needs auth middleware, not entire frontend)
2. **Context Compression**: ACE framework uses "incremental delta updates"
3. **Context Ordering**: Critical rules at beginning, current work at end (lost-in-the-middle phenomenon)
4. **Context Isolation**: Split complex tasks across specialized agents
5. **Format Optimization**: YAML/XML more token-efficient than JSON; Markdown headers aid navigation

### Key Metrics

> "More context doesn't equal better performance. Optimal density wins."

Model correctness drops around 32,000 tokens despite larger claimed windows. Cost and latency scale linearly with context size.

### The Full Context Stack

1. System prompts & instructions
2. Codebase context
3. Git history & recent changes
4. Dependencies & imported libraries
5. Tool definitions
6. Team standards & patterns
7. Conversation history
8. Retrieved documentation

### Enterprise Challenges

1. Vague task specifications (most tickets lack sufficient clarity)
2. Context file problems (too big, too generic, poorly structured)
3. Lack of guardrails (no structured human-in-the-loop checkpoints)
4. No measurement framework for context engineering effectiveness

### Key Quote

> "Clever prompts make for impressive demos. Engineered context makes for shippable software."

---

## 21. Google ADK - Multi-Agent Framework for Production

- **Source:** https://developers.googleblog.com/architecting-efficient-context-aware-multi-agent-framework-for-production/
- **Author:** Google Developers Blog
- **Date:** 2025-2026

### Design Thesis

> "Context is a compiled view over a richer stateful system."

Rather than mutable buffers, ADK separates storage (Sessions, Memory, Artifacts) from presentation (Working Context), with Flows and Processors acting as the compilation pipeline.

### Three Core Principles

1. **Separate storage from presentation** -- Durable state evolves independently from prompt formats
2. **Explicit transformations** -- Named, ordered processors replace ad-hoc string concatenation
3. **Scope by default** -- Agents receive minimum required context; explicit tools fetch additional info

### Tiered Architecture

- **Working Context**: Ephemeral, per-call prompt view
- **Session**: Durable event log with structured, model-agnostic records
- **Memory**: Long-lived searchable knowledge outliving single sessions
- **Artifacts**: Named, versioned large data objects referenced via handles

### Key Technical Patterns

- **Context Compaction**: LLM-driven summarization at configurable thresholds
- **Artifact Handling**: "Handle patterns" -- agents see lightweight references, load via tools
- **Memory Retrieval**: Reactive (agent-initiated) and proactive (pre-processor similarity search)
- **Multi-Agent Handoffs**: "Narrative casting" reframes prior assistant messages to prevent attribution confusion
- **Context Caching**: Stable prefixes for prefix-cache reuse; dynamic content pushed to variable suffixes

### Key Quote

> "Simply giving agents more space to paste text can not be the single scaling strategy."

---

## 22. Vellum - Multi-Agent Systems with Context Engineering

- **Source:** https://vellum.ai/blog/multi-agent-systems-building-with-context-engineering
- **Author:** Vellum Team
- **Date:** 2025-2026

### Architecture Patterns

1. **Supervisor Pattern**: Central manager delegates to specialized sub-agents
2. **Hierarchical Pattern**: Sequential chain (output -> input)
3. **Network (Peer-to-Peer)**: Independent agents coordinate through shared state

### When to Use Multi-Agent Systems

**Single-agent suffices when**: Tasks are linear, real-time responses needed, problem fits single context window.

**Multi-agent when**: Tasks decompose into distinct subproblems, specialization creates clear roles, work can be parallelized.

### Common Failure Modes

| Failure | Root Cause | Solution |
|---------|-----------|----------|
| Token Sprawl | Redundant context sharing | Trim prompts, compress outputs |
| Coordination Drift | Misaligned roles/prompts | Modular versioning, observability |
| Context Overflow | Too much info | External memory, scoped scratchpads |
| Hallucination | Incomplete grounding | Better filtering, evaluation |

### Key Metric

> Anthropic's research system achieved "90.2% performance improvement over single-agent baseline" using Opus 4 lead + Sonnet 4 sub-agents.

Multi-agent systems can consume up to **15x more tokens** than standard interactions.

---

## 23. Simon Willison's Perspective

- **Source:** https://simonwillison.net/2025/jun/27/context-engineering/
- **Author:** Simon Willison
- **Date:** June 2025

Willison advocates for "context engineering" as superior terminology. He believes the term will gain traction because its inferred definition aligns better with the actual work involved.

> "Prompt engineering" has been misunderstood by the general public, becoming associated with simply typing into a chatbot.

He acknowledges that inferred definitions are what ultimately stick in common usage, and "context engineering" more accurately represents the genuine complexity of working with modern LLMs.

---

## 24. Addyo Substack - Bringing Engineering Discipline to Prompts

- **Source:** https://addyo.substack.com/p/context-engineering-bringing-engineering
- **Author:** Addyo
- **Date:** 2025

### Core Framing

> "Prompt engineering walked so context engineering could run."

Context engineering constructs entire information ecosystems dynamically, treating the LLM like a CPU where "you load working memory with just the right code and data for the task."

### Core Techniques

1. **Information Assembly**: Dynamically compose context from multiple sources at runtime
2. **Knowledge Retrieval (RAG)**: Ground answers in provided facts rather than model memory
3. **Few-Shot Examples & Role Instructions**: Demonstrate desired output
4. **State & Memory Management**: Use "context checkpoints" to reset accumulated noise
5. **Tool Integration & Environmental Context**: Loop: prompt -> tool call -> execute -> result -> new prompt
6. **Information Formatting**: Structure data for LLM consumption (headings, code blocks)

### Context Rot

> Over extended conversations, quality degrades as "context fills with increasingly noisy information."

Solutions: Regular summarization, explicit phase boundaries, periodic cleanup.

### Key Principle

> "Garbage in, garbage out: The quality of output is directly proportional to the quality and relevance of the context you provide."

---

## 25. Zep - Memory and Temporal Knowledge Graphs

- **Source:** https://blog.getzep.com/what-is-context-engineering/
- **Author:** Zep Team
- **Date:** 2025

### Zep's Unique Approach

**Temporal knowledge graphs**: Dynamic representations capturing what is true now, when it was true, and how information changed over time. Addresses the challenge of maintaining accurate context as user preferences evolve.

### Production Challenges

Building production-grade reliability requires:
- Reflection mechanisms for entity extraction
- Comprehensive entity resolution pipelines
- Handling real-world data messiness (misspellings, abbreviations, topic switches)

### Multi-Agent Context Sharing

Critical lesson: when multiple agents operate independently, missing shared context causes failures. Agents require either shared context or architectures that avoid unnecessary parallelization on coherence-dependent tasks.

---

## 26. CodeConductor - Complete Guide 2026

- **Source:** https://codeconductor.ai/blog/context-engineering
- **Author:** CodeConductor
- **Date:** 2026

### Four Core Pillars

1. **Context Composition**: Selecting relevant ingredients (docs, tools, history, metadata)
2. **Context Ranking & Relevance**: Prioritizing via embedding similarity, recency, deduplication
3. **Context Optimization**: Maximizing signal within token limits
4. **Context Orchestration**: Dynamically assembling context at runtime through pipelines

### Advanced Strategies

- **Context Masking/Filtering**: Selectively hide irrelevant data
- **KV-Cache (Prefix/Suffix Caching)**: Reuse static instructions efficiently
- **Hierarchical Design**: Global instructions -> session metadata -> task-specific details
- **Chunking**: Semantically coherent pieces with sliding windows

### Critical Limitations

Context engineering:
- Does NOT eliminate hallucinations
- Cannot fix model misalignment
- Poor retrieval still worsens outputs
- Cannot overcome token constraints through formatting alone

### Bottom Line

> Context engineering moves AI from reactive tools to programmable, adaptive systems. In 2026, mastering it is non-negotiable.

---

## 27. IntuitionLabs & Gartner Perspectives

- **Source:** https://intuitionlabs.ai/articles/what-is-context-engineering
- **Author:** IntuitionLabs
- **Date:** 2025-2026

### Key Data Points

- Over **40% of AI project failures** stem from poor context management rather than model deficiencies
- Gartner predicts **40% of enterprise applications** will feature task-specific AI agents by late 2026
- MCP has **97+ million monthly SDK downloads** and **75+ official connectors**

### Memory Architecture Advances

- Extended memory models like M+ boost retention from 20K to **160K+ tokens**
- **Cognitive Workspace** paradigm enables active curation with **58.6% memory reuse** versus 0% for naive RAG
- HippoRAG 2 combines RAG with passage graphs for human-like retrieval

### New Roles

Organizations are creating specialized roles: Context Engineers, Context Architects -- combining data engineers, domain experts, and AI specialists.

---

## 28. DEV Community - The Future of Context Engineering

- **Source:** https://dev.to/lofcz/the-future-of-ai-context-engineering-in-2025-and-beyond-5n9
- **Author:** lofcz (DEV Community)
- **Date:** 2025

### Performance Metrics

| Strategy | Cost Reduction | Accuracy Gain |
|----------|---------------|---------------|
| Basic Context Structure | 10-15% | +5-10% |
| Contextual Embeddings | 20-25% | +15-20% |
| Smart Caching | 75-85% | +30-40% latency |
| Agent-Level Context | N/A | Coherence across interactions |

### Organizations Report

- 3x faster production deployment
- 40% operational cost reduction
- 90-95% retrieval accuracy improvements

---

## 29. Prompting Guide - Context Engineering Guide

- **Source:** https://www.promptingguide.ai/guides/context-engineering-guide
- **Author:** Prompting Guide (DAIR.AI)
- **Date:** 2025

### Planning Agent Example

Context engineering demonstrated through a search planning agent producing JSON outputs with fields: id, query, source_type, time_period, domain_focus, priority.

### Critical Success Factors

- Explicitness over assumptions (specify scales, formats, field requirements)
- Output structure (JSON schemas dramatically improve consistency)
- Contextual relevance (filter noisy information systematically)
- Evaluation pipelines: "If you are not measuring...how do you know whether your context engineering efforts are working?"

---

## 30. Academic Research Papers

### Paper 1: Context Engineering for AI Agents in Open-Source Software
- **Source:** https://arxiv.org/abs/2510.21413
- **Date:** October 2025
- **Finding:** Analyzed 466 open-source projects. "There is no established content structure yet" among developers implementing context files. Developers employ multiple communicative styles: descriptive, prescriptive, prohibitive, explanatory, conditional.

### Paper 2: Agentic Context Engineering (ACE)
- **Source:** https://arxiv.org/abs/2510.04618
- **Date:** October 2025
- **Finding:** ACE framework treats contexts as evolving playbooks that accumulate, refine, and organize strategies through generation, reflection, and curation.

### Paper 3: Everything is Context - Agentic File System Abstraction
- **Source:** https://arxiv.org/abs/2512.05470
- **Date:** December 2025
- **Finding:** Proposes treating the file system as a first-class context management primitive for AI agents.

### Paper 4: Mem0 - Scalable Long-Term Memory
- **Source:** https://arxiv.org/abs/2504.19413
- **Date:** April 2025
- **Finding:** Memory-centric architecture achieves **91% lower p95 latency** and saves **more than 90% token cost** through structured, persistent memory mechanisms.

---

## 31. Synthesis: Key Themes & Principles

### Theme 1: Context is the Bottleneck, Not the Model

Multiple independent sources converge: agent failures are primarily context failures, not model failures. Over 40% of AI project failures stem from poor context management.

> "Clever prompts make for impressive demos. Engineered context makes for shippable software." (Faros)

### Theme 2: Less Is More -- Optimal Density Over Maximum Volume

Every source emphasizes that more context does not equal better performance. The effective context window is far smaller than the advertised maximum.

- Model correctness drops around 32,000 tokens
- Frontier LLMs follow ~150-200 instructions consistently
- Context rot degrades performance even within token limits
- The goal: "the smallest possible set of high-signal tokens"

### Theme 3: The Four Canonical Strategies (Write/Select/Compress/Isolate)

Independently identified by LangChain, Anthropic, Philipp Schmid, Google ADK, and others:

1. **Write**: Store context externally (scratchpads, memory files, databases)
2. **Select**: Retrieve only what is needed (RAG, semantic search, JIT loading)
3. **Compress**: Summarize or compact when context grows (compaction > summarization)
4. **Isolate**: Split context across specialized agents or sandboxes

### Theme 4: KV-Cache Is King for Production Systems

Manus, Google ADK, and Philipp Schmid all identify KV-cache hit rate as the single most important production metric for AI agents. Strategies:
- Keep prompt prefixes stable
- Append-only context structures
- Mask rather than remove tools
- Avoid timestamps in system prompts

### Theme 5: Context Files Are Converging on AGENTS.md

The ecosystem is converging on AGENTS.md as the universal standard, with tool-specific files (CLAUDE.md, .cursorrules) adding unique features on top. Key principle: write only what agents cannot discover independently.

### Theme 6: Multi-Agent Systems Need Context Isolation

Shared context across agents creates context pollution, KV-cache penalties, and confusion. Best practice: "Share memory by communicating, don't communicate by sharing memory."

### Theme 7: Human-Curated Context Beats Auto-Generated

ETH Zurich research shows auto-generated context files reduce performance by ~3% while increasing costs by 20%+. Human-curated files provide marginal improvements. The key is selectivity, not comprehensiveness.

### Theme 8: Context Engineering Is System Design

Context engineering is not a prompting technique -- it is software engineering for LLMs. It involves control flow, model routing, tool orchestration, memory management, guardrails, and monitoring.

---

## 32. Practical Framework: Building Context Systems

Based on the synthesized research, here is a unified framework for context engineering:

### Layer 1: Static Context (Loaded Every Session)

- **AGENTS.md / CLAUDE.md**: Under 150 lines, human-curated
- Focus on non-inferable information only
- Include: exact commands, counterintuitive patterns, permission boundaries
- Exclude: architectural overviews, style that linters handle, anything discoverable

### Layer 2: Dynamic Context (Loaded Per-Task)

- Just-in-time retrieval via tools (grep, glob, file read)
- RAG for documentation and knowledge bases
- Tool definitions (hierarchical, ~20 atomic tools max)
- Current state and recent changes

### Layer 3: Persistent Memory (Across Sessions)

- Auto-memory systems (Claude's MEMORY.md, Cursor memories)
- External databases (vector stores, knowledge graphs)
- Temporal awareness (what was true when, what changed)
- Selective storage with importance signals

### Layer 4: Context Lifecycle Management

- **Compaction**: Reversible removal of redundant info (file paths instead of contents)
- **Summarization**: Lossy but necessary at ~85-95% capacity
- **Microcompact**: Replace old tool results with placeholders (free, no API call)
- **Sub-agents**: Fresh context windows for focused subtasks

### Layer 5: Context Quality Assurance

- Evaluation pipelines measuring context effectiveness
- "Intern test" metrics: binary success/fail on verifiable outcomes
- Observability and tracing (LangSmith, etc.)
- Periodic review and pruning of persistent context

### The Golden Rules

1. **Minimal effective context**: Find the smallest set of high-signal tokens for each step
2. **Structure for attention**: Critical info at beginning and end, not middle
3. **Preserve cache**: Stable prefixes, append-only, no timestamps in system prompts
4. **Separate storage from presentation**: Durable state !== prompt view
5. **Measure everything**: If you cannot measure improvement, you cannot manage it
6. **Start simple, add complexity only when needed**: Do the simplest thing that works
7. **Human curation over automation**: Write selectively, never generate context files with LLMs
8. **Context is architecture**: Treat it as a first-class system design concern

---

## Appendix: Source Index

| # | Source | Author | Date | URL |
|---|--------|--------|------|-----|
| 1 | Karpathy Definition | Andrej Karpathy | Jun 2025 | https://x.com/karpathy/status/1937902205765607626 |
| 2 | Lutke Definition | Tobi Lutke | Jun 2025 | https://x.com/tobi/status/1935533422589399127 |
| 3 | Anthropic Guide | Anthropic Engineering | 2025 | https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents |
| 4 | Manus Lessons | Manus Team | 2025 | https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus |
| 5 | Martin Fowler | Thoughtworks | 2025-26 | https://martinfowler.com/articles/exploring-gen-ai/context-engineering-coding-agents.html |
| 6 | LangChain Rise | LangChain | 2025 | https://blog.langchain.com/the-rise-of-context-engineering/ |
| 7 | LangChain Deep Dive | LangChain | 2025 | https://blog.langchain.com/context-engineering-for-agents/ |
| 8 | LlamaIndex Guide | LlamaIndex | 2025 | https://www.llamaindex.ai/blog/context-engineering-what-it-is-and-techniques-to-consider |
| 9 | Weaviate Memory | Weaviate | 2025 | https://weaviate.io/blog/context-engineering |
| 10 | Schmid Part 2 | Philipp Schmid | 2025-26 | https://www.philschmid.de/context-engineering-part-2 |
| 11 | AGENTS.md Spec | AAIF/Linux Foundation | 2025 | https://agents.md/ |
| 12 | AGENTS.md Guide | Augment Code | 2026 | https://www.augmentcode.com/guides/how-to-build-agents-md |
| 13 | ETH Zurich Study | ETH Zurich | Jan 2026 | https://arxiv.org/html/2601.20404v1 |
| 14 | CLAUDE.md (HumanLayer) | HumanLayer | 2025-26 | https://www.humanlayer.dev/blog/writing-a-good-claude-md |
| 15 | CLAUDE.md (Dometrain) | Dometrain | 2025-26 | https://dometrain.com/blog/creating-the-perfect-claudemd-for-claude-code/ |
| 16 | Agent Memory Files | Data Science Collective | 2025-26 | https://medium.com/data-science-collective/the-complete-guide-to-ai-agent-memory-files-claude-md-agents-md-and-beyond-49ea0df5c5a9 |
| 17 | Cursor Rules | Cursor | 2025-26 | https://docs.cursor.com/context/rules-for-ai |
| 18 | Compaction Strategies | wasnotwas | 2026 | https://wasnotwas.com/writing/context-compaction/ |
| 19 | Inngest | Inngest | 2025 | https://www.inngest.com/blog/context-engineering-is-software-engineering-for-llms |
| 20 | 12-Factor Agent | Kubiya | 2025 | https://www.kubiya.ai/blog/context-engineering-ai-agents |
| 21 | Faros Developer Guide | Faros | 2025-26 | https://www.faros.ai/blog/context-engineering-for-developers |
| 22 | Google ADK | Google Developers | 2025-26 | https://developers.googleblog.com/architecting-efficient-context-aware-multi-agent-framework-for-production/ |
| 23 | Vellum Multi-Agent | Vellum | 2025-26 | https://vellum.ai/blog/multi-agent-systems-building-with-context-engineering |
| 24 | Simon Willison | Simon Willison | Jun 2025 | https://simonwillison.net/2025/jun/27/context-engineering/ |
| 25 | Addyo Substack | Addyo | 2025 | https://addyo.substack.com/p/context-engineering-bringing-engineering |
| 26 | Zep Memory | Zep | 2025 | https://blog.getzep.com/what-is-context-engineering/ |
| 27 | CodeConductor 2026 | CodeConductor | 2026 | https://codeconductor.ai/blog/context-engineering |
| 28 | IntuitionLabs/Gartner | IntuitionLabs | 2025-26 | https://intuitionlabs.ai/articles/what-is-context-engineering |
| 29 | DEV Community Future | lofcz | 2025 | https://dev.to/lofcz/the-future-of-ai-context-engineering-in-2025-and-beyond-5n9 |
| 30 | Prompting Guide | DAIR.AI | 2025 | https://www.promptingguide.ai/guides/context-engineering-guide |
| 31 | arXiv: OSS Context | Academic | Oct 2025 | https://arxiv.org/abs/2510.21413 |
| 32 | arXiv: ACE Framework | Academic | Oct 2025 | https://arxiv.org/abs/2510.04618 |
| 33 | arXiv: File System | Academic | Dec 2025 | https://arxiv.org/abs/2512.05470 |
| 34 | arXiv: Mem0 | Academic | Apr 2025 | https://arxiv.org/abs/2504.19413 |
| 35 | DataCamp Guide | DataCamp | 2025 | https://www.datacamp.com/blog/context-engineering |
| 36 | Context7 Handbook | GitHub | 2025 | https://github.com/davidkimai/Context-Engineering |
