# UltraContext Marketing Materials

## Tagline

**"Context engineering for engineers who ship."**

## One-Liner

UltraContext analyzes your repo and sets up the complete context engineering infrastructure — so every AI agent works at maximum effectiveness. Built on 200+ research sources.

---

## X/Twitter Posts

### Launch Thread

**Post 1 (Hook):**
```
I spent 2 days researching everything about context engineering.

200+ sources. 12 research documents. 471KB of findings.

ETH Zurich, Anthropic, Google DeepMind, Manus, GitHub's 2,500-repo analysis, and every practitioner forum I could find.

Then I built UltraContext.

Thread:
```

**Post 2 (The Problem):**
```
The #1 finding that changed everything:

ETH Zurich proved that auto-generated CLAUDE.md files (like /init) REDUCE agent success by 3% and INCREASE costs by 20%.

Bad context doesn't just not help.
It actively makes you slower.

The METR study confirmed it: devs are 19% slower with bad AI context.
```

**Post 3 (The Insight):**
```
The best engineers don't write better prompts.

They build information ecosystems:
- Minimal configs that document landmines, not maps
- Hooks that enforce rules 100% of the time
- Progressive disclosure that loads context on-demand
- Session management that prevents context rot

This is context engineering.
```

**Post 4 (The Hierarchy):**
```
The Hierarchy of Leverage — where to invest your context engineering effort:

1. Verification (tests, linters) — 100% compliance
2. CLAUDE.md quality — 90-95%
3. Hooks — 100%
4. Skills — ~79% activation
5. Subagents — variable
6. Session management — manual

Most people optimize bottom-up. The best engineers start at the top.
```

**Post 5 (What UltraContext Does):**
```
UltraContext is a Claude Code skill that:

1. Interviews you about your tools, pain points, and landmines
2. Analyzes your codebase for non-obvious patterns
3. Scores your setup with the Hierarchy of Leverage
4. Generates tailored configs (AGENTS.md, CLAUDE.md, hooks)
5. Sets up session management and token budgets

Under 3 minutes. For any repo.
```

**Post 6 (Key Features):**
```
What makes UltraContext different from /init:

- PostCompact hook (re-injects context after compression)
- Negative instruction detection ("don't X" → "MUST Y")
- Token budget report (know your context spend)
- Multi-level hierarchy (scoped configs per directory)
- HANDOFF.md (session persistence across /clear)
- Compounding engineering (auto-learn from PR reviews)
```

**Post 7 (CTA):**
```
UltraContext is open source.

Install in 30 seconds:
mkdir -p ~/.claude/skills/ultracontext
# Copy SKILL.md from the repo

Then run /ultracontext in any project.

The full research library (471KB from 200+ sources) is included — the most comprehensive context engineering compilation that exists.

github.com/nichevLabs/UltraContext
```

---

### Standalone Posts

**The Numbers Post:**
```
Context engineering by the numbers:

- 150-200: max instructions an LLM follows reliably
- 60%: safe zone for context window usage
- 79%: skill activation rate vs 100% for embedded docs
- 19%: how much slower bad context makes you (METR)
- 3%: success reduction from auto-generated configs (ETH Zurich)
- 10x: cost difference between cached and uncached tokens (Manus)
- 80%: quality improvement from better context alone (Augment)

Context > model.
```

**The Negative Instructions Post:**
```
"Don't use moment.js" in your CLAUDE.md?

Research shows this INCREASES the chance your agent uses moment.js.

The word "don't" draws attention to the prohibited thing.

Fix: "MUST use date-fns for all date operations"

Only "NEVER" works as a prohibition. Soft negatives backfire.

UltraContext scans your configs and fixes all of these automatically.
```

**The PostCompact Post:**
```
The #1 complaint about AI coding agents:

"It forgets my rules mid-session."

Here's why: when context gets compressed (compaction), your CLAUDE.md rules get summarized away.

Fix: a PostCompact hook that re-injects critical context after compaction fires.

UltraContext sets this up automatically.
```

