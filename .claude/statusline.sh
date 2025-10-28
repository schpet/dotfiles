#!/bin/bash

input=$(cat)

# Extract session ID, cwd, and model
session_id=$(echo "$input" | jq -r '.session_id')
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')


# Display directory with ~ for home
display_dir="${cwd/#$HOME/~}"

# Session ID (first 8 chars)
session_short="${session_id:0:8}"

# Check if we're in a jj repo
jj_info=""
if (cd "$cwd" && jj --ignore-working-copy root > /dev/null 2>&1); then
    # Try to get the change ID for this session
    session_change=$(jjagent change-id "$session_id" 2>/dev/null)
    if [ -n "$session_change" ]; then
        # Get formatted summary with refs for the session's change ID
        change_info=$(cd "$cwd" && jj log --ignore-working-copy --color=always --no-graph -r "$session_change" -T "format_commit_summary_with_refs(self, bookmarks)" 2>/dev/null)
        if [ -n "$change_info" ]; then
            jj_info="$(printf '\033[1m\033[38;5;5m') $(printf '\033[0m')$change_info"
        fi
    fi
fi

# Git info (fallback if not a jj repo)
git_info=""
if [ -z "$jj_info" ] && git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        git_info=" on $(printf '\033[35m')$branch$(printf '\033[0m')"
    fi
fi

# Output: directory + model ✴ + jj/git info
# Colors: cyan for directory, green for model and ✴, jj has its own colors, magenta for git
printf "$(printf '\033[36m')%s$(printf '\033[0m') $(printf '\033[32m')%s$(printf '\033[0m') $(printf '\033[32m')✻$(printf '\033[0m')%s%s" "$display_dir" "$model" "$jj_info" "$git_info"
