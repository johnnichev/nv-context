# Changelog

## v2.0.0 (2026-04-04)

### Added
- **Phase 0: Engineer Interview** — personalized setup based on tools, team, pain points, and landmines
- **Hierarchy of Leverage scoring** — per-layer scoring (verification, CLAUDE.md, hooks, skills, subagents, session management)
- **Token budget report** — estimates context consumption before conversation starts
- **PostCompact context re-injection hook** — auto-reinjects critical context after compaction
- **HANDOFF.md template** — session handoff for persistent context across sessions
- **Document-and-Clear workflow** — outperforms auto-compaction
- **.claudeignore generation** — excludes irrelevant files from agent context
- **Negative instruction detection** — scans and rewrites "don't X" to "MUST Y"
- **Multi-level hierarchy** — separate CLAUDE.md files per directory (root, tests/, src/)
- **Compounding engineering** — GitHub Action for auto-learning from PR reviews
- **Pre-built hook library** — auto-format, branch protection, quality gates, PostCompact
- **Templates** — AGENTS.md, CLAUDE.md, HANDOFF.md, .claudeignore, hooks, GitHub Actions

### Research
- 12 research documents, 471KB total
- 200+ sources from Anthropic, ETH Zurich, Google DeepMind, Manus, and more
- Round 1: theory, articles, X/Twitter, YouTube, tools, agent configs
- Round 2: Reddit, GitHub Discussions, Dev.to/HN, advanced patterns, Python-specific, workflows

## v1.0.0 (2026-04-04)

### Added
- Initial release
- 8-phase setup (analyze, score, generate, hooks, MCP, skills, audit)
- L0-L6 maturity framework
- Multi-tool support (Claude Code, Cursor, Copilot, Windsurf, Aider, Gemini)
- Research synthesis from Round 1 (6 agents, 150+ sources)
