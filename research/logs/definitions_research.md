# Context Engineering: Theoretical Foundations and Definitions Research

**Research Date:** 2026-04-04
**Purpose:** Establish a solid theoretical foundation for the nv:context skill by deeply researching the definitions, origins, components, techniques, and expert opinions surrounding "context engineering" as applied to AI/LLM agents.

---

## Table of Contents

1. [Definitions and Origins](#1-definitions-and-origins)
2. [Key Definitions from Industry Leaders](#2-key-definitions-from-industry-leaders)
3. [Context Engineering vs Prompt Engineering](#3-context-engineering-vs-prompt-engineering)
4. [Theoretical Foundations](#4-theoretical-foundations)
5. [Core Components of Context Engineering](#5-core-components-of-context-engineering)
6. [Techniques and Strategies](#6-techniques-and-strategies)
7. [Academic Research](#7-academic-research)
8. [Expert Opinions and Practitioner Insights](#8-expert-opinions-and-practitioner-insights)
9. [Real-World Implementation Case Studies](#9-real-world-implementation-case-studies)
10. [Repository-Level Context Files](#10-repository-level-context-files)
11. [Key Frameworks and Mental Models](#11-key-frameworks-and-mental-models)
12. [Implications for nv:context](#12-implications-for-nvcontext)
13. [Sources](#13-sources)

---

## 1. Definitions and Origins

### Origin of the Term

The term "context engineering" gained prominence in **mid-June 2025**, catalyzed by two pivotal endorsements:

**Tobi Lutke (CEO, Shopify)** -- June 19, 2025 tweet:
> "I really like the term 'context engineering' over prompt engineering. It describes the core skill better: the art of providing all the context for the task to be plausibly solvable by the LLM."

**Andrej Karpathy** -- shortly after, endorsing and expanding the concept:
> "+1 for 'context engineering' over 'prompt engineering'. People associate prompts with short task descriptions you'd give an LLM in your day-to-day use. When in every industrial-strength LLM app, context engineering is the delicate art and science of filling the context window with just the right information for the next step."

**Simon Willison** -- June 27, 2025, argued the term would "stick" because its inferred definition is much closer to the intended meaning than "prompt engineering," which most people reduce to "typing things into a chatbot."

The concept draws from earlier work in ubiquitous computing research (dating to 2001), but the modern AI-specific usage crystallized in 2025 as agent-based applications exposed the limitations of simple prompt engineering.

### Why the Terminology Shift Matters

The problem with "prompt engineering" is that most people's inferred definition trivializes the discipline entirely. "Context engineering" naturally evokes a broader, more accurate understanding of the skill involved -- designing the complete information environment in which an LLM operates.

---

## 2. Key Definitions from Industry Leaders

### Anthropic (Official Engineering Blog)
> "Context engineering is the set of strategies for curating and maintaining the optimal set of tokens (information) during LLM inference, including all the other information that may land there outside of the prompts."

### Philipp Schmid (Senior AI Developer Relations Engineer, Google DeepMind)
> "Context engineering is the discipline of designing and building dynamic systems that provides the right information and tools, in the right format, at the right time, to give an LLM everything it needs to accomplish a task."

### Harrison Chase (CEO, LangChain)
> "Context engineering is building dynamic systems to provide the right information and tools in the right format such that the LLM can plausibly accomplish the task."

### Andrej Karpathy
> "Context engineering is the delicate art and science of filling the context window with just the right information for the next step."

### Addy Osmani (Google Chrome)
> "The practice of providing an AI with all the information and tools it needs to successfully complete a task -- not just a cleverly worded prompt."

### Martin Fowler / Thoughtworks
> "Context engineering means curating what the model sees so that you get a better result."

### Common Thread Across All Definitions
All definitions emphasize:
1. **Systemic** -- It is about designing systems, not crafting individual strings
2. **Dynamic** -- Context must be assembled per-request, not static
3. **Comprehensive** -- Encompasses ALL information the LLM sees (prompts, tools, memory, retrieved data, state)
4. **Right-sizing** -- The right information at the right time, not everything all the time
5. **Task-oriented** -- Focused on enabling task completion, not clever phrasing

---

## 3. Context Engineering vs Prompt Engineering

### The Fundamental Distinction

| Dimension | Prompt Engineering | Context Engineering |
|-----------|-------------------|---------------------|
| **Focus** | Individual instruction optimization | Comprehensive information ecosystem |
| **Scope** | Words, phrasing, examples within a single input | Tools, memory, data architecture, retrieval, state |
| **Persistence** | Stateless (single input-output) | Stateful with short-term and long-term memory |
| **Scalability** | Limited, brittle at scale | Designed for consistency and reuse |
| **Approach** | Ad hoc, reactive, intuition-based | Systemic, programmatic, repeatable |
| **Metaphor** | Writing a question | "Writing the full screenplay for the AI" |
| **Best For** | One-off tasks, chatbot interactions | Production-grade agents, pipelines, complex workflows |

### Key Insight (Addy Osmani)
> "If prompt engineering was about coming up with a magical sentence, context engineering is about writing the full screenplay for the AI."

### Relationship
Prompt engineering is a **subset** of context engineering. It represents optimizing how dynamic data assembles into prompts -- one component of the larger discipline. Context engineering subsumes prompt engineering while adding retrieval, memory, tools, state management, and system architecture.

---

## 4. Theoretical Foundations

### 4.1 Context as Finite Resource

LLMs operate within finite context windows (measured in tokens). This creates the fundamental constraint that drives context engineering. Key concepts:

- **Attention Budget**: Every token in the context window depletes a finite attention budget. The transformer architecture creates n-squared pairwise relationships between tokens; longer sequences stretch the model's ability to capture these relationships.
- **Context Rot**: As token counts increase, models show reduced accuracy in recalling information from that context. This is a performance gradient, not a cliff -- models remain capable at longer contexts but show reduced precision versus shorter contexts.
- **The NoLima Finding**: Research has shown that for many popular LLMs, "performance degrades significantly as context length increases."
- **Paradoxical Finding**: "A focused 300-token context often outperforms an unfocused 113,000-token context in conversation tasks." (FlowHunt analysis of LongMemEval)

### 4.2 The CPU/RAM Analogy

**Andrej Karpathy's mental model**: Think of the LLM as a CPU and its context window as RAM/working memory. The engineer acts like an operating system, "loading that working memory with just the right code and data for the task."

**Addy Osmani extends this**: The context engineer acts like an operating system, deciding what to load into limited working memory for each computation cycle.

### 4.3 Entropy Reduction Framework

Context engineering addresses "the fundamental asymmetry in human-machine communication." Humans fill conversational gaps through cultural knowledge and situational awareness; machines require explicit representation. This gap manifests as **information entropy**, and context engineering is fundamentally about "preprocessing contexts for machines -- compressing high-entropy human intentions into low-entropy machine-processable representations."

### 4.4 Context Failure Modes (Drew Breunig's Taxonomy)

Four critical failure modes when context is poorly engineered:

1. **Context Poisoning**: Hallucinated information makes it into context and compounds through agent iterations
2. **Context Distraction**: Excessive history causes models to repeat past patterns rather than reason freshly
3. **Context Confusion**: Irrelevant tools/documents obscure correct choices
4. **Context Clash**: Contradictory information paralyzes decision-making

### 4.5 The Context Quality Principle

**Philipp Schmid (Google DeepMind)**:
> "Most agent failures are not model failures anymore, they are context failures."

This represents a paradigm shift: the bottleneck in AI agent performance has moved from model capability to context quality. Success depends primarily on information quality, not model sophistication or code complexity.

### 4.6 Compiled View Model (Google ADK)

Context is best understood as "a compiled view over a richer stateful system":
- **Sessions, memory, and artifacts (files)** are the sources -- the full, structured state
- **Flows and processors** are the compiler pipeline -- transforming state into context
- **Working context** is the compiled view shipped to the LLM for one invocation

---

## 5. Core Components of Context Engineering

### 5.1 System Prompts / Instructions

The foundational layer that establishes agent behavior, role, and constraints.

**Anthropic's "Altitude Principle"** -- Find the Goldilocks zone between:
- **Too brittle**: Hardcoded if-else logic creates fragility
- **Too vague**: General guidance without concrete signals

**Best Practices (Anthropic)**:
- Use clear, simple language
- Organize into distinct sections (XML tags or Markdown headers)
- Strive for minimal information that fully outlines expected behavior
- Test with the best available model first, then add examples based on failure modes
- Use `<background_information>`, `<instructions>`, tool guidance, output descriptions

### 5.2 Tool Descriptions

Well-designed tools share characteristics with quality codebases:
- Self-contained and robust to errors
- Extremely clear regarding intended use
- Descriptive, unambiguous input parameters
- Minimal functional overlap

**Critical Finding (LangChain)**: Applying RAG to tool descriptions -- dynamically selecting which tools to show based on the task -- improved accuracy **3-fold** compared to dumping all tool descriptions into context.

**Manus Insight**: Rather than dynamically removing tools (which invalidates KV-cache), use a context-aware state machine that **masks token logits** during decoding to constrain available actions.

### 5.3 Memory and State Management

#### Short-Term Memory (Session/Thread)
- Current conversation history and recent exchanges
- Tool outputs and intermediate results
- "Scratchpad" for in-progress work
- Stored with lower TTL values

#### Long-Term Memory (Cross-Session)
Three types (cognitive science inspired):
- **Episodic**: Past events, user interactions, preferences
- **Semantic**: Domain knowledge, world facts, relationships
- **Procedural**: Workflows, rules, behavioral instructions

#### Working Memory (Optional)
- Temporary space for multi-step tasks
- Cleared after task completion

**OpenAI's State-Based vs Retrieval-Based Memory**:
State-based memory is preferred for complex domains because it:
- Encodes knowledge as structured, authoritative fields with clear precedence rules
- Supports belief updates instead of fact accumulation
- Enables deterministic decision-making without fragile semantic search

**Memory Scope Separation (OpenAI)**:
- **Global Memory**: Durable preferences persisting across sessions
- **Session Memory**: Short-lived, task-specific context
- Key principle: "If it should affect future tasks by default, store it globally; if only now, keep session-scoped."

### 5.4 Dynamic Context Retrieval (RAG and Beyond)

RAG is one component of context engineering, not a synonym for it. Context engineering incorporates RAG alongside other techniques.

**Anthropic's "Just-In-Time" Approach**:
- Maintain lightweight identifiers (file paths, queries, links)
- Dynamically load data using tools rather than preprocessing all data upfront
- Benefits: reduced token overhead, progressive disclosure, metadata-driven behavioral refinement

**Hybrid Strategy**: Some applications retrieve foundational data upfront for speed while enabling autonomous exploration. Claude Code exemplifies this -- CLAUDE.md files load initially; tools like glob and grep enable just-in-time file retrieval.

### 5.5 Structured Outputs

- Defined JSON schemas ensuring LLM outputs integrate with dependent systems
- Type specifications and examples for consistency
- Critical for downstream tool compatibility and multi-agent coordination

### 5.6 Examples (Few-Shot)

Rather than exhaustive edge case lists, curate "diverse, canonical examples that effectively portray the expected behavior." For LLMs, examples function as "pictures" worth extensive description.

**Caution (Manus)**: Few-shot examples can backfire by causing models to blindly repeat patterns. Introduce structured variation (alternate serialization templates, varied phrasing, minor randomization) to prevent "few-shotting into a rut."

### 5.7 User Input

The immediate task or question, structured using delimiters to prevent ambiguity (e.g., `<user_query>` tags for explicit boundaries).

---

## 6. Techniques and Strategies

### 6.1 The Four Core Strategies (LangChain)

1. **Write** -- Information Persistence: Save notes, memories, state across execution steps
2. **Select** -- Strategic Retrieval: Pull the right information when needed (RAG, tool selection, memory retrieval)
3. **Compress** -- Intelligent Distillation: Reduce tokens while retaining what matters (summarization, trimming)
4. **Isolate** -- System Partitioning: Split context across separate agents so each gets only what it needs

### 6.2 Context Compression Techniques

#### Summarization
- **Recursive**: Summaries of summaries
- **Hierarchical**: Multiple abstraction levels
- **Targeted**: Compress specific components only

#### Token Pruning
- **Selective Context**: Uses small LM to judge self-information of tokens; low-information tokens pruned
- **LLMLingua** (Microsoft): Uses perplexity to determine token importance; coarse-grained then fine-grained pruning
- **LongLLMLingua**: Considers question perplexity conditioned on documents for relevance

#### Observation Masking (JetBrains Research, NeurIPS 2025)
- Preserves reasoning and actions in full
- Replaces older environment observations with placeholders
- **Key finding**: Outperforms LLM summarization in efficiency and reliability
- Reduces costs by ~50% without degrading performance
- In 4 of 5 test settings, masking was cheaper with equal or better performance

#### Hybrid Approach (JetBrains)
Combine observation masking as primary defense with selective summarization for high-value transitions.

### 6.3 Long-Horizon Task Techniques (Anthropic)

#### Compaction
Summarize conversations nearing window limits and reinitiate with compressed summaries. Balance:
- Recall maximization (capture all relevant information initially)
- Precision improvement (iteratively eliminate superfluous content)
- "Tool result clearing" = lightest-touch compaction

#### Structured Note-Taking (Agentic Memory)
Agents regularly persist notes outside the context window, retrieving them later. Enables:
- Persistent memory with minimal overhead
- Progress tracking across complex tasks
- Critical dependency maintenance

#### Sub-Agent Architectures
Specialized sub-agents handle focused tasks within clean context windows. Each may consume tens of thousands of tokens but returns condensed summaries (1,000-2,000 tokens). Achieves separation of concerns.

### 6.4 KV-Cache Optimization (Manus)

The most impactful metric for production agents (100:1 input-to-output token ratio):
- **Stable prefixes**: Avoid timestamps or dynamic content at prompt start
- **Append-only context**: Never modify previous actions/observations
- **Session routing**: Use session IDs for consistent worker routing
- Cost difference: cached tokens cost **10x less** than uncached

### 6.5 File System as Extended Context (Manus)

Treat the file system as unlimited, persistent, externalized memory:
- Model learns to read/write files on demand
- Compression remains reversible (drop content but keep URLs/paths)
- The `todo.md` pattern: create and update a task file to push objectives into recent attention span

### 6.6 Attention Manipulation Through Recitation (Manus)

Creating and updating a `todo.md` file throughout task execution:
- Pushes objectives into recent attention span
- Avoids "lost-in-the-middle" issues
- Reduces goal misalignment in 50+ tool-call sequences

### 6.7 Preserve Failure States (Manus)

Leave errors in context. When models see failed actions and stack traces, they implicitly update internal beliefs, shifting priors away from similar mistakes.

### 6.8 Context Trimming Strategies (OpenAI)

- Keep only the last N user turns (where turn = user message + all subsequent activity)
- When trimming occurs, reinject session-scoped memories into system prompt
- **Context Budget**: Using 40% of a 128K window gives better results than using 90%

### 6.9 The Pyramid Approach (Redis / Salvatore Sanfilippo)

Start with general background information, then progress to specific details:
1. First: Codebase structure, conventions, architecture
2. Then: Specific implementation requirements
3. Finally: Task details

### 6.10 Relevance Scoring (RIR Framework)

Score and filter context based on three vectors:
- **Recency**: How recent is the information?
- **Importance**: How critical is it to the current task?
- **Relevance**: How semantically related is it?

---

## 7. Academic Research

### 7.1 "A Survey of Context Engineering for Large Language Models" (arxiv: 2507.13334)

**Authors**: Lingrui Mei, Jiayu Yao, Yuyao Ge, et al.
**Scope**: Analyzed over 1,400 research papers

**Framework Proposed** -- Two-level decomposition:

**Foundational Components:**
- Context retrieval and generation
- Context processing
- Context management

**System-Level Implementations:**
- Retrieval-augmented generation (RAG)
- Memory systems and tool-integrated reasoning
- Multi-agent systems

**Key Finding**: "A fundamental asymmetry exists between model capabilities" -- modern LLMs demonstrate strong proficiency in comprehending complex contexts but show significant limitations in producing lengthy, sophisticated outputs independently.

**Performance Data**: RAG and tool integration boost performance by 10-20% and 15%, respectively.

### 7.2 "Agentic Context Engineering" (ACE) (arxiv: 2510.04618)

**Framework**: Treats contexts as "evolving playbooks" that accumulate, refine, and organize strategies through generation, reflection, and curation.

**Addresses Two Problems**:
- **Brevity bias**: Drops domain insights for concise summaries
- **Context collapse**: Iterative rewriting erodes details over time

**Results**:
- +10.6% improvement on agent benchmarks
- +8.6% improvement on finance domain
- Matches top-ranked production agents while using smaller open-source models
- Can adapt without labeled supervision using natural execution feedback

### 7.3 "The Complexity Trap" (JetBrains Research, NeurIPS 2025)

**Finding**: Simple observation masking is as efficient as LLM summarization for agent context management. Both methods reduce costs by ~50%, but masking achieves 2.6% higher solve rates while costing 52% less.

**Surprising Finding**: Agents using summarization ran 13-15% longer -- LLM-generated summaries may smooth over signs indicating the agent should stop trying.

### 7.4 Context Compression Research

**LLMLingua** (Microsoft, EMNLP 2023, ACL 2024): Achieves up to 20x compression with minimal performance loss.

**Selective Context**: Compress input to ChatGPT to process 2x more content, saving 40% memory and GPU time.

**NAACL 2025 Survey**: Comprehensive taxonomy of prompt compression methods covering token pruning, abstractive compression, and extractive compression.

---

## 8. Expert Opinions and Practitioner Insights

### Anthropic (Engineering Blog)

**Core Message**: "Be thoughtful and keep your context informative, yet tight."

**Guiding Principle**: Find the smallest possible set of high-signal tokens maximizing desired outcomes. As capabilities scale, smarter models require less prescriptive engineering. Recommendation: "Do the simplest thing that works."

**On Tools**: If a human engineer can't definitively say which tool should be used in a given situation, an AI agent can't be expected to do better. Curate a minimal viable set.

**On Sub-Agents**: Each sub-agent may consume tens of thousands of tokens but returns condensed summaries (1,000-2,000 tokens), achieving separation of concerns.

### Google DeepMind (Philipp Schmid)

**Key Insight**: "Most agent failures are not model failures anymore, they are context failures."

**Recommendation**: Start your agent design with context flows, not agent logic. Map what information each agent needs and where that information comes from.

**Agent Skills**: Identified as "an extremely lightweight but potentially effective way to close the gap between fixed LLM knowledge and fast-evolving SDKs."

### OpenAI (Agents SDK / Cookbook)

**State-Based Memory**: Advocated over retrieval-based for complex domains. Encodes knowledge as structured fields with clear precedence (global vs session).

**Memory Lifecycle**: Inject curated state > reason with full context > distill high-signal memories > consolidate safely.

**Forgetting**: "Forgetting is not a bug -- it is essential" to prevent context poisoning from accumulated noise.

### LangChain (Harrison Chase)

**Core Claim**: Context engineering is "the most important skill an AI engineer can develop."

**Practical Advice**: Agent failures typically stem from inadequate context rather than model limitations.

### Manus (Production Agent)

**Philosophy**: In-context learning over model fine-tuning. Ship improvements in hours rather than weeks.

**Biggest Lesson**: KV-cache optimization is the most impactful metric for production agents.

**Pattern**: "Stochastic Graduate Descent" -- informal architecture search, prompt experimentation, and empirical validation through four complete framework rebuilds.

### Martin Fowler / Thoughtworks

**Critical Caveat**: Despite engineering terminology, outcomes remain probabilistic. Context engineering increases success probability but cannot guarantee behavior. "No unit tests for context engineering" exists.

**On Sharing Context Configs**: Organizational sharing works better than public distribution because context alignment between sender and receiver varies significantly.

### Redis (Ankur Goyal, Braintrust)
> "Good context engineering caches well. Bad context engineering is both slow and expensive."

### Salvatore Sanfilippo (Redis Creator)
> "When your goal is to reason with an LLM about implementing or fixing some code, you need to provide extensive information to the LLM: papers, big parts of the target code base (all the code base if possible), and a brain dump of all your understanding of what should be done."

---

## 9. Real-World Implementation Case Studies

### Claude Code (Anthropic)
- Gathers context from files, structure, history, terminal, comments
- Hierarchical compression with function-based tagging
- CLAUDE.md files load at session start; tools like glob/grep enable just-in-time retrieval
- Auto-compact triggers at 95% context window capacity
- Result: Usable across thousands-of-file projects without performance degradation

### Manus
- In-context learning over fine-tuning for rapid iteration
- KV-cache optimization as primary metric (100:1 input-to-output ratio)
- File system as extended memory (todo.md pattern)
- Token logit masking for tool selection
- Four complete framework rebuilds to iterate on context architecture

### Tongyi DeepResearch
- IterResearch paradigm: Reconstruct streamlined workspace with only essential previous outputs
- Parallel research agents with isolated contexts
- Synthesis agent integrates findings
- Result: Performance parity with OpenAI's proprietary system

### Anthropic's Multi-Agent Researcher
- Specialized sub-agents for literature review, synthesis, verification
- Each subagent has context optimized for narrow task
- Outperformed single-agent implementations
- Tradeoff: 15x higher token usage

---

## 10. Repository-Level Context Files

### The Ecosystem of AI Configuration Files

These files solve a fundamental problem: AI models have no persistent memory and every session starts blank.

#### CLAUDE.md (Claude Code)
- Read automatically at the start of every Claude Code session
- Should contain universally applicable instructions (keep lean, under 500 lines)
- Covers: WHAT (tech stack, project structure), WHY (purpose), HOW (workflows, conventions)
- Best practice: "As few instructions as possible -- only universally applicable ones"

#### AGENTS.md (Cross-Tool Standard)
- Emerging universal standard for agent-specific instructions
- Works with Claude Code, Cursor, GitHub Copilot, and others
- Used by over 60,000 repositories
- Stewarded by the Linux Foundation's Agentic AI Foundation

#### .cursorrules / .cursor/rules/ (Cursor)
- Legacy: Single `.cursorrules` file (deprecated)
- Current: `.cursor/rules/` directory with multiple `.mdc` files, each scoped

#### Recommended Pattern
Shared rules in AGENTS.md, tool-specific additions in CLAUDE.md. This maintains one source of truth while supporting tool-specific needs.

### What These Files Should Contain
- Technology stack and framework versions
- Architectural patterns and design principles
- Code organization and naming conventions
- Testing requirements and patterns
- Development workflow and deployment processes
- Style conventions and documentation standards
- Example code that encodes project DNA

### Impact
Developers report **60-80% reduction in manual code refactoring** when AI understands project architecture upfront. AI assistants perform exponentially better when they can pattern-match against existing codebase.

---

## 11. Key Frameworks and Mental Models

### Framework 1: The Three-Pillar Context Framework (LangChain/Osmani)
1. **Instructional Context** -- System prompts, role definitions, few-shot examples
2. **Knowledge Context** -- Domain information and facts, often via retrieval
3. **Tools Context** -- Information from environmental actions (API results, database queries, code execution)

### Framework 2: The Four Operations (Write/Select/Compress/Isolate)
1. **Write** -- Persist information (scratchpads, memories, files)
2. **Select** -- Retrieve relevant information (RAG, tool selection, memory)
3. **Compress** -- Reduce tokens while retaining meaning (summarization, pruning)
4. **Isolate** -- Partition context across agents/components

### Framework 3: Seven Context Components (Philipp Schmid)
1. Instructions/System Prompt
2. User Prompt
3. State/History (Short-term Memory)
4. Long-Term Memory
5. Retrieved Information (RAG)
6. Available Tools
7. Structured Output

### Framework 4: Karpathy's Context Filling
Context = Task descriptions + Explanations + Few-shot examples + RAG + Multimodal data + Tools + State + History, all compacted into a limited window.

### Framework 5: Compiled View Model (Google ADK)
- **Sources**: Sessions, memory, artifacts
- **Compiler Pipeline**: Flows and processors
- **Output**: Working context (compiled view for one LLM invocation)
- Architecture divides context into **stable prefixes** and **variable suffixes**

### Framework 6: Context Window Zones (Google ADK)
- **Stable prefixes**: System instructions, agent identity, long-lived summaries
- **Variable suffixes**: Latest user turn, new tool outputs, incremental updates

### Framework 7: The Pyramid Approach (Redis)
General background -> Specific details -> Task instructions (inverted pyramid for context assembly)

### Framework 8: Memory Lifecycle (OpenAI)
Inject > Reason > Distill > Consolidate

### Mental Model: The Sweet Spot
> "Too little or of the wrong form and the LLM doesn't have the right context for optimal performance. Too much or too irrelevant, and the LLM costs might go up and performance might come down." -- Andrej Karpathy

---

## 12. Implications for nv:context

### Core Takeaways for Building the Skill

1. **Context engineering is NOT just about prompts** -- It is the discipline of designing the entire information environment for an LLM. nv:context should generate comprehensive context across ALL components (system prompts, tool descriptions, memory structures, retrieval strategies, state management).

2. **Dynamic over static** -- Context must be assembled per-request and per-task, not from fixed templates. nv:context should produce context that adapts to the specific coding task, project phase, and agent capabilities.

3. **Quality over quantity** -- A focused 300-token context often outperforms an unfocused 113K-token context. nv:context must prioritize signal-to-noise ratio, not exhaustive documentation dumps.

4. **The four operations are universal** -- Write, Select, Compress, Isolate form the backbone of all context engineering. nv:context should address all four.

5. **Repository-level context files are established practice** -- CLAUDE.md, AGENTS.md, and .cursorrules are already widely adopted. nv:context should generate and optimize these files as a primary output.

6. **KV-cache awareness matters in production** -- Stable prefixes, append-only context, and deterministic serialization have massive cost implications. nv:context should generate context structures that cache efficiently.

7. **Memory architecture is critical** -- Episodic, semantic, and procedural memory types serve different purposes. nv:context should help structure all three types.

8. **Tool descriptions need optimization** -- Dynamic tool selection via RAG improves accuracy 3x over dumping all tools. nv:context should generate optimized tool descriptions.

9. **Context rot is real** -- Long-running agents suffer from context degradation. nv:context should include strategies for compression, summarization, and memory consolidation.

10. **Multi-agent context isolation** -- Sub-agents work best with focused, isolated contexts. nv:context should support generating context packages for specialized sub-agents.

### The Competitive Landscape

Context engineering is recognized by all major players (Anthropic, Google, OpenAI, LangChain, Redis, JetBrains) as the critical skill for AI agent success. No dominant tool or framework has emerged as the standard for automated context generation. This represents the opportunity for nv:context.

### The Gap to Fill

Current tools help with individual components (RAG frameworks, memory stores, prompt libraries) but no tool provides end-to-end automated context engineering that:
- Analyzes a codebase and generates optimal context structures
- Produces multi-format output (CLAUDE.md, AGENTS.md, system prompts, tool descriptions)
- Applies compression and prioritization automatically
- Adapts to different agent architectures and coding tools
- Incorporates all seven context components systematically

---

## 13. Sources

### Primary Sources (Fetched and Deeply Analyzed)

- [Effective context engineering for AI agents -- Anthropic Engineering Blog](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [The New Skill in AI is Not Prompting, It's Context Engineering -- Philipp Schmid](https://www.philschmid.de/context-engineering)
- [The Rise of Context Engineering -- LangChain Blog](https://blog.langchain.com/the-rise-of-context-engineering/)
- [What is Context Engineering, Anyway? -- Zep Blog](https://blog.getzep.com/what-is-context-engineering/)
- [Context Engineering: Bringing Engineering Discipline to Prompts -- Addy Osmani](https://addyo.substack.com/p/context-engineering-bringing-engineering)
- [Context Engineering: The Definitive 2025 Guide -- FlowHunt](https://www.flowhunt.io/blog/context-engineering/)
- [Context Engineering -- Simon Willison](https://simonwillison.net/2025/jun/27/context-engineering/)
- [Context Engineering: Best Practices -- Redis Blog](https://redis.io/blog/context-engineering-best-practices-for-an-emerging-discipline/)
- [Context Engineering for AI Agents: Lessons from Building Manus](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus)
- [Cutting Through the Noise: Smarter Context Management -- JetBrains Research](https://blog.jetbrains.com/research/2025/12/efficient-context-management/)
- [Context Engineering for Personalization -- OpenAI Developers Cookbook](https://developers.openai.com/cookbook/examples/agents_sdk/context_personalization)
- [Context Engineering Guide -- Prompting Guide](https://www.promptingguide.ai/guides/context-engineering-guide)
- [What is context engineering? Components, techniques, and best practices -- Elastic](https://www.elastic.co/search-labs/blog/context-engineering-overview)
- [Context Engineering for Coding Agents -- Martin Fowler](https://martinfowler.com/articles/exploring-gen-ai/context-engineering-coding-agents.html)
- [Context Engineering: LLM Memory and Retrieval for AI Agents -- Weaviate](https://weaviate.io/blog/context-engineering)

### Academic Papers

- [A Survey of Context Engineering for Large Language Models (arxiv: 2507.13334)](https://arxiv.org/abs/2507.13334)
- [Agentic Context Engineering: Evolving Contexts for Self-Improving Language Models (arxiv: 2510.04618)](https://arxiv.org/abs/2510.04618)
- [The Complexity Trap -- JetBrains Research / NeurIPS 2025](https://github.com/JetBrains-Research/the-complexity-trap)
- [LLMLingua: Prompt Compression (Microsoft, EMNLP 2023 / ACL 2024)](https://github.com/microsoft/LLMLingua)
- [Prompt Compression for Large Language Models: A Survey (NAACL 2025)](https://aclanthology.org/2025.naacl-long.368.pdf)

### Origin / Key Tweets

- [Tobi Lutke -- Original Tweet (June 19, 2025)](https://x.com/tobi/status/1935533422589399127)
- [Andrej Karpathy -- Endorsement Tweet](https://x.com/karpathy/status/1937902205765607626)

### Additional Sources

- [Context Engineering vs Prompt Engineering -- Firecrawl](https://www.firecrawl.dev/blog/context-engineering)
- [Context Engineering vs Prompt Engineering -- Neo4j](https://neo4j.com/blog/agentic-ai/context-engineering-vs-prompt-engineering/)
- [Context Engineering vs Prompt Engineering -- Gartner](https://www.gartner.com/en/articles/context-engineering)
- [CLAUDE.md, AGENTS.md, and Every AI Config File Explained -- DeployHQ](https://www.deployhq.com/blog/ai-coding-config-files-guide)
- [Writing a good CLAUDE.md -- HumanLayer Blog](https://www.humanlayer.dev/blog/writing-a-good-claude-md)
- [AI Context Management Across Claude, Cursor, Kiro, Gemini -- DEV Community](https://dev.to/madeburo/ai-context-management-across-claude-cursor-kiro-gemini-and-custom-agents-2n1f)
- [Architecting Efficient Context-Aware Multi-Agent Framework -- Google Developers Blog](https://developers.googleblog.com/architecting-efficient-context-aware-multi-agent-framework-for-production/)
- [Context Engineering in Multi-Agent Systems -- Agno](https://www.agno.com/blog/context-engineering-in-multi-agent-systems)
- [RAG Isn't Dead, But Context Engineering Is the New Hotness -- The New Stack](https://thenewstack.io/rag-isnt-dead-but-context-engineering-is-the-new-hotness/)
- [Context Engineering: Going Beyond Prompt Engineering and RAG -- The New Stack](https://thenewstack.io/context-engineering-going-beyond-prompt-engineering-and-rag/)
