# UltraContext — Gemini CLI Support

This plugin provides context engineering setup for any repository.

## Available Skills

- `ultracontext` — Analyzes your codebase and generates optimal agent configuration files (AGENTS.md, CLAUDE.md, GEMINI.md, Cursor rules, Copilot instructions) with hooks, session management, and token budgets.

## Usage

Run `/ultracontext` in your repository to start the setup process.

## Tool Mapping (Gemini CLI)

When executing UltraContext skills in Gemini CLI:
- `Read` → `read_file`
- `Write` → `write_file`
- `Edit` → `edit_file`
- `Glob` → `glob`
- `Grep` → `grep`
- `Bash` → `shell`
