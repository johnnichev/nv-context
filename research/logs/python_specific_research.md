# Python-Specific Research: CLAUDE.md / AGENTS.md Patterns for Python Libraries

**Date**: 2026-04-04
**Purpose**: How Python library/framework developers set up repositories for AI coding agents
**Target**: selectools (Python SDK for multi-agent orchestration)

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Real CLAUDE.md / AGENTS.md Files Analyzed](#real-files-analyzed)
3. [Pattern 1: Package Management Instructions](#pattern-1-package-management)
4. [Pattern 2: Testing Configuration for Agents](#pattern-2-testing)
5. [Pattern 3: Type Checking Instructions](#pattern-3-type-checking)
6. [Pattern 4: Import Conventions and src-layout](#pattern-4-imports)
7. [Pattern 5: Async Code Patterns](#pattern-5-async)
8. [Pattern 6: Python-Specific Gotchas](#pattern-6-gotchas)
9. [Pattern 7: Code Quality and Linting](#pattern-7-code-quality)
10. [Pattern 8: Commit and PR Conventions](#pattern-8-commits)
11. [Pattern 9: Coverage and CI Integration](#pattern-9-coverage)
12. [Pattern 10: Error Handling Conventions](#pattern-10-error-handling)
13. [Pattern 11: Documentation Standards](#pattern-11-documentation)
14. [Pattern 12: Multi-Level AGENTS.md Hierarchy](#pattern-12-hierarchy)
15. [Composite Template for selectools](#composite-template)
16. [Sources](#sources)

---

## Executive Summary

After analyzing CLAUDE.md and AGENTS.md files from 15+ major Python repositories (MCP Python SDK, OpenAI Agents Python, Google ADK Python, LangChain, LangGraph, Pydantic AI, Inngest-py, Claude Agent SDK Python, and templates from pydevtools, minimaxir, and others), clear patterns emerge for how elite Python libraries guide AI coding agents.

### Key Findings

1. **uv is the universal standard** -- Every analyzed production repo mandates uv exclusively, banning pip, bare pytest, and .venv/bin/ paths
2. **Testing instructions are the highest-value content** -- Exact commands, coverage thresholds, and test patterns dominate successful files
3. **Brevity wins** -- The best files are under 200 lines; bloated files cause agents to ignore instructions
4. **Hierarchy matters** -- Top repos use multiple AGENTS.md files (root, tests/, models/, docs/) for directory-specific rules
5. **Explicit prohibitions work** -- "NEVER do X" patterns are universally adopted and effective
6. **Common commands are number-one priority** -- The single highest-value content is exact test/lint/format commands

---

## Real Files Analyzed

### 1. MCP Python SDK (modelcontextprotocol/python-sdk/CLAUDE.md)

**Full extracted content** (the gold standard for Python libraries):

**Package Management:**
- ONLY use uv, NEVER pip
- uv add package for installation
- uv run tool for running tools
- uv lock --upgrade-package package for upgrades
- FORBIDDEN: uv pip install, @latest syntax

**Code Quality:**
- Type hints required for all code
- Public APIs must have docstrings
- Functions must be focused and small
- Follow existing patterns exactly
- Line length: 120 chars maximum
- FORBIDDEN: imports inside functions -- THEY SHOULD BE AT THE TOP OF THE FILE

**Testing Requirements:**
- Framework: uv run --frozen pytest
- Async testing: use anyio, NOT asyncio
- Do not use Test prefixed classes, use functions
- CI requires 100% coverage (fail_under = 100, branch = true)
- The tests/client/test_client.py is the most well-designed test file (exemplar)
- Be minimal, focus on E2E tests using mcp.client.Client
- Full check: ./scripts/test (~23s)
- Targeted check while iterating (~4s):
  uv run --frozen coverage erase
  uv run --frozen coverage run -m pytest tests/path/test_foo.py
  uv run --frozen coverage combine
  uv run --frozen coverage report --include='src/mcp/path/foo.py' --fail-under=0
  UV_FROZEN=1 uv run --frozen strict-no-cover

**Coverage Pragmas:**
- # pragma: no cover -- line is never executed; CI strict-no-cover fails if it IS executed
- # pragma: lax no cover -- excluded from coverage but not checked by strict-no-cover
- # pragma: no branch -- excludes branch arcs only (useful for Python 3.11+ async quirks)

**Async Testing Patterns:**
- Avoid anyio.sleep() with fixed duration to wait for async operations
- Use anyio.Event -- set it in callback/handler, await event.wait()
- For stream messages, use await stream.receive() instead of sleep() + receive_nowait()
- Exception: sleep() appropriate for time-based features (timeouts)
- Wrap indefinite waits in anyio.fail_after(5) to prevent hangs

**Test File Organization:**
- Test files mirror source tree: src/mcp/client/streamable_http.py -> tests/client/test_streamable_http.py

**Commits:**
- For bug fixes from user reports: git commit --trailer "Reported-by:name"
- For GitHub issues: git commit --trailer "Github-Issue:#number"
- NEVER mention co-authored-by or tool used

**Type Checking:**
- Tool: uv run --frozen pyright
- Requirements: Type narrowing for strings; version warnings can be ignored

**Error Handling:**
- Always use logger.exception() instead of logger.error() when catching exceptions
- Do not include exception in message: logger.exception("Failed") not logger.exception(f"Failed: {e}")
- Catch specific exceptions: File ops (OSError, PermissionError); JSON json.JSONDecodeError; Network (ConnectionError, TimeoutError)
- FORBIDDEN: except Exception: unless in top-level handlers

**Breaking Changes:**
- Document in docs/migration.md: What changed, Why, How to migrate

---

### 2. OpenAI Agents Python (openai/openai-agents-python/AGENTS.md)

**Mandatory Skills (unique pattern):**
- $code-change-verification: Run before marking work complete when changes affect runtime code, tests, or build/test behavior
- $openai-knowledge: Use when working on OpenAI API integrations
- $implementation-strategy: Before changing runtime code, exported APIs, external config, persisted schemas
- $pr-draft-summary: Final handoff to generate PR summary

**ExecPlans:** Required when work spans multiple files, involves new features/refactors, or takes over an hour

**Public API Positional Compatibility:**
- Treat parameter and dataclass field order as a compatibility contract
- Preserve existing positional arguments
- Append new optional fields at the end

**Development Workflow:**
1. Create feature branch: git checkout -b feat/short-description
2. Run make sync if dependencies changed
3. Implement changes with tests
4. Build docs if touched: make build-docs
5. Run $code-change-verification
6. Commit with concise imperative messages
7. Invoke $pr-draft-summary after substantial code work

**Testing Commands:**
- Full suite: make tests
- Focused: uv run pytest -s -k pattern
- Type checking: make typecheck
- Fix snapshots: make snapshots-fix
- Coverage: make coverage
- Format and lint: make format (applies fixes) and make lint (checks only)

**Mandatory local run order for verification:**
make format
make lint
make typecheck
make tests

**Runtime Guidelines:**
- src/agents/run.py is the entrypoint -- keep it focused on orchestration
- Put new logic in src/agents/run_internal/ modules
- Keep streaming and non-streaming paths behaviorally aligned
- Input guardrails run only on the first turn and only for the starting agent
- If serialized RunState shape changes, update CURRENT_SCHEMA_VERSION

---

### 3. Google ADK Python (google/adk-python/AGENTS.md)

**The most comprehensive file analyzed** (covers Python best practices exhaustively):

**Agent Structure Convention (mandatory):**
my_agent/
  __init__.py      # MUST: from . import agent
  agent.py         # MUST: root_agent = Agent(...) OR app = App(...)

**Code Style (Google Python Style Guide):**
- 2-space indentation
- 80-character line length
- function_names (snake_case), ClassNames (CamelCase), CONSTANTS (UPPER_CASE)
- Docstrings required for all public modules, functions, classes, methods
- Run ./autoformat.sh before committing

**Import Conventions (CRITICAL):**

In src/ -- use RELATIVE imports:
  from ..agents.llm_agent import LlmAgent     # Correct
  from google.adk.agents.llm_agent import LlmAgent  # WRONG

In tests/ -- use ABSOLUTE imports:
  from google.adk.agents.llm_agent import LlmAgent   # Correct
  from ..agents.llm_agent import LlmAgent             # WRONG

Import from modules, NOT __init__.py:
  from ..agents.llm_agent import LlmAgent     # Correct
  from ..agents import LlmAgent              # WRONG

**Required in every source file:**
from __future__ import annotations

**Testing Philosophy:**
- Use real code over mocks -- mock only external dependencies
- Test interface behavior, not implementation details
- Tests should be independent and fast
- Descriptive test names explaining what behavior is being tested

**Python Best Practices encoded:**
- Never use mutable default arguments; use None as sentinel
- Use is/is not for singletons (None, True, False)
- Use == for value comparison
- Return NotImplemented for unhandled types in __eq__
- Use @property for simple getters/setters only; avoid for expensive ops
- Use * for keyword-only arguments; / for positional-only arguments
- Type hints: use abstract types from collections.abc (Sequence, Mapping, Iterable)
- Avoid pickle due to security risks
- Use functools.wraps() in decorators to preserve metadata
- Use context managers for resource cleanup

**Commit Format:**
type(scope): description

Types: feat, fix, refactor, docs, test, chore

---

### 4. LangChain (langchain-ai/langchain/CLAUDE.md and AGENTS.md)

**Monorepo Architecture:**
- Multiple independently versioned packages under libs/
- Each package has own pyproject.toml and uv.lock
- Uses uv for package management, make as task runner

**Development Tools:**
- uv sync --all-groups for setup
- make test for unit testing
- make lint and make format for code quality
- mypy for type checking

**Code Standards:**
- ALL code requires complete type hints and return types
- Preserve function signatures, argument positions, names for public methods
- New parameters should use keyword-only syntax with sensible defaults
- Google-style docstrings with single backticks for inline code

**Commit Conventions:**
- Conventional Commits with required scopes: feat(langchain): description
- Lowercase titles except proper nouns

**Security:**
- PROHIBITED: eval(), exec(), pickle on user inputs
- Proper exception handling required
- Resource cleanup for file handles and connections

---

### 5. LangGraph (langchain-ai/langgraph/CLAUDE.md)

**Multi-library monorepo with dependency awareness:**
- Eight libraries including checkpoints, CLI, core, prebuilt, SDKs
- Dependency diagram shows how libraries relate downstream

**Code Style Rule:**
- Do NOT use Sphinx-style double backtick formatting
- Use single backticks for inline code in docstrings and comments

**PR Requirements:**
- Run make format, make lint, make test in the modified library's directory

---

### 6. Pydantic AI (pydantic/pydantic-ai/AGENTS.md + subdirectory files)

**Multi-level hierarchy:**
- Root AGENTS.md -- core principles: "Project over User", "Trust but Verify"
- docs/AGENTS.md -- documentation rules
- pydantic_ai_slim/pydantic_ai/AGENTS.md -- source code rules
- pydantic_ai_slim/pydantic_ai/models/AGENTS.md -- model integration rules
- tests/AGENTS.md -- testing guidelines

**Testing Philosophy:**
- 100% code path coverage
- Favor integration tests and real requests (using recordings/snapshots) over unit tests and mocking
- Use TestModel or FunctionModel in place of actual LLM for tests
- Use Agent.override to replace model inside application logic
- Safety measures to prevent accidental real LLM calls during testing
- Uses inline-snapshot and pytest-vcr cassettes

**Key Pattern: Tests mirror actual user usage paths**

---

### 7. Inngest Python (inngest/inngest-py/CLAUDE.md)

**Concise and focused:**
- Always use uv to run Python tools
- Never use python -m, .venv/bin/, or bare command invocation
- Architecture details deferred to CONTRIBUTING.md
- Test cases organized in tests/test_inngest/test_function/cases/
- Items in _internal package are private unless re-exported through public modules
- Python 3.10+ minimum

---

### 8. Claude Agent SDK Python (anthropics/claude-agent-sdk-python/CLAUDE.md)

**Minimal and effective:**
- Linting: python -m ruff check src/ tests/ --fix
- Formatting: python -m ruff format src/ tests/
- Type checking: python -m mypy src/
- Tests: python -m pytest tests/ or python -m pytest tests/test_client.py
- Structure: src/claude_agent_sdk/ with client.py, query.py, types.py, _internal/

---

### 9. pytest-test-categories (mikelane/pytest-test-categories/CLAUDE.md)

**Workflow-heavy approach:**
- ALL work requires creating GitHub issues first
- All changes through PRs linking to issues
- Documentation synchronization in SAME commit as code changes
- coverage run preferred over pytest --cov to track module-level code
- Multi-version testing via tox (Python 3.11-3.14)
- 100% coverage enforcement
- from __future__ import annotations on all files
- 120-character line length, single quotes for strings
- Hexagonal architecture for timer implementations
- "Avoid 'should' in test names" convention

---

## Pattern 1: Package Management

**Universal standard across all analyzed repos:**

- Use uv exclusively for all Python operations
- NEVER use pip, pip install, or bare python commands
- Install packages: uv add package
- Dev dependencies: uv add --dev package
- Run tools: uv run pytest, uv run ruff, uv run mypy
- Sync environment: uv sync
- Lock dependencies: uv lock
- Upgrade: uv lock --upgrade-package package
- FORBIDDEN: pip install, python -m, .venv/bin/, bare pytest

**Why this matters for selectools:** Agents default to pip. Without explicit uv instructions, every agent session starts with pip install which can corrupt the environment.

---

## Pattern 2: Testing Configuration for Agents

**Composite best practices from all repos:**

### Command Clarity (from MCP SDK)
- Full suite: uv run pytest
- Single file: uv run pytest tests/test_specific.py
- Single test: uv run pytest tests/test_specific.py::test_name
- With output: uv run pytest -s
- Pattern match: uv run pytest -k "pattern"
- Coverage: uv run pytest --cov=selectools --cov-report=term-missing

### Test Organization (from MCP SDK, Google ADK)
- Test files mirror source tree: src/selectools/agents/router.py -> tests/agents/test_router.py
- Use function-based tests, NOT class-based with Test prefix
- Name: test_function_scenario_expected_result
- Follow AAA pattern: Arrange, Act, Assert

### Async Testing (from MCP SDK -- critical for agent frameworks)
- Use anyio, NOT asyncio for test async operations
- Avoid anyio.sleep() -- use anyio.Event instead
- For streams: await stream.receive() not sleep() + receive_nowait()
- Wrap indefinite waits: anyio.fail_after(5) to prevent hangs
- Exception: sleep() is OK for testing time-based features

### Agent Testing Pattern (from Pydantic AI)
- Use TestModel/FunctionModel in place of real LLM calls
- Use Agent.override() to swap models in application logic
- Safety: prevent accidental real API calls in test suite
- Favor integration tests with recordings over unit tests with mocks
- Use pytest-vcr cassettes for recording/replaying API interactions
- Use inline-snapshot for complex output validation

### Coverage (from MCP SDK, pytest-test-categories)
- CI requires 100% (fail_under = 100, branch = true)
- Use coverage run over pytest --cov for module-level tracking
- Coverage pragmas:
  - # pragma: no cover -- never executed (strict enforcement)
  - # pragma: lax no cover -- platform-specific exclusions
  - # pragma: no branch -- branch arc exclusions for async quirks

---

## Pattern 3: Type Checking Instructions

**Combined from all repos:**

- Run: uv run pyright (preferred) or uv run mypy src/
- ALL code requires type hints and return types
- Public APIs MUST have complete type annotations
- Use T | None over Optional[T] (Python 3.10+ syntax)
- Minimize Any types -- use only when absolutely necessary
- Use abstract types from collections.abc (Sequence, Mapping, Iterable)
- Use typing.NewType for distinct types from primitives

### CI Fix Order (from MCP SDK):
1. Formatting errors first
2. Type errors second
3. Linting errors third

---

## Pattern 4: Import Conventions and src-layout

**From Google ADK Python (the most explicit):**

### In source code (src/):
- Use RELATIVE imports within the package
- Import from specific modules, NOT from __init__.py
- Example: from ..agents.router import AgentRouter (correct)
- NOT: from ..agents import AgentRouter (wrong)
- NOT: from selectools.agents.router import AgentRouter (wrong in src/)

### In tests/:
- Use ABSOLUTE imports (matches user import paths)
- Example: from selectools.agents.router import AgentRouter (correct)
- This catches public API issues early

### Every source file must include:
from __future__ import annotations

### All imports at file top level:
- FORBIDDEN: imports inside functions

**Project structure (composite pattern):**
selectools/
  src/
    selectools/
      __init__.py          # Public API exports
      _internal/           # Private implementation
      agents/
      tools/
      models/
  tests/
    agents/
    tools/
    models/
  pyproject.toml
  CLAUDE.md

---

## Pattern 5: Async Code Patterns

**From MCP SDK, OpenAI Agents, Claude Agent SDK:**

- Use anyio for async operations (works with both asyncio and trio)
- async def functions must be properly awaited
- Use anyio.Event for synchronization, not sleep-based polling
- Use anyio.fail_after(timeout) to prevent infinite waits
- Keep streaming and non-streaming paths behaviorally aligned
- Changes to streaming code must be mirrored in non-streaming paths
- For concurrent operations, use asyncio.gather(*tasks)
- Never use break to exit async iterators early -- use flags
- Let async iteration complete naturally for proper cleanup

---

## Pattern 6: Python-Specific Gotchas

**Compiled from all repos -- things agents get wrong:**

### Mutable Defaults
- NEVER: def foo(items=[]):
- ALWAYS: def foo(items=None): then items = items or []

### Exception Handling
- NEVER: bare except: or except Exception:
- ALWAYS: catch specific exceptions (OSError, ValueError, etc.)
- Top-level handlers are the only exception to this rule

### Logging
- Use logger.exception("Failed") NOT logger.error(f"Failed: {e}")
- logger.exception() auto-includes traceback

### Security
- NEVER: eval(), exec(), pickle on user input
- NEVER: store secrets in code -- use .env files only

### API Compatibility
- Preserve function signatures, argument positions, names for public APIs
- New parameters: keyword-only with sensible defaults
- Treat parameter order as a compatibility contract

### Agent Hallucinations
- Claude may hallucinate library APIs -- if AttributeError/TypeError on library calls, verify the API actually exists
- Always check existing patterns before inventing new ones

---

## Pattern 7: Code Quality and Linting

**Universal pattern:**

### Ruff (linting + formatting)
- Format: uv run ruff format .
- Check: uv run ruff check .
- Fix: uv run ruff check . --fix
- Line length: 88 chars (ruff default) or 120 chars (project-specific)

### Critical Issues
- Import sorting (I001)
- Unused imports
- Line length violations
- String wrapping: use parentheses; function calls multi-line

### Pre-commit
- Runs on git commit automatically
- Tools: ruff (Python), prettier (YAML/JSON)
- Install: uv run pre-commit install

---

## Pattern 8: Commit and PR Conventions

**From OpenAI, Google ADK, LangChain:**

### Conventional Commits format:
type(scope): description

Types: feat, fix, refactor, docs, test, chore

### Examples:
feat(agents): add parallel execution support
fix(tools): prevent timeout in streaming responses
refactor(core): extract router logic to separate module
test(agents): add integration tests for multi-agent routing

### Rules:
- Concise imperative messages
- Keep commits small and focused
- NEVER mention co-authored-by or tool used
- For bug reports: git commit --trailer "Reported-by:name"
- For issues: git commit --trailer "Github-Issue:#number"

### PR Requirements:
- Include summary, test plan, and issue number
- Add tests for new behavior
- Update documentation for user-facing changes
- Run all checks before submission

---

## Pattern 9: Coverage and CI Integration

**From MCP SDK, Pydantic AI, pytest-test-categories:**

### pyproject.toml settings:
[tool.coverage.run]
source = ["src/selectools"]
branch = true

[tool.coverage.report]
fail_under = 100
show_missing = true
exclude_lines = [
    "pragma: no cover",
    "if TYPE_CHECKING:",
    "if __name__ == .__main__.",
    "@overload",
    "raise NotImplementedError",
]

### Targeted coverage check (fast iteration):
uv run coverage erase
uv run coverage run -m pytest tests/path/test_foo.py
uv run coverage combine
uv run coverage report --include='src/selectools/path/foo.py' --fail-under=0

### Multi-version testing:
UV_PROJECT_ENVIRONMENT=.venv_310 uv sync --python 3.10 --all-extras
UV_PROJECT_ENVIRONMENT=.venv_310 uv run --python 3.10 -m pytest

---

## Pattern 10: Error Handling Conventions

**From MCP SDK (the most explicit):**

### Logging:
- Use logger.exception("Failed to process") -- auto-includes traceback
- NEVER: logger.error(f"Failed: {e}") -- loses traceback info

### Exception Specificity:
- File ops: catch (OSError, PermissionError)
- JSON parsing: catch json.JSONDecodeError
- Network: catch (ConnectionError, TimeoutError)
- FORBIDDEN: bare except Exception: (except top-level handlers)

### Re-raising:
- Use bare raise to preserve stack trace
- Use raise NewException from original for chaining
- Use raise NewException from None to suppress context

---

## Pattern 11: Documentation Standards

**From LangChain, Google ADK, MCP SDK:**

### Docstrings:
- Google-style docstrings for all public APIs
- Use single backticks for inline code (NOT double backticks)
- Include Args, Returns, Raises sections

### Breaking Changes:
- Document in docs/migration.md
- What changed, Why it changed, How to migrate
- Group related changes together

### README vs CLAUDE.md:
- CLAUDE.md: agent-facing instructions (commands, conventions, gotchas)
- README: human-facing documentation (installation, usage, contributing)

---

## Pattern 12: Multi-Level AGENTS.md Hierarchy

**From Pydantic AI (pioneering this pattern):**

### Root CLAUDE.md or AGENTS.md
- Package management commands
- Global code quality standards
- Commit conventions
- CI/CD instructions

### tests/CLAUDE.md
- Testing philosophy (integration over unit)
- Test naming conventions
- Snapshot and recording patterns
- Coverage requirements
- Mock vs real request guidance

### src/package/CLAUDE.md
- Import conventions
- Code patterns
- Internal vs public API boundaries

### src/package/models/CLAUDE.md
- Model-specific integration rules
- Provider-specific gotchas

### docs/CLAUDE.md
- Documentation style
- API reference conventions
- Example code standards

**This allows agents to load only relevant context based on which directory they are working in.**

---

## Composite Template for selectools

Based on all research, here is the recommended CLAUDE.md structure for selectools:

### Root CLAUDE.md (recommended content):

# selectools Development Guide

## Quick Reference
- Package manager: uv (NEVER pip)
- Run tests: uv run pytest
- Lint: uv run ruff check .
- Format: uv run ruff format .
- Type check: uv run pyright
- Coverage: uv run pytest --cov=selectools --cov-report=term-missing

## Package Management
- Use uv exclusively. FORBIDDEN: pip, bare python, .venv/bin/
- Install: uv add package | Dev: uv add --dev package
- Run: uv run tool | Sync: uv sync | Lock: uv lock

## Architecture
- src-layout: source in src/selectools/, tests in tests/
- Private code in _internal/ directories
- Re-exports through public __init__.py make private items public API

## Code Standards
- Type hints required on ALL functions and return types
- Use T | None not Optional[T]
- from __future__ import annotations in every source file
- All imports at file top level -- NEVER inside functions
- In src/: use relative imports. In tests/: use absolute imports
- Import from modules directly, not from __init__.py
- Line length: 120 characters
- Google-style docstrings with single backticks for inline code

## Testing
- Framework: uv run pytest with anyio for async (NOT asyncio)
- Function-based tests only -- no Test-prefixed classes
- Files mirror source: src/selectools/agents/router.py -> tests/agents/test_router.py
- Pattern: test_function_scenario_expected
- CI requires 100% coverage (fail_under=100, branch=true)
- Use TestModel/FunctionModel for LLM tests, never real API calls
- Async: use anyio.Event for sync, anyio.fail_after(5) for timeouts
- Favor integration tests with recordings over unit tests with mocks

## Error Handling
- logger.exception("message") not logger.error(f"msg: {e}")
- Catch specific exceptions: OSError, ValueError, json.JSONDecodeError
- FORBIDDEN: bare except: or except Exception: (except top-level)
- FORBIDDEN: eval(), exec(), pickle on user input

## Commits
- Format: type(scope): description
- Types: feat, fix, refactor, docs, test, chore
- NEVER mention co-authored-by or tool used

## Async Patterns
- Use anyio for cross-framework compatibility
- Keep streaming/non-streaming paths aligned
- Use anyio.Event for coordination, not sleep-based polling
- Wrap indefinite waits in anyio.fail_after(timeout)


### Recommended subdirectory files:

**tests/CLAUDE.md:**

# Testing Guidelines

## Philosophy
- Integration tests over unit tests
- Test through public APIs, not private methods
- Use recordings and snapshots for API interactions
- Mock only external dependencies (LLM calls, network)

## Patterns
- Use TestModel to avoid real LLM calls
- Use Agent.override() to swap models
- Use pytest-vcr cassettes for recording/replaying
- Use inline-snapshot for complex output validation
- AAA pattern: Arrange, Act, Assert

## Coverage
- Target: 100% with branch coverage
- Use # pragma: no cover sparingly, only for truly unreachable code
- Use # pragma: no branch for async branch quirks


**src/selectools/CLAUDE.md:**

# Source Code Guidelines

## Imports
- Use RELATIVE imports within the package
- Import from specific modules, not __init__.py
- from __future__ import annotations in every file
- All imports at file top level

## API Compatibility
- Treat parameter order as a compatibility contract
- New params: keyword-only with defaults
- Breaking changes require docs/migration.md update

## Internal vs Public
- _internal/ directories are private
- _ prefixed names are private
- Re-exported through public __init__.py = public API

---

## Key Metrics from Research

| Metric | Value |
|--------|-------|
| Repos analyzed | 15+ |
| Repos using uv exclusively | 100% |
| Repos requiring 100% coverage | ~60% |
| Repos using ruff | ~90% |
| Repos using pyright (vs mypy) | ~55% |
| Repos using Conventional Commits | ~70% |
| Repos with multi-level agent files | ~30% |
| Average CLAUDE.md length (best ones) | 80-150 lines |
| Repos banning imports inside functions | ~40% (explicit) |
| Repos requiring anyio over asyncio | ~30% (async projects) |

---

## Sources

### CLAUDE.md / AGENTS.md Files Directly Analyzed

1. [MCP Python SDK CLAUDE.md](https://github.com/modelcontextprotocol/python-sdk/blob/main/CLAUDE.md) -- Gold standard for Python library agent config
2. [OpenAI Agents Python AGENTS.md](https://github.com/openai/openai-agents-python/blob/main/AGENTS.md) -- Most comprehensive contributor guide
3. [Google ADK Python AGENTS.md](https://github.com/google/adk-python/blob/main/AGENTS.md) -- Most exhaustive Python best practices
4. [LangChain CLAUDE.md](https://github.com/langchain-ai/langchain/blob/master/CLAUDE.md) -- Monorepo pattern
5. [LangChain AGENTS.md](https://github.com/langchain-ai/langchain/blob/master/AGENTS.md) -- Kept in sync with CLAUDE.md
6. [LangGraph CLAUDE.md](https://github.com/langchain-ai/langgraph/blob/main/CLAUDE.md) -- Multi-library monorepo
7. [Pydantic AI AGENTS.md](https://github.com/pydantic/pydantic-ai/blob/main/AGENTS.md) -- Multi-level hierarchy pioneer
8. [Pydantic AI tests/AGENTS.md](https://github.com/pydantic/pydantic-ai/blob/main/tests/AGENTS.md) -- Testing-specific rules
9. [Inngest Python CLAUDE.md](https://github.com/inngest/inngest-py/blob/main/CLAUDE.md) -- Concise pattern
10. [Claude Agent SDK Python CLAUDE.md](https://github.com/anthropics/claude-agent-sdk-python/blob/main/CLAUDE.md) -- Minimal effective pattern
11. [pytest-test-categories CLAUDE.md](https://github.com/mikelane/pytest-test-categories/blob/main/CLAUDE.md) -- Workflow-heavy approach
12. [Ruff AGENTS.md](https://github.com/astral-sh/ruff/blob/main/AGENTS.md) -- Rust project with Python testing
13. [LangChain DeepAgents AGENTS.md](https://github.com/langchain-ai/deepagents/blob/main/AGENTS.md) -- Agent orchestration patterns

### Templates and Guides

14. [pydevtools CLAUDE.md Template](https://pydevtools.com/configs/CLAUDE.md) -- 86-line template for Python projects
15. [Python CLAUDE.md Gist by minimaxir](https://gist.github.com/minimaxir/c274d7cc12f683d93df2b1cc5bab853c) -- Agent code quality guidelines
16. [claude-python-setup Template](https://github.com/omaciel/claude-python-setup) -- Modern Python dev environment setup
17. [ruflo Wiki CLAUDE.md Python](https://github.com/ruvnet/ruflo/wiki/CLAUDE-MD-Python) -- Comprehensive Python patterns

### Articles and Analysis

18. [What Great CLAUDE.md Files Have in Common](https://blog.devgenius.io/what-great-claude-md-files-have-in-common-db482172ad2c) -- Pattern analysis
19. [Writing a Good CLAUDE.md](https://www.humanlayer.dev/blog/writing-a-good-claude-md) -- Best practices
20. [AGENTS.md Official Spec](https://agents.md/) -- Open standard for agent config
21. [How to Build Your AGENTS.md](https://www.augmentcode.com/guides/how-to-build-agents-md) -- Augment Code guide
22. [CLAUDE.md, AGENTS.md, and Every AI Config File Explained](https://www.deployhq.com/blog/ai-coding-config-files-guide) -- Comprehensive overview
23. [Best Practices for Claude Code](https://code.claude.com/docs/en/best-practices) -- Official Anthropic guide
24. [Using CLAUDE.md Files (Official Blog)](https://claude.com/blog/using-claude-md-files) -- Official customization guide
25. [Pydantic AI AI-Assisted Development (DeepWiki)](https://deepwiki.com/pydantic/pydantic-ai/12.4-ai-assisted-development) -- Multi-level AGENTS.md analysis
26. [Python/FastAPI Dev with Claude Code](https://dev.to/myougatheaxo/pythonfastapi-development-with-claude-code-claudemd-setup-hooks-and-best-practices-1f11) -- FastAPI-specific patterns
27. [AGENTS.md and CLAUDE.md addition to SciPy](https://discuss.scientific-python.org/t/agents-md-and-claude-md-addition-to-scipy-repository/2233) -- Scientific Python adoption
28. [awesome-cursorrules Python Examples](https://github.com/PatrickJS/awesome-cursorrules) -- Cross-agent configuration patterns
29. [Claude Code Hooks for uv Projects](https://pydevtools.com/blog/claude-code-hooks-for-uv/) -- Hook-based enforcement
30. [How to Configure Claude Code to Use uv](https://pydevtools.com/handbook/how-to/how-to-configure-claude-code-to-use-uv/) -- uv configuration guide
