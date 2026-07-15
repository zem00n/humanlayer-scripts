---
name: commit
description: >
  Create git commits with user approval and no Claude attribution.
  Use when user asks to commit changes, create a commit, or save work to git.
---

# Commit Changes

You are tasked with creating git commits for the changes made during this session.

## Commit Message Style: GitHub Copilot

Write commit messages in the style GitHub Copilot uses when generating commit suggestions:

- **Subject line**: short (50–72 chars), natural language, imperative mood, **no** conventional-commit type prefix (`feat:`, `fix:`, etc.)
- **Body** (optional): 1–3 sentences or a brief bullet list explaining *what* changed and *why*, wrapped at 72 chars
- Tone: clear, direct, like a competent engineer summarising their own work

**Good examples:**
```
Add XCom viewer screen to task instances
```
```
Add clipboard support for copying XCom keys and values

Users can now press Tab to toggle between key and value selection,
then c to copy the selected text to the system clipboard.
```
```
Swap hand-rolled JSON highlighter for Chroma

- Removes ~200 lines of regex-based colorizer
- Adds chroma/v2 with monokai theme and terminal16m formatter
- Automatically detects JSON, XML, and HTML content
```

**Bad examples (avoid):**
```
feat: add xcom viewer         ← no conventional-commit prefix
fix(EMS-123): ...             ← no Jira refs unless codebase requires them
Added the XCom viewer screen  ← past tense
Misc changes                  ← vague
```

## Process:

1. **Think about what changed:**
   - Review the conversation history and understand what was accomplished
   - Run `git status` to see current changes
   - Run `git diff` to understand the modifications
   - Consider whether changes should be one commit or multiple logical commits

2. **Plan your commit(s):**
   - Identify which files belong together
   - Draft clear, descriptive commit messages in Copilot style
   - Focus on what changed and why, not implementation minutiae

3. **Execute immediately — no approval step:**
   - Use `git add` with specific files (never use `-A` or `.`)
   - Create commits with your planned messages
   - Show the result with `git log --oneline -n [number]`

## Important:
- **NEVER add co-author information or Claude attribution**
- Commits should be authored solely by the user
- Do not include any "Generated with Claude" messages
- Do not add "Co-Authored-By" lines
- Write commit messages as if the user wrote them

## Remember:
- You have the full context of what was done in this session
- Group related changes together
- Keep commits focused and atomic when possible
- The user trusts your judgment — they asked you to commit
