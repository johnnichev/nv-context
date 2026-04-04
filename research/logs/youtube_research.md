# Context Engineering - Video & Audio Content Research

**Research Date:** 2026-04-04
**Topic:** Context engineering for AI agents and LLMs - YouTube videos, conference talks, podcasts, and tutorials

---

## Table of Contents

1. [Key YouTube Videos](#key-youtube-videos)
2. [Conference Talks & Presentations](#conference-talks--presentations)
3. [Podcast Episodes](#podcast-episodes)
4. [Online Courses & Workshops](#online-courses--workshops)
5. [Key Figures & Channels](#key-figures--channels)
6. [Origin & Evolution of the Term](#origin--evolution-of-the-term)
7. [Key Themes & Insights](#key-themes--insights)

---

## Key YouTube Videos

### 1. "Advanced Context Engineering for Agents" - Y Combinator / Root Access

- **URL:** https://www.youtube.com/watch?v=IS_y40zY-hc
- **Channel:** YC Root Access (Y Combinator)
- **Date Published:** August 25, 2025
- **Speaker:** Dexter Horthy, Founder of HumanLayer
- **Key Topics:**
  - Why back-and-forth prompting fails for complex software projects
  - Spec-first development methodology for team alignment
  - Intentional context management strategies (compaction, subagents, planning workflows)
  - Research -> Plan -> Implement three-phase methodology
  - "Everything is context engineering" thesis
- **Key Takeaways:**
  - Frequent intentional compaction is critical for large codebases
  - Claude Code used to handle 300k LOC Rust codebases, shipping a week's worth of work in a day
  - Building production-level systems requires moving from "vibe coding" to structured, spec-first approaches
- **Companion Repo:** https://github.com/humanlayer/advanced-context-engineering-for-coding-agents

### 2. "Context Engineering for Engineers" - Y Combinator / Root Access

- **URL:** Available on YC Root Access YouTube channel (Class Central listing: https://www.classcentral.com/course/youtube-context-engineering-for-engineers-479243)
- **Channel:** YC Root Access (Y Combinator)
- **Duration:** ~11 minutes
- **Speaker:** Jeff Huber, Founder of Chroma
- **Key Topics:**
  - Engineering context for LLMs beyond basic prompts and RAG
  - Context window management for AI system reliability and performance
  - "Needle in a haystack" problem in information retrieval
  - "Gather and Glean" methodology for data collection and filtering
  - Compaction strategies for faster, more reliable AI systems
- **Key Takeaways:**
  - AI performance degrades as context length increases
  - Strategic content selection directly impacts output quality
  - Compaction reduces context size while preserving essential information

### 3. "Context Engineering Clearly Explained" - Tina Huang

- **URL:** https://www.youtube.com/watch?v=jLuwLJBQkIs
- **Channel:** Tina Huang (former Meta data scientist)
- **Date Published:** 2025
- **Key Topics:**
  - Fundamentals of context engineering vs. traditional prompt engineering
  - Demo: creating context-engineered prompts for AI agents
  - Writing context, selecting context, compressing context, isolating context
  - Interactive quizzes and real-world examples
- **Key Takeaways:**
  - Context engineering involves strategically providing relevant information, examples, and background knowledge to AI systems
  - Mastering four strategies: write, select, compress, isolate
  - Practical demonstrations of building more effective AI agents

### 4. "Context Engineering Explained - 5 Practical Tips" - Shaw Talebi

- **URL:** Available on Shaw Talebi's YouTube channel (Class Central listing: https://www.classcentral.com/course/youtube-context-engineering-explained-5-practical-tips-476092)
- **Channel:** Shaw Talebi
- **Duration:** ~16 minutes
- **Key Topics:**
  - Five practical tips to optimize LLM inputs for better outputs
  - Clear and specific instructions for LLMs
  - Structured text formats for improved model comprehension
  - Systematic experiments for refining context
  - Meta-prompting techniques (using LLMs to improve their own prompts)
- **Key Takeaways:**
  - Keep context clean and organized to prevent confusion
  - Use structured formats to improve response quality
  - Leverage meta-prompting to iteratively improve context

### 5. "Context Engineering vs Prompt Engineering" - Lena Hall

- **URL:** https://youtu.be/4q_oWQDOd9Q
- **Channel:** Lena Hall (Microsoft)
- **Key Topics:**
  - Direct comparison of prompt engineering vs. context engineering
  - Why prompt engineering is a subset of context engineering
  - Context engineering 101 cheat sheet
- **Key Takeaways:**
  - Prompt engineering = what to say to the model at a moment
  - Context engineering = what the model knows when you say it, and why it should care
  - Context engineering is the broader discipline; prompt engineering is one component
- **Companion Resource:** 12-Factor Agents manifesto

### 6. "Context Engineering with DSPy - Comprehensive Hands-On Course" - Neural Breakdown with AVB

- **URL:** https://youtu.be/5Bym0ffALaU
- **Channel:** Neural Breakdown with AVB (https://www.youtube.com/@avb_fj)
- **Duration:** ~1 hour 20 minutes
- **Key Topics (5 chapters):**
  - Prompt engineering fundamentals
  - Multi-agent prompt programs
  - Comprehensive evaluation systems
  - Tool calling mechanisms
  - Advanced RAG implementations
- **Key Takeaways:**
  - Building powerful LLM apps by structuring context to optimize performance
  - Progresses from atomic prompts to complex multi-agent systems
  - Monitoring DSPy programs with MLFlow
- **Companion Repo:** https://github.com/avbiswas/context-engineering-dspy

### 7. "Context Engineering 101: The Simple Strategy to 100x AI Coding" - Cole Medin

- **URL:** Available on Cole Medin's channel (https://www.youtube.com/@ColeMedin)
- **Channel:** Cole Medin (~175,000 subscribers)
- **Date Published:** ~July 2025
- **Key Topics:**
  - PRP (Product Requirements Prompts) framework
  - Using Claude Code for context engineering
  - Writing, selecting, compressing, and isolating context
  - Using errors to your advantage
  - Building self-evolving AI coding assistants
- **Key Takeaways:**
  - "Context engineering is the new vibe coding"
  - Claude Code is optimal for this approach but strategy applies to any AI assistant
  - PRPs provide structured requirements that scale AI coding
- **Companion Repo:** https://github.com/coleam00/context-engineering-intro

### 8. "Context Engineering: The End of Vibe Coding! 100x Better Than Vibe Coding (Full Tutorial)"

- **URL:** https://www.youtube.com/watch?v=uohI3h4kqyg
- **Key Topics:**
  - Why the honeymoon phase for vibe coding is over
  - Context engineering templates and structured information
  - Real-world application demonstrations
- **Key Takeaways:**
  - Vibe coding completely falls apart when building anything real or at scale
  - Context engineering = meticulously providing AI models with all necessary context (instructions, rules, documentation, examples, tools)

### 9. "Context Engineering is the New Vibe Coding (Learn this Now)"

- **URL:** https://www.youtube.com/watch?v=Egeuql3Lrzg
- **Key Topics:**
  - Concepts attributed to Andrej Karpathy and Tobi Lutke
  - Transition from vibe coding to context engineering
  - Implementation of context engineering templates
- **Key Takeaways:**
  - Practical walkthrough of implementing context engineering in AI coding workflows

### 10. "12-Factor Agents: Patterns of Reliable LLM Applications" - Dex Horthy

- **URL:** Available on AI Engineer YouTube channel (https://www.youtube.com/@aidotengineer)
- **Channel:** AI Engineer / Also presented at MLOps Community
- **Speaker:** Dexter Horthy, HumanLayer
- **Key Topics:**
  - 12 engineering principles for reliable LLM applications
  - "LLMs are stateless functions"
  - "Everything is context engineering"
  - "Own your state and control flow"
- **Key Takeaways:**
  - A reliable "agent" is well-engineered software that uses LLM only where probabilistic reasoning truly helps
  - Core engineering techniques make LLM software more reliable, scalable, and maintainable
  - Manifesto available at https://www.humanlayer.dev/12-factor-agents

### 11. "Context Engineering - Making Every Token Count" - Addy Osmani

- **URL:** Available on O'Reilly / AI CodeCon (Speaker Deck: https://speakerdeck.com/addyosmani/context-engineering-making-every-token-count)
- **Speaker:** Addy Osmani (Google)
- **Duration:** ~14 minutes
- **Key Topics:**
  - What tokens and context windows are and why they matter
  - Why prompt engineering fails without strong context management
  - Practical strategies to avoid vague or hallucinated responses
  - Patterns: Write, Select, Compress, Isolate
  - How tools like Cursor and Cline optimize context automatically
- **Key Takeaways:**
  - Context engineering is the art of filling AI's limited memory with the right mix of instructions, data, and history
  - Modern AI tools are beginning to automate context optimization

### 12. "Context Engineering - Practical Techniques for Improving Agent Quality Today" - Vaibhav Gupta

- **URL:** Available on MLOps World YouTube channel (Class Central listing: https://www.classcentral.com/course/youtube-context-engineering-practical-techniques-for-improving-agent-quality-today-vaibhav-gupta-boundary-495037)
- **Channel:** MLOps World: Machine Learning in Production
- **Speaker:** Vaibhav Gupta, Founder & CEO of Boundary (Y Combinator)
- **Event:** MLOps World GenAI Summit 2025
- **Key Topics:**
  - How few-shot prompting, reasoning, tool calling, and structured outputs all serve context engineering
  - The unifying discipline of context engineering
  - Surrounding tooling (not just model size) determines quality outcomes
- **Key Takeaways:**
  - Buzzwords like few-shot prompting, reasoning, and tool calling all serve the same fundamental purpose: getting LLMs to perform as intended
  - Context engineering is the unifying discipline

### 13. "Building Agents with Model Context Protocol - Full Workshop" - Mahesh Murag (Anthropic)

- **URL:** Available on AI Engineer YouTube channel (Class Central listing: https://www.classcentral.com/course/youtube-building-agents-with-model-context-protocol-full-workshop-with-mahesh-murag-of-anthropic-457629)
- **Channel:** AI Engineer
- **Speaker:** Mahesh Murag, Anthropic Applied AI Team
- **Duration:** ~1 hour 15 minutes
- **Sections:**
  - What is MCP? (0:00-9:39)
  - Building with MCP (9:39-26:25)
  - MCP & Agents (26:25-1:13:15)
  - What's next for MCP? (1:13:15+)
- **Key Takeaways:**
  - MCP is a universal, open standard connecting AI systems with data sources
  - Eliminates need for fragmented integrations
  - Enables more capable and context-aware AI systems

### 14. Cole Medin - "Claude Code Full Guide" / "Advanced Claude Code Techniques"

- **Channel:** Cole Medin (https://www.youtube.com/@ColeMedin)
- **Also Presented At:** GitNation (https://gitnation.com/contents/advanced-claude-code-techniques-agentic-engineering-with-context-driven-development-3256)
- **Key Topics:**
  - Complete Claude Code features walkthrough
  - Global rules, slash commands, MCP servers
  - Advanced context engineering, subagents, hooks
  - "Yolo mode" and parallel agent workflows
  - CLAUDE.md best practices
- **Key Takeaways:**
  - Strategies used by top engineers to code reliably and fast with AI coding assistants
  - Proper context engineering unlocks agentic engineering

### 15. SwirlAI - Context Engineering Workshop / YouTube Launch

- **Channel:** SwirlAI (Aurimas Griciūnas)
- **Date:** March 2026
- **Duration:** ~45 minutes (workshop)
- **Key Topics:**
  - Context engineering hands-on deep dives for different levels of agentic system complexity
  - Pre-course content for End-to-End AI Engineering Bootcamp
- **Key Takeaways:**
  - Most agent failures come from poor context engineering, not weak model capability
  - Companion to Maven bootcamp course

---

## Conference Talks & Presentations

### 1. QCon London 2026 - "Context Engineering: Building the Knowledge Engine AI Agents Need"

- **URL:** https://qconlondon.com/presentation/mar2026/context-engineering-building-knowledge-engine-ai-agents-need
- **Date:** March 16-18, 2026
- **Speaker:** Brandon Waselnuk, Developer Relations at Unblocked
- **Key Topics:**
  - Building a context engine (reasoning layer) that synthesizes organizational knowledge
  - Queryable understanding across disparate sources
  - Decision-grade context for developers and AI tools

### 2. AI Engineer World's Fair 2025 - Context Engineering Talks

- **URL:** Available on AI Engineer YouTube channel (https://www.youtube.com/@aidotengineer)
- **Date:** June 3-5, 2025, San Francisco
- **Speakers:** Dex Horthy (HumanLayer), Lena Hall (Microsoft), and others
- **Key Topics:**
  - "Everything that makes agents good is context engineering"
  - Agent reliability track
  - 12-Factor Agents patterns
- **Note:** All talks recorded and available on AI Engineer YouTube channel

### 3. O'Reilly AI CodeCon - "Context Engineering" - Addy Osmani

- **URL:** https://www.oreilly.com/videos/ai-codecon-coding/0642572020779/
- **Speaker:** Addy Osmani (Google)
- **Key Topics:** Making every token count, Write/Select/Compress/Isolate patterns

### 4. MLOps World GenAI Summit 2025 - Context Engineering Talk

- **Speaker:** Vaibhav Gupta (Boundary/BAML)
- **Key Topics:** Practical techniques for improving agent quality, unifying discipline of context engineering

### 5. Optimized AI Conference 2026 (Atlanta, March 30-31) - Context Engineering Workshop

- **URL:** https://www.oaiconference.com/context-engineering
- **Format:** 1-hour workshop
- **Topic:** "Context Engineering with Redis and LangChain"
- **Key Topics:**
  - Semantic caching, vector search, intelligent context management
  - How Redis and LangChain enable high-performance agent systems
  - Structuring memory, retrieval, and reasoning workflows

---

## Podcast Episodes

### 1. Latent Space - "Context Engineering for Agents" - Lance Martin (LangChain)

- **URL:** https://www.latent.space/podcast (also on Apple Podcasts, Spotify)
- **Host:** Alessio & Swyx
- **Guest:** Lance Martin, LangChain
- **Key Topics:**
  - Managing context flow from tool calls in agents
  - Offloading heavy tool-call outputs to external storage
  - Storing raw results on disk, sending compact summaries to the model
- **Key Insight:** Context engineering arose because agents receive context from many tool calls, not just user prompts

### 2. Latent Space - "RAG is Dead, Context Engineering is King" - Jeff Huber (Chroma)

- **URL:** https://www.latent.space/p/chroma
- **Host:** Swyx & Alessio
- **Guest:** Jeff Huber, Co-founder of Chroma
- **Key Topics:**
  - Why "RAG" as a term is dead
  - Context engineering as the better descriptor for the job to be done
  - "Context rot" - degradation of LLM performance as context windows grow unwieldy
- **Key Insight:** As context lengths increase and AI shifts from chatbots to agents, context engineering becomes the focus

### 3. Sequoia Capital "Training Data" - "Context Engineering Our Way to Long-Horizon Agents" - Harrison Chase (LangChain)

- **URL:** https://sequoiacap.com/podcast/context-engineering-our-way-to-long-horizon-agents-langchains-harrison-chase/
- **Also on:** Spotify (https://open.spotify.com/episode/7LMWpt2g7huKdzzX7wldgC), Apple Podcasts
- **Guest:** Harrison Chase, Co-founder & CEO of LangChain
- **Key Topics:**
  - Evolution from early scaffolding to harness-based architectures
  - Long-horizon agents that work autonomously for extended periods
  - Why context engineering (not just better models) is fundamental to agent development
- **Key Insight:** The hard part of building reliable agentic systems is making sure the LLM has appropriate context at each step

### 4. The AI Daily Brief - "Context Engineering: What It Is and Why It Matters"

- **URL:** https://podcasts.apple.com/us/podcast/context-engineering-what-it-is-and-why-it-matters/id1680633614?i=1000714596454
- **Key Topics:**
  - What context engineering is as a core skill for anyone working with LLMs
  - Difference from prompt engineering
  - Providing the right background, files, and environment for task solving

### 5. Thoughtworks Technology Podcast - "What We're Talking About When We Talk About Context Engineering"

- **URL:** https://www.thoughtworks.com/insights/podcasts/technology-podcasts/talking-context-engineering
- **Date:** October 2, 2025
- **Host:** Rachel Laycock (Thoughtworks CTO)
- **Guests:** Alessio Ferri, Bharani Subramaniam
- **Key Topics:**
  - What context engineering is and how it's being done
  - Evolution of AI and what context engineering tells us about it

### 6. Thoughtworks Technology Podcast - "Context Engineering: Tackling Legacy Systems with Generative AI"

- **URL:** https://www.thoughtworks.com/en-us/insights/podcasts/technology-podcasts/context-engineering-tackling-legacy-systems-generative-ai
- **Date:** August 21, 2025
- **Guests:** Birgitta Böckeler (lead for AI-enabled software engineering), Chandirasekar Thiagarajan
- **Key Topics:**
  - Using context engineering for legacy system modernization
  - Tools and processes for applying generative AI to legacy code

### 7. The Shift (Microsoft Foundry) - "Is Context Engineering the New RAG?"

- **URL:** https://rss.com/podcasts/leading-the-shift/2676392/
- **Date:** February 2026
- **Speakers:** Allison Sparrow, Pamela Fox, Matt Gotteiner (Microsoft Foundry)
- **Key Topics:**
  - Debate on whether context engineering has overtaken RAG
  - Practical implications for building AI applications

### 8. Box AI Explainer Series - Context Engineering Discussion

- **Speakers:** Meena Ganesh, Ben Kus (Box CTO)
- **Key Topics:** Context engineering as a pivotal advancement redefining how AI agents operate

### 9. Build Wiz AI Show - "Context Engineering with the PRP Framework"

- **URL:** https://creators.spotify.com/pod/profile/build-wiz-ai/episodes/Context-Engineering-with-the-PRP-Framework-e35moab
- **Key Topics:** Product Requirements Prompts framework for context engineering

### 10. n8n Masterclass - "Stop Vibe Coding: Context Engineering & RAG for AI Agents" with Cole Medin

- **URL:** https://zeno.fm/podcast/the-n8n-masterclass/episodes/stop-vibe-coding-context-engineering-rag-for-ai-agents-with-cole-medin/
- **Guest:** Cole Medin
- **Key Topics:** Moving from vibe coding to context engineering, RAG integration for AI agents

### 11. Evil Martians Podcast - Jeff Huber (Chroma) on Context Engineering and Modern AI Search

- **URL:** https://evilmartians.com/events/podcast-jeff-huber-chroma
- **Guest:** Jeff Huber, co-founder of Chroma
- **Key Topics:** Context engineering and modern AI search

---

## Online Courses & Workshops

### 1. Maven - "Advanced Context Engineering" - Dex Horthy

- **URL:** https://maven.com/p/6cbf01/advanced-context-engineering
- **Instructor:** Dex Horthy (HumanLayer)
- **Format:** Structured course

### 2. Maven - "Context Engineering: How to Get LLMs to Solve Your Problems"

- **URL:** https://maven.com/p/05aecf/context-engineering-how-to-get-ll-ms-to-solve-your-problems
- **Format:** Structured course with practical exercises

### 3. Maven - "End-to-End AI Engineering Bootcamp" (includes Context Engineering)

- **URL:** https://maven.com/swirl-ai/end-to-end-ai-engineering
- **Instructor:** Aurimas Griciūnas (SwirlAI)
- **Duration:** 8 weeks
- **Format:** Sprint-based with live sessions

### 4. Pluralsight - "Introduction to Context Engineering"

- **URL:** https://www.pluralsight.com/courses/context-engineering-introduction
- **Format:** Online course

### 5. DataCamp - Context Engineering Guide

- **URL:** https://www.datacamp.com/blog/context-engineering
- **Format:** Blog + video lesson format

### 6. LinkedIn Learning - "Context Engineering for Developers"

- **URL:** https://www.linkedin.com/learning/context-engineering-for-developers/apply-context-engineering
- **Format:** Video course

### 7. O'Reilly - "Context Engineering with DSPy" (Book)

- **URL:** https://www.oreilly.com/library/view/context-engineering-with/0642572261603/
- **Format:** Book (companion to the YouTube course by Neural Breakdown with AVB)

---

## Key Figures & Channels

### YouTube Channels to Follow for Context Engineering Content

| Channel | Focus | URL |
|---------|-------|-----|
| **AI Engineer** | Conference talks, context engineering track | https://www.youtube.com/@aidotengineer |
| **Cole Medin** | Context engineering tutorials, Claude Code | https://www.youtube.com/@ColeMedin |
| **Tina Huang** | Context engineering explainers | https://www.youtube.com/@TinaHuang1 |
| **Neural Breakdown with AVB** | DSPy-based context engineering courses | https://www.youtube.com/@avb_fj |
| **YC Root Access** | Engineering talks including context engineering | Y Combinator channel |
| **MLOps Community** | Production AI, context engineering talks | MLOps Community channel |
| **Shaw Talebi** | Data science, context engineering tips | Shaw Talebi channel |
| **SwirlAI** | AI engineering bootcamp, context engineering | SwirlAI channel (new in 2026) |

### Key People in Context Engineering

| Person | Role | Contribution |
|--------|------|--------------|
| **Andrej Karpathy** | Ex-OpenAI, Tesla AI | Popularized the term; "context engineering is the delicate art and science of filling the context window with just the right information for the next step" |
| **Tobi Lutke** | CEO, Shopify | Early advocate; "the art of providing all the context for the task to be plausibly solvable by the LLM" |
| **Dexter Horthy** | Founder, HumanLayer | Coined "context engineering" term in AI engineering context; created 12-Factor Agents; Advanced Context Engineering talks |
| **Harrison Chase** | Co-founder & CEO, LangChain | Context engineering for long-horizon agents; harness engineering concept |
| **Jeff Huber** | Co-founder, Chroma | "RAG is Dead, Context Engineering is King"; Gather and Glean methodology |
| **Lance Martin** | LangChain | Context engineering for agents; managing context flow from tool calls |
| **Philipp Schmid** | Hugging Face | "The New Skill in AI is Not Prompting, It's Context Engineering" |
| **Addy Osmani** | Google | "Context Engineering - Making Every Token Count" |
| **Lena Hall** | Microsoft | Context Engineering vs Prompt Engineering video and cheat sheet |
| **Cole Medin** | Dynamous AI / YouTube | Context engineering tutorials, PRP framework, Claude Code guides |
| **Vaibhav Gupta** | Boundary (BAML) | Context engineering as unifying discipline for AI techniques |
| **Aurimas Griciūnas** | SwirlAI | "State of Context Engineering in 2026"; bootcamp educator |

---

## Origin & Evolution of the Term

### Timeline

- **Mid-2025 (June):** Tobi Lutke (Shopify CEO) tweets preference for "context engineering" over "prompt engineering"
- **June 2025:** Andrej Karpathy endorses the term on X, providing the canonical definition
- **June 2025:** AI Engineer World's Fair features Dex Horthy's talk on context engineering
- **July 2025:** Philipp Schmid publishes "The New Skill in AI is Not Prompting, It's Context Engineering"
- **August 2025:** Y Combinator Root Access publishes context engineering video series
- **August-September 2025:** LangChain, Anthropic, and others publish comprehensive guides
- **October 2025:** Thoughtworks and Anthropic publish definitive pieces
- **November 2025:** Spotify publishes their context engineering blog series (Honk agent)
- **Late 2025 - Early 2026:** Term achieves mainstream adoption; courses, workshops proliferate
- **2026:** Context engineering is established as foundational AI engineering discipline

### The Karpathy Definition (Canonical)

> "Context engineering is the delicate art and science of filling the context window with just the right information for the next step."

Mental model: Think of an LLM like a CPU, and its context window as RAM/working memory. Your job as an engineer is akin to an operating system: load that working memory with just the right code and data for the task.

What this involves:
- Task descriptions and explanations
- Few-shot examples
- RAG (retrieved information)
- Related (possibly multimodal) data
- Tools
- State and history
- Compacting

---

## Key Themes & Insights

### Core Definition

Context engineering is the discipline of designing and building dynamic systems that provide the right information and tools, in the right format, at the right time, to give an LLM everything it needs to accomplish a task.

### Prompt Engineering vs. Context Engineering

- **Prompt Engineering:** What to say to the model at a single moment (subset of context engineering)
- **Context Engineering:** Everything the model sees -- memory, history, tools, system prompts, retrieved data, and the orchestration of how all of it arrives

### The Four Strategies (Write, Select, Compress, Isolate)

1. **Write** - Save information outside the context window for later use
2. **Select** - Pull the right information at the right time
3. **Compress** - Reduce context size while preserving essential information (compaction)
4. **Isolate** - Structure information for effective task performance (subagents, separate workspaces)

### Why It Matters

- Most AI agent failures are **context failures**, not model failures
- Stay under ~40% context utilization for optimal performance
- KV-cache hit rate is the most important metric for production AI agents (per Manus)
- Teams shipping reliable AI code focus on context engineering, not clever prompts

### Key Production Insights (from Manus, Spotify, HumanLayer)

- **Manus:** Rebuilt their agent framework 4 times; biggest gains came from removing things, not adding complexity
- **Spotify (Honk):** 1,500+ merged PRs from background coding agents; limited tools/hooks to focus on generating the right code change
- **HumanLayer:** Research -> Plan -> Implement methodology; frequent intentional compaction

### Notable Written Resources (Complement to Videos)

- **Anthropic:** [Effective Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- **LangChain:** [Context Engineering for Agents](https://blog.langchain.com/context-engineering-for-agents/)
- **Manus:** [Context Engineering for AI Agents: Lessons from Building Manus](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus)
- **Martin Fowler / Thoughtworks:** [Context Engineering for Coding Agents](https://martinfowler.com/articles/exploring-gen-ai/context-engineering-coding-agents.html)
- **Spotify Engineering:** [Background Coding Agents: Context Engineering (Honk, Part 2)](https://engineering.atspotify.com/2025/11/context-engineering-background-coding-agents-part-2)
- **Philipp Schmid:** [The New Skill in AI is Not Prompting, It's Context Engineering](https://www.philschmid.de/context-engineering)
- **Promptingguide.ai:** [Context Engineering Guide](https://www.promptingguide.ai/guides/context-engineering-guide)
- **SwirlAI Newsletter:** [State of Context Engineering in 2026](https://www.newsletter.swirlai.com/p/state-of-context-engineering-in-2026)

### Repository Setup Resources (CLAUDE.md, .cursorrules, AGENTS.md)

- **Cole Medin's Template:** https://github.com/coleam00/context-engineering-intro
- **HumanLayer's ACE Guide:** https://github.com/humanlayer/advanced-context-engineering-for-coding-agents
- **David Kimai's Handbook:** https://github.com/davidkimai/Context-Engineering
- **Augment Code Guide:** [How to Build Your AGENTS.md](https://www.augmentcode.com/guides/how-to-build-agents-md)
- **Builder.io:** [How I use Claude Code (+ my best tips)](https://www.builder.io/blog/claude-code)

---

## Summary Statistics

- **Total YouTube Videos Catalogued:** 15
- **Podcast Episodes Catalogued:** 11
- **Conference Talks Catalogued:** 5
- **Online Courses/Workshops Catalogued:** 7
- **Key Figures Identified:** 12
- **GitHub Repos Referenced:** 5
- **Written Guides Referenced:** 8

---

*Last updated: 2026-04-04*
