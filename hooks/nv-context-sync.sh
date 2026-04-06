#!/usr/bin/env bash
# nv-context Continuous Sync — Pre-commit hook
# Detects when code changes make agent configs stale
# Install: cp this to .git/hooks/pre-commit or add to .pre-commit-config.yaml

set -euo pipefail

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Config files to check
AGENTS_MD="AGENTS.md"
CLAUDE_MD="CLAUDE.md"

# Get staged files
STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACMR)

if [ -z "$STAGED_FILES" ]; then
    exit 0
fi

WARNINGS=0

# ─── Check 1: Package manager changes (commands may be stale) ───
PACKAGE_FILES="package.json pyproject.toml Cargo.toml go.mod Gemfile pom.xml build.gradle Makefile justfile"
for pf in $PACKAGE_FILES; do
    if echo "$STAGED_FILES" | grep -q "^${pf}$"; then
        if [ -f "$AGENTS_MD" ]; then
            echo -e "${YELLOW}[nv-context] ${pf} changed — verify commands in ${AGENTS_MD} are still correct${NC}"
            WARNINGS=$((WARNINGS + 1))
        fi
    fi
done

# ─── Check 2: CI config changes (test/build commands may be stale) ───
if echo "$STAGED_FILES" | grep -qE '\.github/workflows/|\.gitlab-ci\.yml|Jenkinsfile|\.circleci/'; then
    if [ -f "$AGENTS_MD" ]; then
        echo -e "${YELLOW}[nv-context] CI config changed — verify commands in ${AGENTS_MD} match CI${NC}"
        WARNINGS=$((WARNINGS + 1))
    fi
fi

# ─── Check 3: Lint/format config changes (hooks may need update) ───
if echo "$STAGED_FILES" | grep -qE '\.eslintrc|biome\.json|\.prettierrc|ruff\.toml|\.flake8|pyproject\.toml'; then
    echo -e "${YELLOW}[nv-context] Lint/format config changed — verify hooks in .claude/settings.local.json${NC}"
    WARNINGS=$((WARNINGS + 1))
fi

# ─── Check 4: New directories created (may need scoped rules) ───
NEW_DIRS=$(echo "$STAGED_FILES" | sed 's|/[^/]*$||' | sort -u)
for dir in $NEW_DIRS; do
    if [ -n "$dir" ] && [ ! -f "${dir}/CLAUDE.md" ]; then
        # Check if this is a significant new directory (not just a file in existing dir)
        if [ $(echo "$STAGED_FILES" | grep "^${dir}/" | wc -l) -ge 3 ]; then
            echo -e "${YELLOW}[nv-context] New area '${dir}/' has 3+ files but no scoped CLAUDE.md${NC}"
            WARNINGS=$((WARNINGS + 1))
        fi
    fi
done

# ─── Check 5: Agent config staleness (days since last update) ───
for cfg in "$AGENTS_MD" "$CLAUDE_MD"; do
    if [ -f "$cfg" ]; then
        LAST_MODIFIED=$(git log -1 --format="%ct" -- "$cfg" 2>/dev/null || echo "0")
        NOW=$(date +%s)
        DAYS_AGO=$(( (NOW - LAST_MODIFIED) / 86400 ))
        if [ "$DAYS_AGO" -gt 14 ]; then
            echo -e "${YELLOW}[nv-context] ${cfg} last updated ${DAYS_AGO} days ago — consider reviewing${NC}"
            WARNINGS=$((WARNINGS + 1))
        fi
    fi
done

# ─── Check 6: Negative instruction scan ───
for cfg in "$AGENTS_MD" "$CLAUDE_MD"; do
    if [ -f "$cfg" ]; then
        # Look for soft negatives (not NEVER which is fine)
        NEGATIVES=$(grep -inE "^[^#]*\b(don't|do not|avoid|should not)\b" "$cfg" 2>/dev/null | grep -iv "NEVER" | head -3)
        if [ -n "$NEGATIVES" ]; then
            echo -e "${YELLOW}[nv-context] Soft negative instructions found in ${cfg} (these backfire):${NC}"
            echo "$NEGATIVES" | while read -r line; do
                echo -e "  ${RED}→ ${line}${NC}"
            done
            echo -e "  ${GREEN}Tip: Rewrite as 'MUST use Y' instead of 'don't use X'${NC}"
            WARNINGS=$((WARNINGS + 1))
        fi
    fi
done

# ─── Check 7: HANDOFF.md staleness ───
if [ -f "HANDOFF.md" ]; then
    HANDOFF_DATE=$(grep -m1 "Last Updated" HANDOFF.md 2>/dev/null | sed 's/.*Last Updated//' | xargs)
    if [ -z "$HANDOFF_DATE" ] || echo "$HANDOFF_DATE" | grep -q "\["; then
        echo -e "${YELLOW}[nv-context] HANDOFF.md has never been filled in — update it before ending sessions${NC}"
        WARNINGS=$((WARNINGS + 1))
    fi
fi

# ─── Summary ───
if [ "$WARNINGS" -gt 0 ]; then
    echo ""
    echo -e "${YELLOW}[nv-context] ${WARNINGS} context sync warning(s). Review above and run /nv-context to refresh.${NC}"
    echo -e "${GREEN}Tip: These are warnings, not blockers. Commit proceeds normally.${NC}"
    echo ""
fi

exit 0
