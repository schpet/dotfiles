#!/bin/bash

input=$(cat)

# Extract session ID, cwd, and model
session_id=$(echo "$input" | jq -r '.session_id')
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')


# Display directory using fish's prompt_pwd for nice formatting
display_dir=$(fish -c "set -g fish_prompt_pwd_dir_length 3; prompt_pwd --dir-length=3 --full-length-dirs=2 '$cwd'" 2>/dev/null)
[ -z "$display_dir" ] && display_dir="${cwd/#$HOME/~}"

# Hostname
hostname_short=$(hostname -s)

# Session ID (first 8 chars)
session_short="${session_id:0:8}"

# Check if we're in a jj repo
jj_info=""
if (cd "$cwd" && jj --ignore-working-copy root > /dev/null 2>&1); then
    jj_output=$(cd "$cwd" && jj --ignore-working-copy log --no-graph -r "@" -T 'change_id.shortest() ++ "\n" ++ description.first_line().substr(0, 50)' 2>/dev/null)
    change_id=$(echo "$jj_output" | head -n1)
    desc=$(echo "$jj_output" | tail -n +2)
    if [ -n "$change_id" ]; then
        jj_info=" $(printf '\033[1m\033[38;5;5m') $(printf '\033[0m')$change_id"
        if [ -n "$desc" ]; then
            jj_info="$jj_info $(printf '\033[90m')$desc$(printf '\033[0m')"
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

# Output: hostname + directory + model ✴ + jj/git info
# Colors: yellow for hostname, cyan for directory, green for model and ✴, jj has its own colors, magenta for git
printf "$(printf '\033[33m')%s$(printf '\033[0m') $(printf '\033[36m')%s$(printf '\033[0m') $(printf '\033[32m')%s$(printf '\033[0m') $(printf '\033[32m')✻$(printf '\033[0m')%s%s" "$hostname_short" "$display_dir" "$model" "$jj_info" "$git_info"
