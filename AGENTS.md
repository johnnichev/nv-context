# UltraContext

Context engineering setup for AI coding agents. Works with Claude Code, Cursor, GitHub Copilot, Windsurf, Aider, and Gemini CLI.

## Skills

- `ultracontext` — Interviews the engineer, analyzes the codebase, generates multi-level config hierarchy, hooks, session management, and token budgets. Based on 200+ research sources.

## Installation

```bash
# Via skills CLI
npx skills add johnnichev/UltraContext@ultracontext -g -y

# Or manual
mkdir -p ~/.claude/skills/ultracontext
curl -o ~/.claude/skills/ultracontext/SKILL.md \
  https://raw.githubusercontent.com/johnnichev/UltraContext/main/skills/ultracontext/SKILL.md
```

## Usage

```
/ultracontext
```
