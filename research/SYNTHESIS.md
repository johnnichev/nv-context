# UltraContext Research Synthesis

**Date:** 2026-04-04
**Sources:** 6 parallel research agents covering 150+ sources (articles, YouTube, X/Twitter, tools, theory, agent configs)

---

## The Definitive Understanding

### What Context Engineering IS

**Consensus definition** (converged from Karpathy, Schmid, Chase, Osmani, Anthropic):
> The systematic discipline of designing dynamic systems that provide the right information and tools, in the right format, at the right time, so an LLM can accomplish a task.

**It is NOT:**
- Prompt engineering (that's a subset)
- Just RAG (that's one component)
- Writing a clever system prompt (that's one layer)

**The paradigm shift:** "Most agent failures are not model failures -- they are context failures." (Philipp Schmid, Google DeepMind)

### The Core Paradox

Agents need MORE context for complex tasks, but performance DEGRADES as context grows. A focused 300-token context often outperforms an unfocused 113K-token context. Using 40% of context window outperforms using 90%.

---

## The 10 Laws of Context Engineering

Distilled from all research:

### 1. Less Is More (The ETH Zurich Law)
LLM-generated config files reduce success by 3% and increase costs 20%+. Human-written files only marginally help (+4%). **Only include what agents CANNOT discover by reading your code.**

### 2. Commands Beat Prose
One executable command with full flags outperforms three paragraphs of description. One code snippet showing a pattern outperforms lengthy explanations.

### 3. Context Is a Finite Resource (The Attention Budget Law)
Every token in your config competes with the actual task. Frontier LLMs follow ~150-200 instructions consistently. Claude Code's system prompt already uses ~50. Target under 200 lines per root file.

### 4. Progressive Disclosure (The Architecture Law)
Root file → orientation. Subdirectory files → scoped details. Skills → on-demand knowledge. MCP → dynamic retrieval. Never dump everything into one file.

### 5. Stable Prefixes, Dynamic Suffixes (The KV-Cache Law)
Keep system instructions and tool definitions static. Append dynamic content at the end. Cached tokens cost 10x less. A single changed token at the start invalidates the entire cache.

### 6. The Three-Tier Boundary Framework
Every configuration must include: Always do / Ask first / Never do. The single most common helpful constraint: "Never commit secrets."

### 7. Deterministic Tools for Deterministic Tasks (The Hook Law)
Don't use LLMs for linting, formatting, or style enforcement. Use hooks and scripts. Reserve agent config for things only an LLM can do.

### 8. File System as Extended Memory (The Manus Law)
Write state to files, read selectively. The todo.md pattern pushes objectives into recent attention. Compression should be reversible (keep URLs/paths even when dropping content).

### 9. Isolation Over Sharing (The Multi-Agent Law)
"Share memory by communicating, don't communicate by sharing memory." Sub-agents work best with focused, isolated contexts. Each subagent explores extensively but returns condensed summaries.

### 10. Iterate on Observed Failures (The Living Document Law)
Start minimal. Observe agent mistakes. Add instructions that prevent those specific mistakes. Prune regularly. Treat config like code.

---

## The Four Universal Operations

Independently identified by Anthropic, LangChain, Google ADK:

| Operation | What | How |
|-----------|------|-----|
| **Write** | Persist information | Scratchpads, memories, files, todo.md |
| **Select** | Retrieve relevant information | RAG, tool selection, memory retrieval, glob/grep |
| **Compress** | Reduce tokens while retaining meaning | Summarization, observation masking, tool result clearing |
| **Isolate** | Partition context | Sub-agents, fresh context windows, scoped rules |

---

## The Context Stack (What Goes Into the Window)

Seven components (Philipp Schmid's framework):

1. **System Prompt / Instructions** - Agent identity, behavior rules, boundaries
2. **User Prompt** - The current task/question
3. **State/History** - Conversation turns, tool outputs, intermediate results
4. **Long-Term Memory** - Cross-session facts, preferences, domain knowledge
5. **Retrieved Information** - RAG results, file contents, documentation
6. **Available Tools** - Tool descriptions and parameters
7. **Structured Output** - Expected response format/schema

---

## The File Ecosystem (April 2026)

| File | Tool Support | Best For |
|------|-------------|----------|
| `AGENTS.md` | 25+ tools, Linux Foundation | Universal baseline |
| `CLAUDE.md` | Claude Code, GitHub Copilot | Claude-specific (@imports, skills) |
| `.cursor/rules/*.mdc` | Cursor | Cursor-specific (glob-scoped activation) |
| `.github/copilot-instructions.md` | GitHub Copilot | Copilot-specific |
| `GEMINI.md` | Gemini CLI | Gemini-specific |
| `.windsurf/rules/*.md` | Windsurf | Windsurf-specific |
| `CONVENTIONS.md` | Aider | Aider-specific |

**Pragmatic recommendation:** Start with AGENTS.md (widest support) + CLAUDE.md (deepest features). Keep overlap minimal.

---

## What Actually Earns Inclusion

| Include (Landmines) | Exclude (Maps) |
|---------------------|----------------|
| Non-standard build commands with flags | Directory structure |
| Custom middleware that differs from standard | Tech stack overview agents can read from package.json |
| Gotchas that will waste hours if missed | Module explanations |
| Counterintuitive patterns with WHY | Standard architectural patterns |
| Tool requirements (`uv` for packages) | Anything in README or config files |
| Warnings about deprecated code | Self-evident practices like "write clean code" |

---

## The Maturity Framework (L0-L6)

| Level | Name | Description |
|-------|------|-------------|
| L0 | Absent | No config file |
| L1 | Basic | File exists, may be `/init` boilerplate |
| L2 | Scoped | Explicit MUST/MUST NOT with RFC 2119 language |
| L3 | Structured | Multiple referenced files by concern |
| L4 | Abstracted | Path-scoped rules (different rules per directory) |
| L5 | Maintained | L4 + active upkeep, staleness tracking |
| L6 | Adaptive | Skills, MCP servers, dynamic capability loading |

**Most repos: L1-L2. Goal of UltraContext: L5-L6.**

---

## Production Patterns (Battle-Tested)

### From Manus (50+ tool calls per task, 4 framework rebuilds)
1. KV-cache optimization (10x cost reduction via stable prefixes)
2. Tool masking instead of dynamic loading (preserves cache)
3. File system as memory (todo.md pattern for attention)
4. Preserve errors in context (implicit belief updating)
5. Diversity injection (prevent few-shot pattern collapse)

### From Anthropic (Claude Code)
1. CLAUDE.md loads at start; grep/glob for just-in-time retrieval
2. Auto-compact at 95% capacity (microcompact before full compact)
3. Subagents as context isolation primitive
4. Skills for on-demand context (descriptions always loaded, full content on match)

### From Google ADK
1. Context as "compiled view over richer stateful system"
2. Separate storage (sessions, memory, artifacts) from presentation (working context)
3. Stable prefixes + variable suffixes for cache efficiency
4. Narrative casting for multi-agent handoffs

---

## Key Tools for the Ecosystem

| Need | Best Tool | Why |
|------|-----------|-----|
| Config validation | Agnix | 385 rules, multi-tool, IDE/CI |
| Context packaging | Repomix | 22.4K stars, MCP-enabled |
| Code intelligence | codebase-memory-mcp | 99% token reduction |
| Library docs | Context7 | Always current, version-specific |
| Prompt compression | LLMLingua-2 | Up to 20x compression |
| Convention detection | codebase-context (PatrickSys) | Learns from git history |
| Memory (production) | Mem0 / Graphiti | 48K stars / temporal knowledge graphs |

---

## What UltraContext Must Do

Based on ALL research, the skill must:

1. **Analyze** the codebase for non-inferable information ONLY
2. **Generate** multi-format configs (AGENTS.md, CLAUDE.md, .cursorrules, copilot-instructions)
3. **Structure** progressive disclosure (root → subdirs → skills → MCP)
4. **Apply** the three-tier boundary framework
5. **Enforce** length constraints (<200 lines root, <100 ideal)
6. **Use** RFC 2119 language and emphasis patterns
7. **Include** executable commands and code examples, NOT prose
8. **Set up** hooks for deterministic enforcement
9. **Create** skills infrastructure for on-demand context
10. **Score** quality against the L0-L6 maturity framework
11. **Support** iterative refinement based on observed failures
12. **Recommend** MCP servers and tools for the specific project's needs