**The Boris Cherny Post:**
```
Boris Cherny (creator of Claude Code) landed 259 PRs with 497 commits in 30 days.

His setup:
- 5 parallel worktrees with 5 Claude instances
- Always starts in Plan Mode
- PostToolUse auto-format hooks
- Opus 4.5 with thinking exclusively
- Tags @.claude on PR reviews to auto-learn

This is what elite context engineering looks like.

UltraContext implements the same patterns for your repo.
```

---

## LinkedIn Post

```
Context engineering is the most underrated skill in AI-assisted development.

I spent two days researching everything on the topic — 200+ sources including ETH Zurich research, Anthropic's engineering blog, Google DeepMind's 70-page whitepaper, and practitioner wisdom from Reddit, HackerNews, and GitHub Discussions.

The findings are clear:

1. Auto-generated AI config files reduce success by 3% (ETH Zurich)
2. The right context setup improves quality by 80% — same model (Augment)
3. There's a Hierarchy of Leverage most people get backwards
4. "Don't do X" instructions make agents MORE likely to do X
5. Session management (not prompt crafting) is the real skill

So I built UltraContext — a tool that sets up any repository with research-backed context engineering in under 3 minutes.

It's open source: github.com/nichevLabs/UltraContext

The full 471KB research library is included. If you work with AI coding agents, the research alone is worth your time.

#ContextEngineering #AIEngineering #DeveloperTools
```

---

## Reddit Post (r/ClaudeAI or r/ClaudeCode)

```
Title: I researched 200+ sources on context engineering and built a skill that sets up any repo in 3 minutes

I went deep into the rabbit hole of context engineering — reading everything from ETH Zurich research papers to Reddit practitioner tips to Boris Cherny's (creator of Claude Code) actual workflow.

Key findings that surprised me:
- /init-generated CLAUDE.md files actually REDUCE success by 3% (ETH Zurich)
- "Don't use X" instructions backfire — they increase the probability of using X
- Skills only activate 79% of the time vs 100% for embedded docs
- The PostCompact hook (re-injecting context after compression) solves the "agent forgets rules" problem
- Using 40% of your context window outperforms using 90%

So I built UltraContext — a Claude Code skill that:
1. Interviews you about your setup and pain points
2. Analyzes your codebase
3. Generates tailored configs, hooks, and session management
4. Scores your setup with a Hierarchy of Leverage framework

The full research (12 documents, 471KB) is included in the repo. Even if you don't use the skill, the research is the most comprehensive compilation on context engineering I've seen.

Link: github.com/nichevLabs/UltraContext

Would love feedback from other Claude Code power users. What context engineering patterns have worked best for you?
```

---

## HackerNews Post

```
Title: UltraContext: Context engineering for AI coding agents, backed by 200+ research sources

Show HN: I compiled research from ETH Zurich, Anthropic, Google DeepMind, Manus, and 200+ other sources into a tool that sets up any repository for AI coding agents.

Key insight: most agent failures are context failures, not model failures. The research proves that auto-generated configs hurt performance, while carefully crafted context dramatically improves it.

UltraContext is a Claude Code skill (also generates configs for Cursor, Copilot, Windsurf, and Aider) that interviews you about your workflow, analyzes your codebase, and generates the minimal, high-signal configuration that actually helps.

Novel features:
- PostCompact hook that re-injects context after compression
- Negative instruction detection (rewrites "don't X" to "MUST Y")  
- Token budget calculator
- Hierarchy of Leverage scoring framework
- Compounding engineering (auto-learns from PR reviews)

The research library alone (471KB across 12 documents) might be useful even if you don't use the tool.

github.com/nichevLabs/UltraContext
```

---

## GitHub Topics/Tags

```
context-engineering, ai-agents, claude-code, cursor, copilot, developer-tools,
ai-coding, agents-md, claude-md, context-window, llm-tools, prompt-engineering,
agentic-coding, developer-productivity, ai-assisted-development
```

## GitHub Description

```
Context engineering for engineers who ship. Analyzes your repo and sets up AGENTS.md, CLAUDE.md, hooks, session management, and token budgets — backed by 200+ research sources.
```
