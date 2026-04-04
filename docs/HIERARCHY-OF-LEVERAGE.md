# Hierarchy of Leverage

Not all context engineering has equal impact. This framework helps you invest effort where it matters most.

## The Hierarchy

```
Priority  Layer                    Compliance  Cost to Set Up
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   1      Verification             100%        Medium
   2      CLAUDE.md / AGENTS.md    90-95%      Low
   3      Hooks                    100%        Low
   4      Skills                   ~79%        Medium
   5      Subagent patterns        Variable    Medium
   6      Session management       Manual      Low
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Layer Details

### 1. Verification (Tests, Linters, CI)

**Compliance: 100%. The agent MUST pass or it doesn't ship.**

This is your highest leverage. A comprehensive test suite catches agent mistakes regardless of how good or bad your other context is. If your tests pass, the code works.

- Unit tests for business logic
- Integration tests for system boundaries
- Linters for style (don't waste CLAUDE.md lines on style)
- Type checking for correctness
- CI pipeline that gates merges

**If you only do one thing: write better tests.**

### 2. CLAUDE.md / AGENTS.md Quality

**Compliance: 90-95%. LLMs follow instructions most of the time.**

The highest-leverage text you'll write. But less is more:
- Under 200 lines (under 100 ideal)
- Commands with full flags first
- Landmines and gotchas second
- Three-tier boundaries third
- Everything else is probably noise

**The test: "Would removing this line cause a mistake?"**

### 3. Hooks

**Compliance: 100%. Code runs or it doesn't.**

Hooks are deterministic. They execute every time, no exceptions. Use them for:
- Auto-formatting after file changes
- Branch protection (block pushes to main)
- Quality gates before commits
- Context re-injection after compaction

**The rule: if it MUST happen 100% of the time, it's a hook, not an instruction.**

### 4. Skills

**Compliance: ~79% activation rate.**

Skills load on-demand when Claude detects relevance. Powerful for complex workflows, but they only activate ~79% of the time vs 100% for embedded docs.

- Use for recurring workflows (feature dev, releases, debugging)
- Keep descriptions clear so Claude knows when to activate
- If something MUST be followed, put it in CLAUDE.md, not a skill

### 5. Subagent Patterns

**Compliance: variable. Depends on how you delegate.**

Subagents provide context isolation. Fresh context window, focused task, summary back. Use for:
- Research/exploration (keeps main context clean)
- Parallel independent tasks
- TDD (separate agents for tests vs implementation)

### 6. Session Management

**Compliance: manual. You have to do it.**

The engineer's responsibility:
- HANDOFF.md before ending sessions
- `/clear` when context gets heavy (~40 messages)
- Proactive compaction at 60-70%
- .claudeignore to exclude noise

## Scoring Your Setup

Rate each layer 0-10:

| Score | Meaning |
|-------|---------|
| 0-2 | Absent or broken |
| 3-4 | Exists but generic |
| 5-6 | Functional, some gaps |
| 7-8 | Strong, follows best practices |
| 9-10 | Elite, production-hardened |

**Where to invest:** The layer with the lowest score relative to its priority.

A setup with 10/10 verification and 3/10 everything else outperforms a setup with 8/10 everything but 4/10 verification.
