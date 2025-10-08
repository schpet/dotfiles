#!/bin/bash

input=$(cat)

# Extract session ID, cwd, model, and transcript path
session_id=$(echo "$input" | jq -r '.session_id')
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')


# Display directory with ~ for home
display_dir="${cwd/#$HOME/~}"

# Session ID (first 8 chars)
session_short="${session_id:0:8}"

# Check if we're in a jj repo
jj_info=""
if (cd "$cwd" && jj --ignore-working-copy root > /dev/null 2>&1); then
    change_id=$(cd "$cwd" && jj log --color=always --no-graph -r "@" -T "change_id.shortest()" 2>/dev/null)
    if [ -n "$change_id" ]; then
        jj_info=" $(printf '\033[1m\033[38;5;5m') $(printf '\033[0m')$change_id"
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

# Transcript path display
transcript_display=""
if [ -n "$transcript_path" ]; then
    transcript_display=" $(printf '\033[90m')${transcript_path/#$HOME/~}$(printf '\033[0m')"
fi

# Output: directory + jj/git info + ✴ model + session + transcript
# Colors: cyan for directory, jj has its own colors, magenta for git, green for ✴ and model, yellow for session, gray for transcript
printf "$(printf '\033[36m')%s$(printf '\033[0m')%s%s $(printf '\033[32m')✻$(printf '\033[0m') $(printf '\033[32m')%s$(printf '\033[0m') $(printf '\033[33m')[%s]$(printf '\033[0m')%s" "$display_dir" "$jj_info" "$git_info" "$model" "$session_short" "$transcript_display"
