# FAQ

## General

**What is nv:context?**
A Claude Code skill that sets up state-of-the-art context engineering for any repository. It analyzes your codebase, interviews you about your workflow, and generates the complete infrastructure — config files, hooks, session management, token budgets — so AI coding agents work at maximum effectiveness.

**What is context engineering?**
The systematic discipline of providing AI agents with the right information, in the right format, at the right time. It's the evolution beyond prompt engineering — instead of crafting clever prompts, you build the information ecosystem around your agents.

**Why not just use `/init`?**
ETH Zurich research proved that auto-generated config files REDUCE agent success by 3% and increase costs by 20%+. nv:context interviews you first, analyzes your codebase for non-obvious patterns, and generates minimal, high-signal configs. Every line earns its place.

**Which AI tools does this work with?**
The generated AGENTS.md works with 25+ tools including Claude Code, Cursor, GitHub Copilot, Windsurf, Aider, Gemini CLI, and more. Tool-specific configs (CLAUDE.md, .cursor/rules, etc.) are only generated for tools you actually use.

## Setup

**How long does setup take?**
~2 minutes for the interview, ~30 seconds for analysis and generation. Under 3 minutes total.

**Can I run it on an existing repo with configs?**
Yes. nv:context analyzes existing configs, scores them, and improves them rather than replacing wholesale. It will flag stale content, negative instructions, and missing critical sections.

**Do I need to install anything besides Claude Code?**
No. nv:context is a Claude Code skill. Copy the SKILL.md file and you're done.

## Technical

**How many lines should my CLAUDE.md be?**
Under 200 lines per root file. Under 100 is ideal. Under 50 is elite. The research is clear: shorter files with higher signal density outperform longer files.

**Why do negative instructions backfire?**
Research shows that "don't use X" increases the probability of the model using X — the instruction draws attention to X. "MUST use Y" directs attention to the correct alternative. Exception: "NEVER" as an absolute prohibition works fine.

**What's the PostCompact hook?**
When Claude's context gets compressed (compaction), it can lose critical rules. The PostCompact hook automatically re-injects the most important context after compaction fires. It solves the #1 complaint: "the agent forgets my rules mid-session."

**What's the hierarchy of leverage?**
A framework for prioritizing context engineering effort: verification > CLAUDE.md > hooks > skills > subagents > session management. Most people optimize from the bottom up. The best engineers start at the top.

**What's the token budget report?**
An estimate of how many tokens your config files consume before the conversation even starts. If your configs eat 60%+ of the context window, there's not enough room for the actual task. nv:context warns you when this happens.

## Philosophy

**Why "for engineers who ship"?**
Context engineering matters most for people building real software with AI agents. Demo-quality prompting is easy. Production-quality context is hard. nv:context is built for the latter.

**What's the METR study?**
A controlled study showing experienced developers are 19% slower with AI tools, despite feeling 24% faster. The 39-percentage-point perception gap means bad context actively hurts. Good context is what flips the equation.

**Why is the research included in the repo?**
The 12 research documents (471KB from 200+ sources) are the most comprehensive compilation on context engineering that exists. They're the foundation the skill is built on, and they're valuable as a standalone reference for anyone interested in the discipline.
