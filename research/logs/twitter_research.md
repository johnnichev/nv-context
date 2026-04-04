# Context Engineering: X/Twitter Research Log

**Research Date:** 2026-04-04
**Scope:** X/Twitter posts, threads, and discussions about "context engineering" for AI agents and LLMs

---

## Table of Contents

1. [Origin Story & Key Catalysts](#1-origin-story--key-catalysts)
2. [Thought Leader Voices](#2-thought-leader-voices)
3. [Industry & Company Perspectives](#3-industry--company-perspectives)
4. [Practical Frameworks & Tips](#4-practical-frameworks--tips)
5. [Academic & Research Discussions](#5-academic--research-discussions)
6. [Evolution: From Context Engineering to Harness Engineering](#6-evolution-from-context-engineering-to-harness-engineering)
7. [Criticism & Counter-Perspectives](#7-criticism--counter-perspectives)
8. [CLAUDE.md & Cursor Rules as Context Engineering](#8-claudemd--cursor-rules-as-context-engineering)
9. [Key Resources Shared on Twitter](#9-key-resources-shared-on-twitter)
10. [Timeline of the Discourse](#10-timeline-of-the-discourse)

---

## 1. Origin Story & Key Catalysts

### Dex Horthy -- The Coiner of the Term
- **Author:** Dex Horthy (@dexhorthy), Founder/CEO of HumanLayer
- **Context:** Gave the original "context engineering" talk at AI Engineer conference (June 3, 2025). Swyx credits him as the coiner of the term.
- **URL:** https://x.com/dexhorthy/status/1998099409314468305
- **Key Quote:** "for posterity - June 03 - the OG context engineering talk from @aiDotEngineer"
- **Related URL:** https://x.com/dexhorthy/status/1913246092462104671
- **Key Insight:** "FOLKS - I've tried every agent framework out there and talked to many strong founders building impressive things with AI BUT I was surprised to find that most successful production AI systems actually use minimal frameworks"

### Swyx -- Amplifier and Ecosystem Builder
- **Author:** swyx (@swyx), Founder of SmolAI / AI Engineer
- **URL:** https://x.com/swyx/status/1940877277476409563
- **Key Quote:** "everything that makes agents good is context engineering -- excited to release @dexhorthy's talk at @aiDotEngineer, coiner of Context Engineering which has captured the zeitgeist of some of the most important problems in AI Engineering today!"
- **Significance:** Swyx's endorsement and platform (AI Engineer conference, Latent Space podcast) were instrumental in spreading the term. He reportedly removed the RAG track from AI Engineer World's Fair after Jeff Huber's arguments about context engineering.

### Tobi Lutke -- The Viral Catalyst
- **Author:** Tobi Lutke (@tobi), CEO of Shopify
- **Date:** June 19, 2025
- **URL:** https://x.com/tobi/status/1935533422589399127
- **Key Quote:** "I really like the term 'context engineering' over prompt engineering. It describes the core skill better: the art of providing all the context for the task to be plausibly solvable by the LLM."
- **Significance:** This tweet from a high-profile tech CEO was the single biggest catalyst for the term going mainstream. It was widely quoted and reshared across the AI community.

### Tobi Lutke -- Follow-up: DSPy Endorsement
- **Author:** Tobi Lutke (@tobi)
- **Date:** ~June 25, 2025
- **URL:** https://x.com/tobi/status/1937967281599898005
- **Key Quote:** "DSPy is my context engineering tool of choice"
- **Significance:** Connected context engineering to specific tooling (DSPy), giving practitioners a concrete starting point.

### Tobi Lutke -- Follow-up: GEPA and DSPy Underhyped
- **Author:** Tobi Lutke (@tobi)
- **URL:** https://x.com/tobi/status/1963434604741701909
- **Key Quote:** "Both DSPy and (especially) GEPA are currently severely under hyped in the AI context engineering world"
- **Significance:** Pushed the conversation toward automated prompt optimization as part of context engineering.

### Andrej Karpathy -- The Defining Endorsement
- **Author:** Andrej Karpathy (@karpathy), former OpenAI
- **Date:** ~June 25, 2025
- **URL:** https://x.com/karpathy/status/1937902205765607626
- **Key Quote:** "+1 for 'context engineering' over 'prompt engineering'. People associate prompts with short task descriptions you'd give an LLM in your day-to-day use. When in every industrial-strength LLM app, context engineering is the delicate art and science of filling the context window with just the right information for the next step."
- **Extended Content:** Listed what context engineering involves: "task descriptions and explanations, few-shot examples, RAG, related multimodal data, tools, state and history, and compacting"
- **Significance:** Karpathy's endorsement from a deeply technical perspective cemented the term's legitimacy. His definition became the most-quoted in the space.

---

## 2. Thought Leader Voices

### Harrison Chase (LangChain CEO)
- **URL:** https://x.com/hwchase17/status/1937194145074020798
- **Date:** ~June 23, 2025
- **Key Quote:** "The rise of context engineering. 'Context engineering' has been an increasingly popular term used to describe a lot of the system building that AI engineers do. But what is it exactly? The definition I like: 'Context engineering is building dynamic systems to provide the right information and tools in the right format such that the LLM can plausibly accomplish the task.'"
- **Key Insight:** Noted this is "not a new concept -- agent builders have been doing it for the past year or two" but the new term "will hopefully draw attention to the skills and tools needed to do this properly."

### Simon Willison
- **URL:** https://x.com/simonw/status/1938745355916714448
- **Date:** ~June 27, 2025
- **Blog Post:** https://simonwillison.net/2025/Jun/27/context-engineering/
- **Key Quote:** "I think context engineering is going to stick -- unlike 'prompt engineering' it has an inferred definition that's much closer to the intended meaning."
- **Key Insight:** The problem with "prompt engineering" is that most people's inferred definition reduces it to "typing things into a chatbot," missing the inherent complexity entirely.

### Aaron Levie (Box CEO) -- Enterprise Context Engineering
- **URL:** https://x.com/levie/status/1946693912984510767
- **Key Quote:** "Context engineering is increasingly the most critical component for building effective AI Agents in the enterprise right now. This will ultimately be the long pole in the tent for AI Agents adoption in most organizations."

- **URL:** https://x.com/levie/status/1962295909892653208
- **Key Quote:** "When doing product management for AI agents, the biggest shift is that the user you think about making successful is the agent. They are effectively your new 'customer'. And the whole game is to figure out how to get the agent the most relevant context possible to execute their task."

- **URL:** https://x.com/levie/status/2001888559725506915
- **Key Quote:** "We will soon get to a point... that almost any time something doesn't work with an AI agent in a reasonably sized task, you will be able to point to a lack of the right information that the agent had access to. This is why context engineering is [the future]."

- **URL:** https://x.com/levie/status/1992752275669049462
- **Key Quote:** "We're starting to get a clearer sign of how vast the surface area of context engineering is going to be. To build AI agents, in theory, it should be as simple as having a super powerful model, giving it a set of tools, having a really good system prompt, and giving it access to [data]..."
- **Significance:** Levie has been one of the most prolific voices connecting context engineering to enterprise AI adoption, posting about it repeatedly over months.

### Jeff Huber (Chroma CEO) -- "RAG is Dead"
- **URL:** https://x.com/jeffreyhuber/status/1957960686786736321
- **Date:** ~August 2025
- **Key Quote:** "RAG is Dead, Long Live Context Engineering"
- **Podcast:** Appeared on Latent Space podcast with the provocative title "RAG is Dead, Context Engineering is King"
- **Key Insight:** Context engineering is a far better term than prompt engineering or RAG. "Prompt engineering typically refers to fiddling with system instructions and RAG has lost all meaning entirely." The shift implies "the existence of a context engineer -- the actual job of most AI teams today."
- **Significance:** His arguments reportedly convinced swyx to remove the RAG track from AI Engineer World's Fair.

### Jerry Liu (LlamaIndex CEO)
- **URL:** https://x.com/jerryjliu0/status/1940852245450608646
- **Key Quote:** "Practical Techniques for Context Engineering" -- shared a comprehensive breakdown covering:
  1. Knowledge Base or tool selection
  2. Context Compression (retrieval, structured outputs, summarization)
  3. Long-term Memory (vector-based and fact retrieval)
  4. Workflow engineering (orchestrating sequences of calls)

### Philipp Schmid (Google DeepMind)
- **URL (Definition):** https://x.com/_philschmid/status/1939690423145861147
- **Key Quote:** "The hottest discussion in AI is about 'context engineering'. But what is it? Do we need it? Context engineering isn't about crafting better prompts. It's building dynamic systems that provides the right information at the right time."

- **URL (Formal Definition):** https://x.com/_philschmid/status/1940692654284505391
- **Key Quote:** "Context Engineering is the discipline of designing and building dynamic systems that provides the right information and tools, in the right format, at the right time, to give a LLM everything it needs to accomplish a task."
- **Blog Post:** https://www.philschmid.de/context-engineering

### Charles Packer (MemGPT Creator)
- **URL:** https://x.com/charlespacker/status/1997479237503332626
- **Key Quote:** "continual learning in token space = no catastrophic forgetting. The radically new idea to hill climb is agentic context engineering and it's been around since 2023 ever since we got self-directed context engineering via tool calling (eg MemGPT)"
- **Significance:** Claims the roots of context engineering go back to 2023 with MemGPT's self-directed context management via tool calling.

### Carlos E. Perez (@IntuitMachine)
- **URL:** https://x.com/IntuitMachine/status/1979266898257719564
- **Key Insight:** Summarized the paradox: "agents require extensive context to perform complex, multi-step tasks, [but] their performance degrades as the context grows."

---

## 3. Industry & Company Perspectives

### Anthropic -- Official Blog Announcement
- **URL:** https://x.com/AnthropicAI/status/1973098580060631341
- **Date:** September 29, 2025
- **Key Quote:** "New on the Anthropic Engineering Blog: Most developers have heard of prompt engineering. But to get the most out of AI agents, you need context engineering."
- **Blog URL:** https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
- **Significance:** Racked up nearly 500,000 views in weeks. Established context engineering as the key framing for Anthropic's agent-building philosophy. Introduced "context rot" as a key concept.

### Anthropic -- MCP and Context Engineering
- **URL:** https://x.com/AnthropicAI/status/1985846791842250860
- **Key Quote:** "New on the Anthropic Engineering blog: tips on how to build more efficient agents that handle more tools while using fewer tokens. Code execution with the Model Context Protocol (MCP)."

### Google -- Multi-Agent Systems Guide
- **URL (Rohan Paul sharing):** https://x.com/rohanpaul_ai/status/1997405403987222642
- **Key Quote:** "Google released a solid guide on context engineering for working with multi-agent systems. Shows how context engineering keeps multiagent systems fast, affordable, and less hallucination prone. The guide replaces giant prompts with a compiled view over state that splits information across Working Context, Session, Memory, and Artifacts."

### Google -- "Sessions & Memory" Whitepaper (70 pages)
- **URL (Data Science Dojo sharing):** https://x.com/DataScienceDojo/status/1989800577115525266
- **Key Quote:** "Google just released a defining whitepaper on the discipline that will shape the next decade of AI: Context Engineering. In 'Context Engineering: Sessions & Memory,' Google argues that the true intelligence of an agent doesn't come from the model -- it comes from how [developers assemble context]."
- **Whitepaper:** https://www.kaggle.com/whitepaper-context-engineering-sessions-and-memory
- **Core Concepts:** Session = short-term container for conversation turns, working notes, task state. Memory = long-term stable facts spanning sessions.

### LangChain -- Official Blog
- **URL (Harrison Chase):** https://x.com/hwchase17/status/1937194145074020798
- **Blog:** https://blog.langchain.com/the-rise-of-context-engineering/
- **LangChain Meetup Announcement:** https://x.com/LangChainAI/status/1945540110185107540

### Weaviate -- Complete Guide & E-book
- **URL:** https://x.com/weaviate_io/status/1985741429579170276
- **Key Quote:** "We just released our complete guide to Context Engineering. (These 6 components are the future of production AI apps)"
- **6 Components:** Agents, Query Augmentation, Retrieval, Prompting Techniques, Memory, Tools

- **URL (Victoria Slocum):** https://x.com/victorialslocum/status/1985743361576198462
- **Key Quote:** "Stop writing better prompts. Start engineering the system that feeds your LLM the right context at the right time."

### Y Combinator -- Endorsement of Dex Horthy
- **URL:** https://x.com/ycombinator/status/1960033085078356148
- **Key Quote:** "Dexter Horthy, founder of HumanLayer, on scaling coding agents: why back-and-forth prompting fails, how spec-first development keeps teams aligned, and why 'everything is context engineering.'"

---

## 4. Practical Frameworks & Tips

### Philipp Schmid -- 5 Practical Tips for Context Engineering
- **URL:** https://x.com/_philschmid/status/1982861526466707477
- **Date:** ~October 2025
- **Tips:**
  1. **Context Ordering Matters:** Use "append-only" context, adding new information to the end. Maximizes cache hits reducing cost (4x) and latency.
  2. **Manage Tools Statically:** Avoid changing tool order or availability mid-task. This can break context caching and confuse models.
  3. **Use External Memory:** Write context/goals to external storage to prevent information loss.
  4. **Recite Goals to Not Get Lost:** Have the model periodically restate objectives, keeping the primary goal in recent attention span.
  5. **Embrace Errors:** Keep error messages in the context.

### Lance Martin (LangChain) -- Context Engineering Meetup Recap
- **URL:** https://x.com/RLanceMartin/status/1948441848978309358
- **Date:** ~July 2025
- **Key Themes:**
  1. Context grows with agents -- typical task requires ~50 tool calls (citing Manus AI)
  2. **Offload:** Use the file system (e.g., write a todo.md at task start, re-write during execution)
  3. **Reduce:** Summarize/prune messages and tool observations
  4. **Retrieve:** Build on RAG for just-in-time context injection
  5. **Isolate:** Use multi-agent systems (with care -- coordination is difficult)
  6. **Cache:** Cache agent message history for cost and latency savings

- **URL (earlier blog post):** https://x.com/RLanceMartin/status/1937560769337675779
- **Key Quote:** "I wrote about some popular patterns for managing context ('context engineering') w/ AI agents"

### Maryam Miradi, PhD -- Context Engineering as #1 Skill
- **URL:** https://x.com/MaryamMiradi/status/1989377220381720873
- **Key Quote:** "Context Engineering: The #1 Skill for Building AI Agents in 2025. If you're building AI agents, you're probably facing the same headache: Your agent starts strong -> performs a few tool calls -> suddenly gets confused -> outputs garbage."
- **Key Analogy:** LLM = CPU, Context Window = RAM (limited capacity), Context Engineering = managing what fits in RAM
- **Core Problem:** "Context poisoning" -- as agents run longer, context fills with tool feedback, memories, and instructions, eventually drowning in their own data.

### Hesamation -- Anthropic Guide Breakdown
- **URL:** https://x.com/Hesamation/status/1976303978364248530
- **Key Insights from Anthropic's guide:**
  - "Context Rot is real. As the number of tokens in the context window [grows, performance degrades]"
  - Compaction: summarize message history near context limit
  - Structured note-taking: jot notes outside context window, pull in when needed
  - Caching: cache frequently used info (agent instructions, tool descriptions) to context prefix

### Lena Hall -- Context Engineering 101 Cheat Sheet
- **URL:** https://x.com/lenadroid/status/1943685060785524824
- **Key Quote:** "Here is the ultimate Context Engineering 101 cheat sheet. And if you like a more descriptive intro, watch my video on Context Engineering vs Prompt Engineering."
- **Recommended Resources:** 12-Factor Agents by Dex Horthy, various video tutorials

### Raphael Mansuy -- Google ADK Architecture Analysis
- **URL:** https://x.com/raphaelmansuy/status/1997898784400138313
- **Key Quote:** "Most agent frameworks treat context like a mutable string buffer. Google's ADK treats it like source code that needs compilation."
- **Key Insight:** "Your context window isn't a chat log -- it's a compiled view assembled on-demand from session history (events), working state (variables), long-term memory (facts across sessions), and artifacts (documents, files)."
- **Metaphor:** "Your architecture is the compiler" -- the traditional "append everything" approach fails due to cost spirals, latency degradation, and signal loss.

### Victor Victory -- Google Multi-Agent Guide Takeaways
- **URL:** https://x.com/PBensalah/status/1997641994475106770
- **Key Quote:** "Context windows aren't the bottleneck. Context engineering is."
- **Key Insight:** Raw context dumps create critical failures: cost explosion from repetitive information, performance degradation from "lost in the middle" effects, and increased hallucination rates.

---

## 5. Academic & Research Discussions

### Agentic Context Engineering (ACE) -- Stanford/Berkeley Paper
- **URL (Rohan Paul):** https://x.com/rohanpaul_ai/status/1975732878739665393
- **Key Quote:** "This paper introduces a new method called Agentic Context Engineering (ACE). It helps language models improve by updating what they read and remember, instead of changing their core weights."
- **Results:** ~10% higher accuracy, ~87% reduction in learning time
- **Institutions:** Stanford University, SambaNova Systems, UC Berkeley

- **URL (Shubham Saboo):** https://x.com/Saboo_Shubham_/status/1978871310257156244
- **Key Quote:** "Stanford and Berkeley researchers just introduced Agentic Context Engineering -- a framework that makes LLMs smarter by evolving their context instead of updating model weights."

- **URL (Marktechpost):** https://x.com/Marktechpost/status/1976614553002930678
- **Summary:** "ACE framework that improves LLM performance by editing and growing the input context"

- **URL (Dr Singularity):** https://x.com/Dr_Singularity/status/1976744544763867356
- **Key Quote:** "End of fine-tuning? Stanford's new paper Agentic Context Engineering shows that models can become smarter without fine-tuning their weights."

- **URL (elvis/omarsar0 -- code release):** https://x.com/omarsar0/status/1996980037161996691
- **Key Quote:** "Agentic Context Engineering -- The code for the paper is finally out! I had built an implementation for this (not exactly the same) that already boosted performance for my agents."

### Context Engineering 2.0 -- Entropy Reduction Framework
- **URL (TuringPost):** https://x.com/TheTuringPost/status/1987916989797740574
- **Key Quote:** "Context Engineering 2.0: The Context of Context Engineering. GAIR researchers define context engineering as a process of entropy reduction -- turning complex human intentions into machine-readable data -- and as a core foundation of AI cognition."

### Everything is Context -- Agentic File System Abstraction
- **URL:** https://x.com/fly51fly/status/2010108957474607591
- **Paper:** "Everything is Context: Agentic File System Abstraction for Context Engineering" (University of New South Wales, ArcBlock, University of Tasmania)
- **Key Idea:** Treat AI context management as a file system problem.

### Context Engineering Survey (160+ pages)
- **URL (elvis/omarsar0):** https://x.com/omarsar0/status/1946241565728600503
- **Key Quote:** "A Survey of Context Engineering -- 160+ pages"

### Meta-Harness -- Stanford & MIT Paper
- **URL (elvis/omarsar0):** https://x.com/omarsar0/status/2038967842075500870
- **Key Quote:** "NEW Stanford & MIT paper on Model Harnesses. Changing the harness around a fixed LLM can produce a 6x performance gap on the same benchmark. What if we automated harness engineering itself? The work introduces Meta-Harness, an agentic system that searches over harness code."

---

## 6. Evolution: From Context Engineering to Harness Engineering

### Dex Horthy -- Introducing "Harness Engineering"
- **URL:** https://x.com/dexhorthy/status/1985699548153467120
- **Key Quote:** "There's a new concept I'm seeing emerging in AI Agents (especially coding agents), which I'll call 'harness engineering' -- applying context engineering principles to how you use an existing agent."
- **Distinction:**
  - **Context engineering** = how context (long or short, agentic or not) is passed to an LLM to get the best results
  - **Harness engineering** = engineering the integration points of a given agent to get the best results
- **Key Insight:** "You can't do harness engineering without understanding context engineering, and you can't do context engineering without building intuition around LLMs."
- **The "Dumb Zone":** Puts a threshold at 40% of the model's input capacity; pushing past that causes signal-to-noise degradation, attention fragmentation, and agent mistakes.

### Dex Horthy -- Superthread on Advanced Claude Code Usage
- **URL:** https://x.com/dexhorthy/status/1978676162495688719
- **Key Quote:** "superthread of every resource I have published about advanced claude code usage, research-plan-implement, and advanced context engineering for coding agents"

### Elvis (omarsar0) -- From Context to Harness Engineering
- **URL:** https://x.com/omarsar0/status/2031426008285421933
- **Key Quote:** "context engineering --> harness engineering. build your own agent harness. it gets you in the mindset of building for agents (eg. cli, api, skills, memory, automations, schedulers,...) where things are headed, you won't regret having a good understanding of these"

### Elvis (omarsar0) -- Skills as Context Engineering
- **URL:** https://x.com/omarsar0/status/1979547649519899019
- **Key Quote:** "At a high level, Skills is great for context engineering and steering Claude Code. But I strongly agree on the continual learning stuff. Skills are a bigger deal than I initially thought."

### AI Engineer -- 12-Factor Agents & Context Engineering
- **URL:** https://x.com/aiDotEngineer/status/1940876485939564586
- **Key Quote:** "Want to learn more about Context Engineering? Start here. 12-factor Agents: Patterns of reliable LLM applications -- next featured talk on our Agent Reliability track is the fan favorite manifesto by @dexhorthy, who, among many other things, coined [the term]."

---

## 7. Criticism & Counter-Perspectives

### "Context Engineering is Overhyped"
- **Source:** InnoBlog (InnoGames engineering blog)
- **URL:** https://blog.innogames.com/why-context-engineering-is-overhyped-and-how-automation-fixes-it/
- **Key Arguments:**
  - "Obsessing over context engineering is a productivity sink that breaks your coding flow"
  - "The hype around becoming an expert in 'Context Engineering' or 'Prompt Orchestration'... turns developers into prompt janitors"
  - Proposes automating systems around AI rather than perfecting inputs

### "Context Engineering is Already Obsolete"
- **Source:** OpenAI Developer Community Forum
- **URL:** https://community.openai.com/t/prompt-engineering-is-dead-and-context-engineering-is-already-obsolete/1314011
- **Key Argument:** The future is "Automated Workflow Architecture with LLMs" rather than manual context curation.

### "Nothing New" Criticism
- **Key Argument (from various community members):** Many experienced developers view "context engineering" as repackaged concepts from information retrieval, RAG, and system design that practitioners have been doing for years under different names.
- **Counter from Harrison Chase:** "This is not a new concept -- agent builders have been doing it for the past year or two, but it's a new term which will hopefully draw attention to the skills and tools needed to do this properly."

### JakobGPT -- Cost Concerns
- **URL:** https://x.com/jaakobw/status/1946228037541908603
- **Key Quote:** "Context is expensive, so you build deterministic code. Agents need tons of context but feeding it burns money. Email automation = Asana integrations, CRM updates, transforms. The 'AI magic' becomes traditional software engineering."

---

## 8. CLAUDE.md & Cursor Rules as Context Engineering

### Boris Cherny -- Creator of Claude Code
- **URL:** https://x.com/bcherny/status/2007179832300581177
- **Key Insights:**
  - Keeps one shared CLAUDE.md checked into git as product safety rails
  - Whenever Claude does something incorrectly, adds it to CLAUDE.md so Claude avoids repeating the mistake
  - Tags @.claude on coworkers' PRs to add learnings to CLAUDE.md via GitHub action
  - "Claude is eerily good at writing rules for itself"
  - Runs 10-15 concurrent Claude Code sessions; landed 259 PRs with 497 commits in 30 days
  - Every line written by Claude Code + Opus 4.5

- **URL (Hasan Toor sharing):** https://x.com/hasantoxr/status/2025851900911038603
- **Key Quote:** "The creator of Claude Code just leaked how his own team actually uses it. Boris Cherny (Anthropic engineer who BUILT Claude Code) posted his internal workflows on X. Someone turned it into a CLAUDE.md file you can drop into any project right now."

### CLAUDE.md Best Practices (Community Consensus)
- **Source:** Multiple threads and blog posts referenced on Twitter
- **Key Principles:**
  - Keep CLAUDE.md under 300 lines; only universally applicable instructions
  - Prefer pointers (file:line references) over code snippets that become outdated
  - Prevention over correction: set constraints to prevent mistakes rather than fixing them after
  - CLAUDE.md loads at session start; in long conversations, Claude can "forget" constraints due to recency bias

### Cursor Rules as Context Engineering
- **Source:** Multiple community discussions
- **Key Principles:**
  - Rules function as long-term memory for teams
  - Aim for ~1 concept per rule, 50-80 lines
  - Use .cursor/rules/*.mdc files combined with MCPs, Memories, and Auto-run
  - Use surgical context with @-symbols (@code, @file, @folder) rather than relying on auto-detection

---

## 9. Key Resources Shared on Twitter

| Resource | Shared By | URL |
|----------|-----------|-----|
| Anthropic's Context Engineering Guide | @AnthropicAI | https://anthropic.com/engineering/effective-context-engineering-for-ai-agents |
| Google's "Sessions & Memory" Whitepaper | @DataScienceDojo, @omarsar0 | https://www.kaggle.com/whitepaper-context-engineering-sessions-and-memory |
| Google's Multi-Agent Context Engineering Guide | @rohanpaul_ai | (shared via thread) |
| LangChain "Rise of Context Engineering" | @hwchase17 | https://blog.langchain.com/the-rise-of-context-engineering/ |
| Weaviate Complete Guide to Context Engineering | @weaviate_io | (shared as free e-book) |
| Philipp Schmid's Blog Post | @_philschmid | https://www.philschmid.de/context-engineering |
| Simon Willison's Blog Post | @simonw | https://simonwillison.net/2025/Jun/27/context-engineering/ |
| 12-Factor Agents (Dex Horthy) | @aiDotEngineer, @lenadroid | (manifesto for reliable LLM apps) |
| ACE Paper (Stanford/Berkeley) | @rohanpaul_ai, @Saboo_Shubham_ | (arXiv paper) |
| Lance Martin's Context Engineering for Agents | @RLanceMartin | https://rlancemartin.github.io/2025/06/23/context_engineering/ |
| Jeff Huber "RAG is Dead" (Latent Space) | @jeffreyhuber | https://www.latent.space/p/chroma |
| HumanLayer Blog on CLAUDE.md | @dexhorthy | https://www.humanlayer.dev/blog/writing-a-good-claude-md |
| Boris Cherny's Claude Code Setup | @bcherny | (thread on X) |

---

## 10. Timeline of the Discourse

### Pre-2025: Foundations
- **2023:** Charles Packer (MemGPT) introduces self-directed context management via tool calling -- arguably the first "agentic context engineering"
- **Early 2025:** Dex Horthy develops 12-Factor Agents manifesto and begins discussing context engineering at meetups

### June 2025: The Term Goes Mainstream
- **June 3:** Dex Horthy gives the "OG context engineering talk" at AI Engineer conference
- **June 19:** Tobi Lutke's viral tweet: "I really like the term 'context engineering' over prompt engineering"
- **June 23:** Harrison Chase (LangChain) publishes "The Rise of Context Engineering" + tweet
- **June 23:** Lance Martin writes his blog post on context engineering patterns for agents
- **June 25:** Andrej Karpathy endorses the term: "+1 for context engineering over prompt engineering"
- **June 25:** Tobi Lutke: "DSPy is my context engineering tool of choice"
- **June 25:** Philipp Schmid publishes his definition and blog post
- **June 27:** Simon Willison publishes blog post: "I think context engineering is going to stick"

### July-August 2025: Deepening the Discourse
- **July:** Lance Martin and David Breunig hold context engineering meetup; share slides and themes
- **August:** Jeff Huber (Chroma) declares "RAG is Dead, Long Live Context Engineering" on Latent Space podcast
- **Ongoing:** Community debates whether the term is genuinely new or rebranded existing practices

### September-October 2025: Institutionalization
- **September 29:** Anthropic publishes "Effective Context Engineering for AI Agents" engineering blog -- gets ~500K views
- **October:** Philipp Schmid shares 5 practical tips for context engineering
- **October:** Jerry Liu (LlamaIndex) shares practical techniques breakdown
- **Ongoing:** Enterprise discussions (Aaron Levie/Box) emphasize context engineering as the key to agent adoption

### November-December 2025: Maturation
- **November:** Anthropic publishes follow-up on long-running agents and context windows
- **November:** Google releases "Sessions & Memory" whitepaper (70 pages)
- **November:** Lena Hall releases Context Engineering 101 cheat sheet
- **December:** Google releases multi-agent context engineering guide
- **December:** TuringPost covers "Context Engineering 2.0" -- entropy reduction framework
- **December:** ACE paper code officially released; community implements variations
- **December:** Weaviate releases complete guide with 6-component framework

### Early 2026: Evolution
- **Ongoing:** Dex Horthy introduces "harness engineering" as the next evolution beyond context engineering
- **Ongoing:** Elvis (omarsar0) champions the context engineering --> harness engineering progression
- **Ongoing:** Stanford & MIT publish Meta-Harness paper showing 6x performance gaps from harness changes
- **Ongoing:** Aaron Levie continues enterprise-focused context engineering discourse

---

## Key Recurring Themes Across the Discourse

1. **Context engineering > prompt engineering:** Near-universal agreement that the term better captures what practitioners actually do
2. **Systems thinking, not wordsmithing:** Context engineering is about building dynamic systems, not crafting clever prompts
3. **The context paradox:** Agents need more context for complex tasks, but performance degrades as context grows
4. **Context rot/poisoning:** Long-running agents accumulate noise, outdated info, and conflicting signals
5. **The compiler metaphor:** Context should be "compiled" from multiple sources on-demand, not appended as a growing log
6. **File system as context:** Writing state to files (todo.md, scratchpads) to offload context from the window
7. **Memory architecture:** Distinction between session (short-term) and memory (long-term) is critical
8. **Cost and latency:** Context is expensive; caching, compaction, and smart retrieval are economic necessities
9. **Multi-agent isolation:** Each sub-agent gets its own context window to prevent contamination
10. **The 40% rule:** Dex Horthy's heuristic -- pushing past 40% of context capacity enters the "dumb zone"

---

## Most Influential Voices (by volume and impact of posts)

| Rank | Person | Handle | Affiliation | Role in Discourse |
|------|--------|--------|-------------|-------------------|
| 1 | Dex Horthy | @dexhorthy | HumanLayer | Coined the term; 12-Factor Agents; harness engineering |
| 2 | Tobi Lutke | @tobi | Shopify | Viral catalyst; connected term to mainstream tech |
| 3 | Andrej Karpathy | @karpathy | (formerly OpenAI) | Technical legitimization; most-quoted definition |
| 4 | Aaron Levie | @levie | Box | Enterprise context engineering champion |
| 5 | Philipp Schmid | @_philschmid | Google DeepMind | Formal definition; practical tips |
| 6 | Harrison Chase | @hwchase17 | LangChain | Ecosystem framing; LangGraph as CE tool |
| 7 | Lance Martin | @RLanceMartin | LangChain | Practical patterns; meetup organizer |
| 8 | Simon Willison | @simonw | Independent | Linguistic analysis; blog amplification |
| 9 | Elvis (omarsar0) | @omarsar0 | Prompt Engineering Guide | Prolific curator; research amplifier |
| 10 | Jeff Huber | @jeffreyhuber | Chroma | "RAG is Dead" provocateur |
| 11 | swyx | @swyx | SmolAI / AI Engineer | Platform amplifier; conference organizer |
| 12 | Jerry Liu | @jerryjliu0 | LlamaIndex | Practical techniques framework |
| 13 | Boris Cherny | @bcherny | Anthropic | CLAUDE.md as applied context engineering |
| 14 | Charles Packer | @charlespacker | (MemGPT) | Historical roots; agentic CE since 2023 |
| 15 | Maryam Miradi | @MaryamMiradi | Independent | Accessible educational content |

---

*Research compiled from web searches of X/Twitter content. Dates are approximate where exact timestamps were not available from search results. Engagement metrics were not consistently available in search result snippets.*
