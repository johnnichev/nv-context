# Context Engineering Tools & Frameworks Research

**Date:** 2026-04-04
**Purpose:** Comprehensive survey of existing tools, frameworks, and patterns for context engineering in AI-assisted software development.

---

## Table of Contents

1. [Context Packaging & Repository Tools](#1-context-packaging--repository-tools)
2. [AI Coding Tool Context Systems](#2-ai-coding-tool-context-systems)
3. [Agent Configuration Files & Standards](#3-agent-configuration-files--standards)
4. [Memory Frameworks for AI Agents](#4-memory-frameworks-for-ai-agents)
5. [MCP Servers for Context](#5-mcp-servers-for-context)
6. [Context Compression & Optimization](#6-context-compression--optimization)
7. [Linters & Validation Tools](#7-linters--validation-tools)
8. [Context Engineering Patterns & Strategies](#8-context-engineering-patterns--strategies)
9. [Curated Resource Lists](#9-curated-resource-lists)
10. [Key Takeaways & What Works](#10-key-takeaways--what-works)

---

## 1. Context Packaging & Repository Tools

### Repomix
- **URL:** https://github.com/yamadashy/repomix
- **Stars:** 22.4k+
- **What it does:** Packs an entire repository into a single AI-friendly file. Supports XML (default), Markdown, JSON, and plain text output formats.
- **Key features:**
  - AI-optimized formatting with token counting per file
  - Git-aware (respects .gitignore)
  - Security scanning for sensitive information
  - Code compression via Tree-sitter to reduce tokens while preserving structure
  - MCP server mode for direct AI assistant integration
  - GitHub Actions integration
- **Install:** `npm install -g repomix` / `brew install repomix`
- **Assessment:** The dominant tool in this category. Very mature, widely adopted, MCP-enabled. Python port also available at `AndersonBY/python-repomix`.

### Repo2Txt
- **URL:** https://repo2txt.com/
- **What it does:** Converts GitHub repos or local directories into structured text for LLM consumption.
- **Key features:**
  - Web app and CLI
  - File selection UI for choosing what to include
  - Token estimation to fit context windows
  - Supports public and private GitHub repos
- **Assessment:** Simpler than Repomix, good for quick one-off conversions. Less feature-rich.

### CTX (Context Hub Generator)
- **URL:** https://github.com/context-hub/generator
- **Docs:** https://docs.ctxllm.com/
- **What it does:** Solves the context management gap between codebases and LLMs. Operates as both MCP server and context document generator.
- **Key features:**
  - Single ~20 MB binary, zero dependencies
  - Two modes: MCP Server Mode (real-time AI interaction) and Context Generation Mode (structured documents)
  - Gathers code from files, directories, GitHub/GitLab repos, web pages, or plain text
  - Developer controls exactly what AI sees (explicit context, not guessing)
  - Works with Claude Desktop, Cursor, Cline, and any MCP-compatible client
- **Assessment:** Promising tool with a "Context as Code" philosophy. Gives developers explicit control over context rather than relying on automatic retrieval.

### Codebase Context Specification (CCS)
- **URL:** https://github.com/Agentic-Insights/codebase-context-spec
- **What it does:** Proposes a standardized `.context/` directory convention for embedding rich contextual information in codebases.
- **Structure:**
  - `.context/` directory at project root
  - `index.md` file (required) - human and AI-readable documentation
  - Optional `.context.yaml` and `.context.json` for structured metadata
  - `.contextignore` to exclude files
  - `CODING-ASSISTANT-PROMPT.md` for AI guidelines
- **Assessment:** Good standardization attempt, similar to `.env` or `.editorconfig` but for AI context. Not widely adopted yet. Worth watching.

### ai_context_file
- **URL:** https://github.com/anderswodenker/ai_context_file
- **What it does:** A simple, human-readable file format to give AI tools the right context for a project.
- **Assessment:** Minimal approach. Useful as a reference for simple context file design.

---

## 2. AI Coding Tool Context Systems

### Claude Code
- **URL:** https://code.claude.com
- **Context architecture (5 layers):**
  1. **CLAUDE.md files** - Markdown files at different filesystem levels (global `~/.claude/CLAUDE.md`, project root, subdirectories). Loaded automatically at session start by walking from cwd up to filesystem root.
  2. **Auto Memory** - Claude automatically stores learned preferences and patterns in `~/.claude/` directory.
  3. **Skills** - Reusable instruction sets loaded on-demand. Descriptions always in context; full instructions loaded when matching task detected. Character budget limits force description shortening with many skills.
  4. **Hooks** - Deterministic event-driven automation (PreToolUse, PostToolUse, PermissionRequest, SessionStart, Stop, etc.). For rules that must be followed 100% of the time.
  5. **MCP Servers** - External tool integrations loaded at startup.
- **Context management primitives:**
  - Subagents as context isolation (fresh context, only summary returns)
  - Automatic compaction (older tool outputs cleared first, then conversation summarized)
  - Path-scoped rules that load automatically when matching files are referenced
- **Key insight:** "Subagents are a context-management primitive as much as a delegation primitive."

### Cursor
- **URL:** https://docs.cursor.com/context/rules
- **Context architecture:**
  1. **Project Rules** - Stored in `.cursor/rules/` directory. Automatically included when matching files are referenced. Support frontmatter for activation conditions.
  2. **Global Rules** - Configured in Cursor Settings > General > Rules for AI.
  3. **Legacy `.cursorrules`** - Single file at project root (older format, still supported).
  4. **Codebase indexing** - RAG-based retrieval for codebase-wide context.
  5. **@-mentions** - Explicit context inclusion (@file, @folder, @codebase, @docs, @web).
- **Dynamic Context Discovery (from ZenML research):** Cursor uses dynamic context discovery for production coding, pulling relevant information on-demand rather than loading everything upfront.
- **Assessment:** Strong rule system with activation modes. The `.cursor/rules/` directory approach is more granular than a single file.

### Windsurf (Codeium)
- **URL:** https://docs.windsurf.com
- **Context architecture (5 sources assembled per interaction):**
  1. **Rules** -> 2. **Memories** -> 3. **Open files** -> 4. **Indexed retrieval** -> 5. **Recent actions**
- **Cascade Memories:**
  - Auto-generated during conversations when Cascade detects useful context
  - Associated with workspace, stored locally in `~/.codeium/windsurf/memories/`
  - Can also be manually created via conversation
- **Rules system:**
  - `.windsurfrules` file at project root for stack/conventions/boundaries
  - Workspace rules with frontmatter-based activation modes (trigger field)
  - Global `global_rules.md` and root-level `AGENTS.md` are always-on
  - Rules are version-controlled and shareable
- **Key insight:** "For knowledge you want Cascade to reliably reuse, write it as a Rule or add it to AGENTS.md rather than relying on auto-generated Memories."

### Aider
- **URL:** https://aider.chat
- **GitHub:** https://github.com/Aider-AI/aider
- **Context management:**
  - **Repository Map** - Compressed text representation of entire project structure. Auto-generated and updated. Uses tree-sitter for AST-based mapping.
  - **File management** - `/add` and `/drop` commands for explicit file context control.
  - **Configuration** - `.aider.conf.yml` for settings (model, editor, auto-commit, conventions files).
  - **Conventions** - `read: CONVENTIONS.md` in config to auto-load coding conventions.
  - **Chat modes** - Code mode (for edits), Ask mode (read-only), Architect mode (high-level planning).
- **Key insight:** Repo map is the killer feature - gives AI structural awareness without loading all files. Only files that need changes are fully loaded.

### GitHub Copilot (Coding Agent)
- **URL:** https://docs.github.com/en/copilot
- **Context architecture:**
  - **AGENTS.md** - Primary configuration. Supports nested files (closest one takes precedence).
  - **`.github/copilot-instructions.md`** - Repository-wide instructions.
  - **`.github/instructions/**.instructions.md`** - Pattern-matched instruction files.
  - **Cross-format support** - Also reads CLAUDE.md and GEMINI.md files.
  - **Agent profiles** - Markdown files with YAML frontmatter (name, description, prompt, tools).
  - **Agent skills** - Custom tools the agent can access.
- **Six core areas for AGENTS.md:** Commands, testing, project structure, code style, git workflow, boundaries.
- **Assessment:** The AGENTS.md format is becoming a de facto standard, supported by multiple tools.

### OpenAI Codex CLI
- **URL:** https://developers.openai.com/codex
- **GitHub:** https://github.com/openai/codex
- **Context management:**
  - **AGENTS.md** - Custom instructions file support.
  - **MCP servers** - Can consume and also serve as an MCP server.
  - **Sandbox** - macOS seatbelt or Linux sandbox (Landlock/bubblewrap).
  - **192K token context window** for reasoning about large codebases.
  - Combines AGENTS.md, MCP servers, and direct file references in a single session.

### OpenCode
- **URL:** https://opencode.ai
- **GitHub:** https://github.com/opencode-ai/opencode
- **Context management:**
  - **Dual-Agent Architecture** - Plan agent (reasoning, no edits) + Code agent (execution). Separate contexts.
  - **Automatic Context Compaction** - Summarizes older conversation history to free context window.
  - **Session Persistence** - SQLite-based persistence across terminal sessions.
  - **Agent Skills** - Discovers reusable instructions from repo or home directory, loaded on-demand.
  - **Context Filtering** - Include/exclude patterns to control what agent sees.
- **Assessment:** Open-source terminal agent with thoughtful dual-agent context isolation.

### Kiro (Amazon)
- **URL:** https://kiro.dev
- **Context management:**
  - **Spec-driven development** - Outputs user stories, technical design docs, and coding tasks before implementation.
  - **Steering files** - Provide advanced context about use cases.
  - **Native MCP integration** (including remote servers).
  - **Hooks system** - Pre/post action automation.
- **Assessment:** Unique "spec-first" approach to context. Rather than just loading code context, it generates structured planning artifacts that become the context.

### Augment Code
- **URL:** https://www.augmentcode.com
- **Context management:**
  - **200K token context engine** - Proprietary, indexes entire repositories with semantic embeddings.
  - **Real-time sync** - Millisecond-level sync with code changes.
  - **Memories** - Stores prior interactions, code snippets, diagnostic breadcrumbs.
  - **Context Engine as MCP** - Exposed as MCP server (Feb 2026). External tools using it saw 80% quality improvement with Claude Code Opus 4.5, 71% with Cursor.
  - **Three-pronged strategy:** Research-driven embeddings, expanding context sources (PR history), context as an API.
- **Key insight:** "A weaker model with good context can outperform a stronger model fumbling in the dark." Their Context Engine MCP integration proving this empirically.

### Continue.dev
- **URL:** https://continue.dev
- **GitHub:** https://github.com/continuedev/continue
- **Context management:**
  - **Codebase indexing** - Tree-sitter AST parsing + embeddings stored in `~/.continue/index/index.sqlite`.
  - **Local-first** - Embeddings calculated locally using transformers.js.
  - **Context providers** - @Codebase, @Folder, @File, @Docs, @Web.
  - **Smart chunking** - Uses tree-sitter to understand class/function boundaries.
  - **Custom RAG** - Advanced users can build custom retrieval pipelines.
- **Assessment:** Open-source, local-first approach with good extensibility. The tree-sitter chunking strategy is well-designed.

---

## 3. Agent Configuration Files & Standards

### AGENTS.md
- **URL:** https://agents.md
- **What it is:** A simple, open format for guiding coding agents. Think "README for agents."
- **Supported by:** GitHub Copilot, Codex CLI, OpenCode, Windsurf, Cursor, Kiro, and more.
- **Structure:** Markdown files with optional YAML frontmatter (name, description, prompt, tools).
- **Key properties:**
  - Nested files supported (closest takes precedence)
  - Subproject-specific instructions possible
  - Six core areas: commands, testing, project structure, code style, git workflow, boundaries
- **Assessment:** Becoming the de facto cross-tool standard. If you only create one context file, make it this.

### CLAUDE.md
- **URL:** https://code.claude.com/docs/en/memory
- **What it is:** Claude Code's native project configuration file.
- **Structure:** Plain Markdown. Loaded from multiple levels (global, project root, subdirectories).
- **Supported by:** Claude Code (native), GitHub Copilot (cross-format support).

### .cursorrules / .cursor/rules/
- **URL:** https://docs.cursor.com/context/rules
- **What it is:** Cursor's native rule system.
- **Evolution:** `.cursorrules` (single file, legacy) -> `.cursor/rules/` (directory, current).
- **Rule activation modes:** Always, Auto, Agent Requested, Manual.

### .windsurfrules
- **URL:** https://docs.windsurf.com/windsurf/cascade/memories
- **What it is:** Windsurf's project-level rule configuration.

### GEMINI.md
- **What it is:** Google's Gemini agent configuration file.
- **Supported by:** Gemini CLI, GitHub Copilot (cross-format support).

### Comparison Table

| Format | Native Tool | Cross-Tool Support | Nested | Activation Modes |
|--------|-------------|-------------------|--------|-----------------|
| AGENTS.md | GitHub Copilot | Codex, OpenCode, Windsurf, Cursor, Kiro | Yes | Always |
| CLAUDE.md | Claude Code | GitHub Copilot | Yes (filesystem levels) | Always |
| .cursor/rules/ | Cursor | No | Yes (directory-based) | Always, Auto, Agent Requested, Manual |
| .windsurfrules | Windsurf | No | No (project root) | Frontmatter-based |
| GEMINI.md | Gemini CLI | GitHub Copilot | Unknown | Always |

---

## 4. Memory Frameworks for AI Agents

### Mem0
- **URL:** https://github.com/mem0ai/mem0
- **Stars:** 48K+
- **What it does:** Universal memory layer for AI agents. Remembers user preferences, adapts to individual needs, learns over time.
- **Performance benchmarks:**
  - 26% accuracy improvement over OpenAI Memory (LOCOMO benchmark)
  - 91% faster than full-context approaches
  - 90% lower token usage
- **Integration:** Single line of code, works with OpenAI, LangGraph, CrewAI. Python and JavaScript.
- **Assessment:** Most popular memory framework. Best for chatbot and personal assistant memory patterns.

### Graphiti (by Zep)
- **URL:** https://github.com/getzep/graphiti
- **What it does:** Builds real-time temporal knowledge graphs for AI agents. Tracks how facts change over time.
- **Key features:**
  - Temporal fact management (validity windows, old facts invalidated not deleted)
  - Smart graph updates (auto-evaluates new entities against existing graph)
  - Rich edge semantics (human-readable, semantic, full-text searchable)
  - Hybrid search (semantic + BM25 + graph-based) with result fusion
  - Sub-100ms search latency
  - MCP server available
- **Assessment:** Best-in-class for scenarios requiring temporal reasoning and fact evolution. More complex to set up than Mem0.

### Letta (formerly MemGPT)
- **URL:** https://github.com/letta-ai/letta
- **What it does:** Platform for building stateful agents with OS-inspired memory management.
- **Memory architecture (3 tiers):**
  1. **Core Memory** - Always in-context (like RAM). Always visible to agent.
  2. **Archival Memory** - External vector store, queried explicitly via tool calls.
  3. **Recall Memory** - Conversation history, searchable on demand.
- **Key innovation:** Agents actively manage their own memory via function calls (read, write, search, archive). The agent is a curator, not just a consumer.
- **Recent:** Letta Code (March 2026) - memory-first coding agent, #1 model-agnostic on Terminal-Bench.
- **Assessment:** Most architecturally interesting memory system. The self-managing memory paradigm is powerful for long-running agents.

### LangMem (LangChain)
- **URL:** https://langchain-ai.github.io/langmem/
- **What it does:** Memory management abstractions for LangChain/LangGraph agents.
- **Part of:** LangChain's context engineering framework (write, select, compress, isolate strategies).

### ReMe
- **What it does:** Unified file and vector memory management for AI agents. Combines file stores and vector stores to compact conversation history, persist important facts, and provide hybrid semantic retrieval.
- **Key insight:** Long-term memory persisted as Markdown files for auditability and portability.

### MemOS
- **URL:** https://github.com/MemTensor/MemOS
- **What it does:** AI memory OS for LLM and agent systems, enabling persistent skill memory for cross-task skill reuse and evolution.

### Always On Memory Agent (Google)
- **What it does:** Open-source reference implementation for an agent that ingests information continuously, consolidates in background, retrieves later - without a conventional vector database.
- **Assessment:** Interesting alternative approach that avoids vector DB dependency.

---

## 5. MCP Servers for Context

### Context7 (Upstash)
- **URL:** https://github.com/upstash/context7
- **What it does:** Provides up-to-date, version-specific code documentation for LLMs and AI code editors.
- **Tools:**
  - `resolve-library-id` - Resolves library name to Context7 ID
  - `query-docs` - Retrieves version-specific docs for a library
- **Use case:** Fetches current documentation instead of relying on stale training data.
- **Assessment:** Excellent for keeping library documentation context fresh. Already integrated as a plugin in Claude Code.

### GitHub MCP Server
- **URL:** https://github.com/github/github-mcp-server
- **What it does:** Official GitHub MCP server giving AI tools direct access to the entire GitHub platform.
- **Capabilities:** Repository management, issue/PR automation, CI/CD intelligence, code analysis, team collaboration.
- **Assessment:** Essential for any AI coding workflow that interacts with GitHub.

### codebase-memory-mcp (DeusData)
- **URL:** https://github.com/DeusData/codebase-memory-mcp
- **What it does:** High-performance code intelligence MCP server that indexes codebases into persistent knowledge graphs.
- **Key stats:**
  - 66 languages via tree-sitter AST analysis
  - Sub-millisecond queries
  - 99% fewer tokens (benchmarked: 3,400 tokens vs 412,000 for file-by-file exploration)
  - Linux kernel (28M LOC) indexed in 3 minutes
  - Single static binary, zero dependencies
- **14 MCP tools:** Search, trace, architecture, impact analysis, Cypher queries, dead code detection, cross-service HTTP linking, ADR management.
- **Auto-detects:** Claude Code, Codex CLI, Gemini CLI, Zed, OpenCode, Aider, VS Code, and more.
- **Assessment:** Extremely impressive performance numbers. The 99% token reduction is significant. Worth deep evaluation.

### claude-context (Zilliz)
- **URL:** https://github.com/zilliztech/claude-context
- **What it does:** Semantic code search MCP server for Claude Code and other AI coding agents.
- **Key features:**
  - Hybrid BM25 + dense vector search
  - Indexes code into Milvus/Zilliz Cloud vector database
  - VS Code extension included
  - Supports OpenAI, VoyageAI, Ollama, Gemini embeddings
- **Assessment:** Good for large codebases where semantic search outperforms grep. Requires external embedding provider and vector DB.

### codebase-context (PatrickSys)
- **URL:** https://github.com/PatrickSys/codebase-context
- **What it does:** MCP server that detects team coding conventions and patterns, provides persistent memory, edit preflight checks, and hybrid search with evidence scoring.
- **Key features:**
  - Convention detection from code AND git history (not just rules you wrote)
  - Adoption percentages and trend detection (rising/declining patterns)
  - Golden file identification
  - Preflight checks before edits (`ready: false` = read listed files first)
  - Pattern queries (`get_team_patterns` for DI, state, testing, wrappers)
  - Memory system (`remember` and `get_memory` tools)
- **Assessment:** Unique approach to convention detection. The fact that it learns from git history rather than requiring manual configuration is powerful.

### Augment Context Engine MCP
- **URL:** https://www.augmentcode.com
- **What it does:** Augment's proprietary 200K token context engine exposed as MCP server.
- **Impact:** Claude Code + Opus 4.5 saw 80% quality improvement using this. Cursor saw 71% improvement.
- **Assessment:** Possibly the most impactful single MCP server for code quality. Proprietary but the results speak for themselves.

### agentic-tools-mcp
- **URL:** https://github.com/Pimzino/agentic-tools-mcp
- **What it does:** MCP server providing AI assistants with task management and agent memory capabilities with project-specific storage.

### MCP Filesystem Server
- **URL:** https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem
- **What it does:** Official MCP server for file-based context management.

---

## 6. Context Compression & Optimization

### LLMLingua (Microsoft)
- **URL:** https://github.com/microsoft/LLMLingua
- **What it does:** Compresses prompts using a small language model to identify and remove non-essential tokens. Achieves up to 20x compression with minimal performance loss.
- **Variants:**
  - **LLMLingua** (EMNLP 2023) - Original
  - **LongLLMLingua** - Mitigates "lost in the middle" issue, improves RAG by 21.4% using 1/4 tokens
  - **LLMLingua-2** - 3-6x speed improvement over v1
- **Integrations:** Prompt Flow, LangChain, LlamaIndex.
- **Assessment:** The gold standard for prompt compression. Essential for context-constrained scenarios.

### Key Compression Techniques

1. **Automatic compression** - Remove filler words, redundant phrases, non-essential clauses. 40-60% token reduction typical.
2. **Token pruning** - Dynamically discard low-importance tokens during inference.
3. **Sparse attention** (Longformer) - Selectively focus attention on smaller token subsets.
4. **PagedAttention** (vLLM, TensorRT-LLM) - Treats KV cache like virtual memory with non-contiguous blocks.
5. **NVFP4 quantization** - Cuts KV cache memory by 50%, doubling effective context length.
6. **Vision-Centric Token Compression (Vist)** - Slow-fast framework: vision encoder skims distant tokens, LLM processes proximal window.

### Compression Benchmarks
- Smart compression: 50-80% token reduction while preserving accuracy
- LLMLingua: up to 20x compression
- codebase-memory-mcp: 99.2% reduction via structural queries vs file-by-file

---

## 7. Linters & Validation Tools

### Agnix
- **URL:** https://github.com/agent-sh/agnix
- **What it does:** Linter and LSP for AI coding assistant configuration files.
- **Validates:** CLAUDE.md, AGENTS.md, SKILL.md, hooks, MCP configs.
- **Stats:** 385 rules across Claude Code, Codex CLI, OpenCode, Cursor, Copilot, and more.
- **Features:**
  - Targeted validation (`--target`), auto-fix (`--fix`), strict mode, watch mode
  - Machine-readable output (JSON, SARIF for GitHub Code Scanning)
  - IDE plugins: VS Code, JetBrains, Neovim, Zed
  - GitHub Actions support
- **Install:** `npm install -g agnix` / `brew install agnix` / `cargo install agnix`
- **Assessment:** Essential tool for teams. Ensures consistent agent configuration across projects. The LSP integration is particularly valuable.

### cclint
- **URL:** https://github.com/carlrannaberg/cclint
- **What it does:** Linter specifically for Claude Code project files.
- **Assessment:** More focused than Agnix, Claude Code only.

---

## 8. Context Engineering Patterns & Strategies

### LangChain's Four Strategies (Write, Select, Compress, Isolate)
- **URL:** https://github.com/langchain-ai/context_engineering
- **Notebooks:** `1_write_context.ipynb`, `2_select_context.ipynb`, `3_compress_context.ipynb`, `4_isolate_context.ipynb`

1. **Write** - Save context outside the context window to help agent perform tasks later.
2. **Select** - Pull relevant context into the window when needed (RAG, file reading, tool calls).
3. **Compress** - Retain only tokens required for the task (summarization, pruning, compaction).
4. **Isolate** - Split context across agents/subprocesses to prevent interference.

### Manus Context Engineering Patterns (Production-Proven)
- **Source:** https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus

1. **KV-Cache Optimization:**
   - Keep prompt prefix stable (append-only contexts)
   - Deterministic serialization
   - Avoid timestamps in system prompts
   - Result: 10x cost reduction ($0.30 vs $3.00/MTok with Claude Sonnet)

2. **Tool Masking (not dynamic loading):**
   - Mask token logits during decoding instead of adding/removing tools
   - Preserves KV-cache integrity
   - Use response prefill modes (Auto, Required, Specified)
   - Prefixed tool names (`browser_*`, `shell_*`) for granular constraint

3. **File System as Memory:**
   - File system = "unlimited, persistent, directly operable" context extension
   - Compression is restorable (preserve URLs/file paths for recovery)
   - Context shrinking without information loss

4. **Attention Manipulation via todo.md:**
   - Create/update todo.md files step-by-step
   - Pushes objectives into recent attention spans
   - Combats "lost-in-the-middle" in 50+ tool-call sequences

5. **Error Preservation:**
   - Keep failed actions visible in context
   - Models implicitly update internal beliefs
   - Avoid repeating mistakes without explicit retry logic

6. **Diversity Injection:**
   - Controlled randomness through varied serialization templates
   - Prevents pattern-matching degradation in repetitive tasks

### Dynamic Context Loading Patterns

**The Core Tension:**
- Tools consume massive tokens: 5-server MCP setup = 55K tokens before conversation starts; some setups hit 134K tokens just for tool definitions.
- Dynamic tool loading sounds good but experiments show: avoid dynamically adding/removing tools mid-iteration unless absolutely necessary (breaks KV cache).

**Resolution Strategies:**
1. **Lazy file loading** - Write info to files, give agent tools to selectively read what's needed.
2. **Description-only loading** - Load tool descriptions (not full definitions) initially; full definitions on-demand.
3. **Static prefix + dynamic suffix** - Keep system instructions and tool definitions static (95%+ cache hit rate), append dynamic content at end.
4. **Context budget** - Treat attention like a budget. Ask: "What does the model actually need for THIS specific query?"

### Tool Description Optimization
- Keep toolset minimal or dynamically load definitions based on task.
- For 50 tools, model parses 50 descriptions every turn. Brevity matters.
- Claude Code's approach: skill descriptions always loaded, full instructions loaded only when matched.

### Memory Patterns

| Pattern | Example Tools | Best For |
|---------|--------------|----------|
| File-based (Markdown) | Claude Code (CLAUDE.md), Aider (CONVENTIONS.md) | Auditability, version control, simplicity |
| Vector DB | Mem0, Continue.dev, claude-context | Semantic search, large codebases |
| Knowledge Graph | Graphiti/Zep, codebase-memory-mcp | Temporal reasoning, relationship tracking |
| OS-inspired tiers | Letta (Core/Archival/Recall) | Long-running agents, self-managing memory |
| Hybrid (file + vector) | ReMe, codebase-context (PatrickSys) | Combining structure with semantic retrieval |
| Convention Detection | codebase-context (PatrickSys) | Team pattern enforcement, evolving standards |

---

## 9. Curated Resource Lists

### awesome-context-engineering (yzfly)
- **URL:** https://github.com/yzfly/awesome-context-engineering
- **Focus:** Resources, papers, tools, and best practices for context engineering in AI agents and LLMs.

### Awesome-Context-Engineering (Meirtz)
- **URL:** https://github.com/Meirtz/Awesome-Context-Engineering
- **Focus:** Comprehensive survey - hundreds of papers, frameworks, implementation guides. More academic.

### awesome-context-engineering (jihoo-kim)
- **URL:** https://github.com/jihoo-kim/awesome-context-engineering
- **Focus:** Open-source libraries for long-term memory, MCP, prompt/RAG compression, multi-agent.

### awesome-claude-code
- **URL:** https://github.com/hesreallyhim/awesome-claude-code
- **Focus:** Skills, hooks, slash-commands, agent orchestrators, applications, and plugins for Claude Code.

### awesome-claude-code-toolkit
- **URL:** https://github.com/rohitg00/awesome-claude-code-toolkit
- **Stats:** 135 agents, 35 curated skills (+400K via SkillKit), 42 commands, 150+ plugins, 19 hooks.

### awesome-cursorrules
- **URL:** https://github.com/PatrickJS/awesome-cursorrules
- **Focus:** Configuration files for Cursor AI editor.

### awesome-agent-skills
- **URL:** https://github.com/VoltAgent/awesome-agent-skills
- **Focus:** 1000+ agent skills from official dev teams and community, compatible with Codex, Cursor, Gemini CLI, and others.

### Context Engineering (davidkimai)
- **URL:** https://github.com/davidkimai/Context-Engineering
- **Focus:** First-principles handbook inspired by Karpathy and 3Blue1Brown. Context design, orchestration, optimization.

### Agent-Skills-for-Context-Engineering
- **URL:** https://github.com/muratcankoylan/Agent-Skills-for-Context-Engineering
- **Focus:** Practical agent skills for context engineering, multi-agent architectures, production systems.

### context-engineering-intro
- **URL:** https://github.com/coleam00/context-engineering-intro
- **Focus:** Hands-on practical guide for AI coding assistants.

---

## 10. Key Takeaways & What Works

### The Landscape in April 2026

The context engineering ecosystem has matured significantly. Key trends:

1. **AGENTS.md is winning the standards war.** Supported by GitHub Copilot, Codex, OpenCode, Windsurf, Cursor, Kiro, and more. Most tools also read CLAUDE.md. Having both is the safe play.

2. **MCP is the universal integration layer.** 97M+ monthly SDK downloads, 75+ official connectors. Every major tool supports it. Building context tools as MCP servers ensures maximum compatibility.

3. **Repomix dominates context packaging** (22.4K stars). For repo-to-LLM conversion, it's the clear winner.

4. **Memory is stratifying into tiers:**
   - Simple: File-based (CLAUDE.md, AGENTS.md) - works, version-controlled, human-readable
   - Medium: Vector DB (Mem0, Continue.dev) - semantic search, good for large codebases
   - Complex: Knowledge graphs (Graphiti, codebase-memory-mcp) - temporal reasoning, relationships
   - Advanced: Self-managing (Letta) - agent curates its own memory

5. **Context compression is production-ready.** LLMLingua achieves 20x compression. codebase-memory-mcp achieves 99% token reduction through structural queries. These are massive efficiency gains.

6. **The "Augment Effect" is real.** When Augment exposed its Context Engine as MCP, Claude Code quality jumped 80%. Context quality matters more than model quality.

7. **Convention detection is an emerging category.** PatrickSys's codebase-context learns team patterns from git history, not just config files. This "learn from the codebase" approach is likely the future.

### What Actually Works in Production

Based on the evidence gathered:

| Need | Best Tool(s) | Why |
|------|-------------|-----|
| Project instructions | AGENTS.md + CLAUDE.md | Cross-tool compatibility |
| Repo packaging | Repomix | Mature, MCP-enabled, token-aware |
| Code intelligence | codebase-memory-mcp | 99% token reduction, 66 languages, zero deps |
| Semantic search | claude-context (Zilliz) or Augment MCP | Hybrid search, proven quality improvements |
| Library docs | Context7 | Always up-to-date, library-specific |
| Memory (simple) | File-based CLAUDE.md + auto-memory | Zero infrastructure, version-controlled |
| Memory (production) | Mem0 or Graphiti/Zep | Proven at scale, good benchmarks |
| Memory (advanced) | Letta | Self-managing, model-agnostic |
| Config validation | Agnix | 385 rules, multi-tool, IDE/CI integration |
| Prompt compression | LLMLingua-2 | 20x compression, integrates with LangChain/LlamaIndex |
| Team conventions | codebase-context (PatrickSys) | Learns from git history, preflight checks |
| Full automation | claude-skills-automation or AgentSys | Hooks-based, zero-friction memory |
| Context strategy | LangChain notebooks | Write/Select/Compress/Isolate framework |

### Patterns to Adopt

1. **Layer your context:** Static instructions (AGENTS.md) + dynamic retrieval (MCP) + compressed history (compaction).
2. **Use subagents for context isolation.** Fresh context per subtask, summary back.
3. **Keep prompt prefixes stable** for KV-cache optimization (Manus lesson).
4. **File system as extended memory.** Write to files, read selectively (Manus lesson).
5. **Validate your config.** Use Agnix to lint CLAUDE.md/AGENTS.md before they cause subtle issues.
6. **Measure token budgets.** Use Repomix's token counting to understand what fits.
7. **Don't dynamically add/remove tools mid-iteration.** Use tool masking instead if needed.

### Gaps and Opportunities

1. **No universal context format.** AGENTS.md is closest but lacks structured metadata. CCS (Codebase Context Spec) tries to address this but hasn't caught on.
2. **Convention learning is underdeveloped.** Only PatrickSys's tool does this well. Git history mining for team patterns is a huge opportunity.
3. **Cross-tool memory sharing.** Your Claude Code memories don't carry to Cursor. No standard for portable agent memory.
4. **Context quality metrics.** No standard way to measure "how good is my context?" beyond downstream task performance.
5. **Proactive context.** Most tools are reactive (agent requests context). Few proactively push relevant context based on what the agent is about to do.

---

## Appendix: CLAUDE.md Generator Tools

### claudemd-generator
- **URL:** https://github.com/ncreighton/claudemd-generator
- **What it does:** Generates self-contained CLAUDE.md files for Claude Code projects.

### CLAUDE.md Generator (ExampleConfig)
- **URL:** https://exampleconfig.com/tools/claude-md-generator
- **What it does:** AI-powered CLAUDE.md generator achieving reported 95% code accuracy and 40-70% productivity gains. Templates for SaaS, e-commerce, APIs, full-stack.

### Cursor Rules Generators
- **cursorrules.org** - Free AI-generated .cursorrules with framework detection
- **cursorrules.top** - Optimized rules based on tech stack
- **cursor.directory/generate** - Rules and MCP server plugins
- **airul CLI** - Takes your docs and generates .cursorrules from them

### Claude-Mem
- **URL:** https://github.com/thedotmack/claude-mem
- **What it does:** Claude Code plugin for automatic session memory. Captures tool usage, compresses with AI, injects relevant context in future sessions.
- **Hook events:** SessionStart (inject), UserPromptSubmit (capture), PostToolUse (record), Stop (compress/persist).
- **Storage:** SQLite database, local-only.
- **Strategy:** Progressive disclosure - injects historical context without burning token budget.

### claude-skills-automation
- **URL:** https://github.com/Toowiredd/claude-skills-automation
- **What it does:** Zero-friction automated memory and context management via hooks.
- **Stats:** 12 automation hooks, 8 skills, <500ms overhead, <100MB disk/year.
- **Features:** Automatic context restoration, decision tracking, permanent memory.

### AgentSys
- **URL:** https://github.com/agent-sh/agentsys
- **What it does:** Runtime orchestrating agents for task selection, branch management, code review, CI, PR comments, deployment.
- **Stats:** 19 plugins, 47 agents, 40 skills, 30K lines of lib code, 3,583 tests.
- **Platforms:** Claude Code, OpenCode, Codex CLI, Cursor, Kiro.

---

*Research conducted 2026-04-04. All star counts and stats are approximate and current as of research date.*
