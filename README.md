# nv: skills

**Skills for engineers who ship.**

A collection of AI agent skills by [johnnichev](https://github.com/johnnichev). One install, all tools.

```bash
npx skills add johnnichev/nv-skills -g -y
```

## Skills

| Skill | Command | What it does |
|-------|---------|-------------|
| **nv:context** | `/nv-context` | Context engineering setup — interviews you, analyzes codebase, generates AGENTS.md/CLAUDE.md, hooks, session management, token budgets. 200+ research sources. |
| **nv:design** | `/nv-design` | Professional web design — extract design systems from reference sites, recombine them, build landing pages, modernize old sites, generate image prompts. Vibe Design methodology. |

---

## nv:context

`/nv-context` analyzes your repository, interviews you about your workflow, and generates the complete context engineering infrastructure — so every AI coding agent works at maximum effectiveness.

> "Most agent failures are not model failures — they are context failures."
> — Philipp Schmid, Google DeepMind

---

## The Problem

Your AI agent is smart. But it keeps running the wrong test command, touching files it shouldn't, and forgetting your rules mid-session. You've tried writing a CLAUDE.md. Maybe you ran `/init`. It didn't help — and research proves why:

| Finding | Source |
|---------|--------|
| Auto-generated configs **reduce** success by 3% | ETH Zurich |
| Experienced devs are 19% **slower** with bad AI context | METR Study |
| 40%+ of AI project failures stem from poor context | IntuitionLabs |
| Using 40% of context window outperforms using 90% | Dex Horthy |
| A focused 300-token context beats unfocused 113K tokens | FlowHunt |

**Bad context doesn't just not help — it actively hurts.**

## The Solution

nv:context applies 200+ research sources to set up your repo correctly. In under 3 minutes:

1. **Interviews you** about your tools, pain points, landmines, and workflow preferences
2. **Analyzes your codebase** for non-obvious patterns, exact commands, and architectural gotchas
3. **Scores your setup** with the Hierarchy of Leverage framework
4. **Generates tailored configs** — only for tools you use, only content agents can't discover themselves
5. **Sets up hooks** for deterministic enforcement (auto-format, branch protection, PostCompact re-injection)
6. **Creates session management** — HANDOFF.md, .claudeignore, Document-and-Clear workflow
7. **Installs compounding engineering** — your codebase gets smarter with every PR review

## What Gets Generated

```
your-repo/
  AGENTS.md                         # Universal (25+ AI tools read this)
  CLAUDE.md                         # Claude-specific with @imports (<50 lines)
  tests/CLAUDE.md                   # Testing scope
  src/CLAUDE.md                     # Source scope
  HANDOFF.md                        # Session handoff template
  .claudeignore                     # Exclude irrelevant files from context
  .claude/settings.local.json       # Hooks (auto-format, branch protection, PostCompact)
  .cursor/rules/*.mdc               # Cursor scoped rules (if you use Cursor)
  .github/copilot-instructions.md   # Copilot config (if you use Copilot)
  .github/workflows/
    learn-from-reviews.yml          # Auto-learn from PR reviews
```

## Install

**Option 1: Skills CLI (recommended)**
```bash
npx skills add johnnichev/nv-skills -g -y
```

**Option 2: One-liner**
```bash
mkdir -p ~/.claude/skills/nv-context && curl -o ~/.claude/skills/nv-context/SKILL.md \
  https://raw.githubusercontent.com/johnnichev/nv-skills/main/skills/nv-context/SKILL.md
```

**Option 3: Clone with templates**
```bash
git clone https://github.com/johnnichev/nv-skills.git
mkdir -p ~/.claude/skills/nv-context
cp -r nv:context/skills/nv-context/* ~/.claude/skills/nv-context/
```

**Then open any project and run:**
```
/nv-context
```

## Key Features

### Hierarchy of Leverage Scoring

Not just L0-L6 maturity — scores each layer independently:

```
Hierarchy of Leverage Score
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Verification        [██████████] 10/10
CLAUDE.md quality   [████████░░]  8/10
Hooks               [██░░░░░░░░]  2/10  <- biggest gap
Skills              [████████░░]  8/10
Subagent patterns   [░░░░░░░░░░]  0/10
Session management  [████████░░]  8/10
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Overall             36/60

Top recommendation: Set up hooks for auto-format
and PostCompact re-injection to reach 48/60.
```

### Token Budget Report

Know exactly how much context you're spending before a conversation starts:

```
Context Budget Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
System prompt          ~2,500 tokens
CLAUDE.md              ~800 tokens
Skill descriptions     ~400 tokens
MCP tools              ~1,200 tokens
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Baseline cost          ~4,900 tokens
Available for work     ~123,100 (96%)
Status: HEALTHY
```

### PostCompact Context Re-injection

The #1 complaint: "my agent forgets rules mid-session." nv:context installs a hook that automatically re-injects critical context after compaction fires. Your landmines and boundaries survive context compression.

### Negative Instruction Detection

Research proves "don't use X" makes agents MORE likely to use X. nv:context scans your configs and rewrites:

```
BEFORE: "don't use moment.js"
AFTER:  "MUST use date-fns for all date operations"

BEFORE: "avoid raw SQL queries"  
AFTER:  "MUST use the ORM query builder for database operations"
```

### Compounding Engineering

Tag PR reviews with `@claude-learn` and the learning auto-creates a PR adding it to AGENTS.md. Your context improves with every code review.

### Multi-Level Hierarchy

Not just root configs — generates scoped files per directory:

```
CLAUDE.md              # Orientation (50-100 lines)
tests/CLAUDE.md        # Testing patterns, async rules
src/CLAUDE.md          # Import conventions, code patterns
src/api/CLAUDE.md      # API-specific patterns
```

Agents only load what's relevant to where they're working.

## The 8 Laws

Built into every file nv:context generates:

1. **Less is more** — every line must earn its place
2. **Landmines, not maps** — document what agents can't discover
3. **Commands beat prose** — snippets over paragraphs
4. **Context is finite** — 150-200 instruction budget
5. **Progressive disclosure** — layer context by need
6. **Hooks for determinism** — 100% compliance for critical rules
7. **Negative instructions backfire** — "MUST use Y" not "don't use X"
8. **Compact proactively** — 60% safe, 70% degrading, 85% hallucinating

## Research

nv:context is built on the most comprehensive context engineering research compilation that exists:

**12 research documents, 471KB, 200+ sources:**

| Document | Coverage |
|----------|----------|
| [Definitions & Theory](research/logs/definitions_research.md) | Karpathy, Schmid, Anthropic, academic foundations |
| [Articles & Blog Posts](research/logs/articles_research.md) | 36 deep-analyzed articles |
| [X/Twitter Discourse](research/logs/twitter_research.md) | 50+ posts from 15+ thought leaders |
| [YouTube & Talks](research/logs/youtube_research.md) | 15 videos, 11 podcasts, 5 conference talks |
| [Tools & Frameworks](research/logs/tools_research.md) | 50+ tools across 10 categories |
| [Agent Config Patterns](research/logs/agent_config_research.md) | 10 config formats, ETH Zurich data |
| [Reddit & Forums](research/logs/reddit_forums_research.md) | Practitioner war stories, anti-patterns |
| [GitHub Discussions](research/logs/github_discussions_research.md) | 40+ real CLAUDE.md files, hooks, skills |
| [Community Wisdom](research/logs/community_forums_research.md) | Dev.to, HackerNews, METR study |
| [Advanced Patterns](research/logs/advanced_claude_patterns_research.md) | Boris Cherny's workflow, hierarchy of leverage |
| [Python Patterns](research/logs/python_specific_research.md) | MCP SDK, Pydantic AI, Python-specific patterns |
| [Workflow Patterns](research/logs/workflow_patterns_research.md) | RPI, subagents, TDD, debugging, worktrees |

Key sources: Anthropic, ETH Zurich, Google DeepMind, Manus, LangChain, GitHub (2,500-repo analysis), JetBrains (NeurIPS 2025), METR, Boris Cherny (Claude Code creator), Dex Horthy (12-Factor Agents).

[Full synthesis](research/SYNTHESIS.md)

## Docs

- [Quickstart](docs/QUICKSTART.md) — 2-minute install guide
- [Manifesto](docs/MANIFESTO.md) — the philosophy
- [Hierarchy of Leverage](docs/HIERARCHY-OF-LEVERAGE.md) — the framework
- [FAQ](docs/FAQ.md) — common questions

## Contributing

nv:context improves when practitioners share what works. Open an issue or PR with:
- Patterns that improved your agent performance
- Anti-patterns you discovered the hard way
- Research we should include
- Tool-specific configs we're missing

## License

MIT

---

**Built by [johnnichev](https://github.com/johnnichev).** For engineers who ship.
