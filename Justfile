# Select and install agent integrations globally
setup:
    #!/usr/bin/env bash
    set -e
    tools=$(gum choose --no-limit --header "Select integrations to install:" "claude" "github")
    for tool in $tools; do
        just setup-$tool
    done

# Link all skills and selected agents into ~/.claude/
setup-claude:
    #!/usr/bin/env bash
    set -e
    ROOT="$(pwd)"
    # Link all skills to ~/.claude/skills/
    mkdir -p "$HOME/.claude/skills"
    for dir in "$ROOT/.agents/skills"/*/; do
        ln -sfn "$dir" "$HOME/.claude/skills/$(basename "$dir")"
    done
    # Project-local symlink
    ln -sfn "$ROOT/.agents/skills" "$ROOT/.claude/skills"
    # Select agents interactively
    mkdir -p "$HOME/.claude/agents"
    agents=$(ls "$ROOT/.claude/agents/" | gum choose --no-limit --header "Select Claude agents to install:")
    for file in $agents; do
        ln -sfn "$ROOT/.claude/agents/$file" "$HOME/.claude/agents/$file"
    done
    echo "Claude Code setup complete"

# Link selected GitHub Copilot agents and prompts into ~/.github/
setup-github:
    #!/usr/bin/env bash
    set -e
    ROOT="$(pwd)"
    mkdir -p "$HOME/.github/agents"
    agents=$(ls "$ROOT/.github/agents/" | gum choose --no-limit --header "Select GitHub agents to install:")
    for file in $agents; do
        ln -sfn "$ROOT/.github/agents/$file" "$HOME/.github/agents/$file"
    done
    mkdir -p "$HOME/.github/prompts"
    prompts=$(ls "$ROOT/.github/prompts/" | gum choose --no-limit --header "Select GitHub prompts to install:")
    for file in $prompts; do
        ln -sfn "$ROOT/.github/prompts/$file" "$HOME/.github/prompts/$file"
    done
    echo "GitHub Copilot setup complete"
