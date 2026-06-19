---
name: iterate-plan
description: >
  Update an existing implementation plan based on user feedback with thorough research.
  Use when refining, adjusting scope, or adding phases to an existing plan file.
  Prefer opus model for this skill.
---

# Iterate Implementation Plan

You are tasked with updating existing implementation plans based on user feedback. You should be skeptical, thorough, and ensure changes are grounded in actual codebase reality.

## Initial Response

When this command is invoked:

1. **Parse the input to identify**:
   - Plan file path (e.g., `thoughts/shared/plans/2025-10-16-feature.md`)
   - Requested changes/feedback

2. **Handle different input scenarios**:

   **If NO plan file provided**:
   ```
   I'll help you iterate on an existing implementation plan.

   Which plan would you like to update? Please provide the path to the plan file.

   Tip: You can list recent plans with `ls -lt thoughts/shared/plans/ | head`
   ```

   **If plan file provided but NO feedback**:
   ```
   I've found the plan at [path]. What changes would you like to make?
   ```

   **If BOTH plan file AND feedback provided**: Proceed immediately.

## Process Steps

### Step 1: Read and Understand Current Plan

1. **Read the existing plan file COMPLETELY** (no limit/offset parameters)
2. **Understand the requested changes** and determine if codebase research is needed

### Step 2: Research If Needed

Only spawn research tasks if changes require new technical understanding:

- **codebase-locator** - To find relevant files
- **codebase-analyzer** - To understand implementation details
- **codebase-pattern-finder** - To find similar patterns
- **thoughts-locator** / **thoughts-analyzer** - For historical context

### Step 3: Present Understanding and Approach

Before making changes, confirm:

```
Based on your feedback, I understand you want to:
- [Change 1 with specific detail]
- [Change 2 with specific detail]

My research found:
- [Relevant code pattern or constraint]

I plan to update the plan by:
1. [Specific modification to make]

Does this align with your intent?
```

### Step 4: Update the Plan

1. **Make focused, precise edits** using the Edit tool — surgical changes, not rewrites
2. **Ensure consistency**: update "What We're NOT Doing", "Implementation Approach", and success criteria as needed
3. **Preserve quality standards**: specific file:line references, measurable criteria, `make` commands

### Step 5: Review

1. Present the changes made and ask if further adjustments are needed

## Important Guidelines

1. **Be Skeptical**: Don't blindly accept change requests; verify technical feasibility
2. **Be Surgical**: Precise edits only, preserve good content
3. **Be Interactive**: Confirm understanding before making changes
4. **No Open Questions**: Research or clarify before updating

## Success Criteria Format

Always maintain the two-category structure:
1. **Automated Verification**: `make test`, `npm run lint`, prefer `make` commands
2. **Manual Verification**: UI/UX, performance, edge cases
