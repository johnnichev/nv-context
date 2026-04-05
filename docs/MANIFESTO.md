# The nv:context Manifesto

## The Problem

Most AI coding agents fail. Not because the models are dumb — they're remarkably capable. They fail because we feed them garbage context.

> "Most agent failures are not model failures — they are context failures."
> — Philipp Schmid, Google DeepMind

The evidence is damning:

- **40%+ of AI project failures** stem from poor context management (IntuitionLabs)
- **Auto-generated config files reduce success by 3%** and increase costs 20%+ (ETH Zurich)
- **A focused 300-token context outperforms an unfocused 113K-token context** (FlowHunt/LongMemEval)
- **Using 40% of context window outperforms using 90%** (Dex Horthy)
- **Experienced developers are 19% slower with AI tools** when context is poorly managed (METR)

That last one bears repeating: **bad context engineering doesn't just not help — it actively makes you slower.**

## The Shift

Prompt engineering is dead. The "prompt whisperer" era — where clever phrasing was the skill — is over.

What matters now is **context engineering**: the systematic discipline of designing the information ecosystem around your AI agents so they have exactly what they need and nothing more.

> "If prompt engineering was about coming up with a magical sentence, context engineering is about writing the full screenplay for the AI."
> — Addy Osmani, Google Chrome

The best engineers don't write better prompts. They build better systems:
- Minimal config files that document landmines, not maps
- Hooks that enforce rules deterministically, not probabilistically
- Progressive disclosure that loads context on-demand, not all-at-once
- Session management that prevents context rot
- Compounding feedback loops that make the system smarter over time

## The Hierarchy of Leverage

Not all context engineering is equal. Here's what moves the needle, in order:

```
1. Verification (tests, linters, CI)     ← highest leverage
2. CLAUDE.md / AGENTS.md quality
3. Hooks (deterministic enforcement)
4. Skills (on-demand context)
5. Subagent patterns (context isolation)
6. Session management (compaction, handoffs)
7. Worktrees (parallel isolation)          ← lowest leverage
```

Most people optimize from the bottom up. The best engineers start at the top.

## The 8 Laws

1. **Less is more.** Every line in your config competes with the actual task for attention.
2. **Landmines, not maps.** Document what agents can't discover. Delete everything else.
3. **Commands beat prose.** One snippet outperforms three paragraphs.
4. **Context is finite.** 150-200 instructions max. Budget them wisely.
5. **Progressive disclosure.** Layer your context: always → on-reference → on-demand → runtime.
6. **Hooks for determinism.** If a rule MUST be followed 100% of the time, use a hook.
7. **Negative instructions backfire.** "Don't use X" increases X. Say "MUST use Y."
8. **Compact proactively.** Don't wait for 95%. Manage your context like you manage your memory.

## The Standard

nv:context is the implementation of these principles. It analyzes your repository, interviews you about your landmines and workflows, and generates the complete context engineering infrastructure — config files, hooks, session management, token budgets — so every AI agent that touches your code works at maximum effectiveness.

It's not a prompt template. It's not a config generator. It's a context engineering system built on 200+ research sources from the people who build and study AI agents for a living.

**For engineers who ship.**
