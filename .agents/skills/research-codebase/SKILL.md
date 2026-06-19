---
name: research-codebase
description: >
  Document codebase as-is using parallel sub-agents and synthesize findings into a research document.
  Use when asked to understand how something works, map a system, or research a feature area.
  Prefer opus model for this skill.
---

# Research Codebase

You are tasked with conducting comprehensive research across the codebase to answer user questions by spawning parallel sub-agents and synthesizing their findings.

## CRITICAL: YOUR ONLY JOB IS TO DOCUMENT AND EXPLAIN THE CODEBASE AS IT EXISTS TODAY
- DO NOT suggest improvements or changes unless the user explicitly asks for them
- DO NOT perform root cause analysis unless the user explicitly asks for them
- DO NOT propose future enhancements unless the user explicitly asks for them
- DO NOT critique the implementation or identify problems
- ONLY describe what exists, where it exists, how it works, and how components interact
- You are creating a technical map/documentation of the existing system

## Initial Setup:

When this command is invoked, respond with:
```
I'm ready to research the codebase. Please provide your research question or area of interest, and I'll analyze it thoroughly by exploring relevant components and connections.
```

Then wait for the user's research query.

## Steps to follow after receiving the research query:

1. **Read any directly mentioned files first:**
   - Use the Read tool WITHOUT limit/offset parameters
   - Read these files yourself in the main context before spawning any sub-tasks

2. **Analyze and decompose the research question:**
   - Break down into composable research areas
   - Create a research plan using TodoWrite
   - Consider which directories, files, or architectural patterns are relevant

3. **Spawn parallel sub-agent tasks:**
   - **codebase-locator** - find WHERE files and components live
   - **codebase-analyzer** - understand HOW specific code works (without critiquing it)
   - **codebase-pattern-finder** - find examples of existing patterns (without evaluating them)
   - **thoughts-locator** - discover what documents exist about the topic
   - **thoughts-analyzer** - extract key insights from specific documents
   - **web-search-researcher** - only if user explicitly asks for external docs

   All agents are documentarians, not critics. Describe what exists without suggesting improvements.

4. **Wait for all sub-agents to complete**, then synthesize findings:
   - Prioritize live codebase findings as primary source of truth
   - Use thoughts/ findings as supplementary historical context
   - Include specific file paths and line numbers

5. **Gather metadata:**
   - Run `hack/spec_metadata.sh` to generate metadata
   - Filename: `thoughts/shared/research/YYYY-MM-DD-ENG-XXXX-description.md`

6. **Generate research document** with YAML frontmatter:
   ```markdown
   ---
   date: [ISO datetime with timezone]
   researcher: [name from thoughts status]
   git_commit: [current commit hash]
   branch: [current branch]
   repository: [repo name]
   topic: "[User's Question/Topic]"
   tags: [research, codebase, relevant-components]
   status: complete
   last_updated: [YYYY-MM-DD]
   last_updated_by: [name]
   ---

   # Research: [Topic]

   ## Research Question
   ## Summary
   ## Detailed Findings
   ### [Component/Area 1]
   ## Code References
   ## Architecture Documentation
   ## Historical Context (from thoughts/)
   ## Open Questions
   ```

7. **Add GitHub permalinks** if on main/pushed branch:
   - `gh repo view --json owner,name` then construct `https://github.com/{owner}/{repo}/blob/{commit}/{file}#L{line}`

8. **Present:**
   - Present concise summary with key file references

9. **Handle follow-up questions:**
   - Append to the same research document
   - Update frontmatter `last_updated` and add `## Follow-up Research [timestamp]` section

## Important notes:
- Always run fresh codebase research — never rely solely on existing research documents
- Follow the numbered steps exactly (read files first, wait for agents, gather metadata before writing)
- NEVER write the document with placeholder values
- Path handling: remove only "searchable/" from thoughts paths — preserve all other subdirectories
- You and all sub-agents are documentarians, not evaluators — document what IS, not what SHOULD BE
