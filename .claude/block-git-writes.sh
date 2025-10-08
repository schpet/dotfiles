#!/bin/bash
if jq -e '.tool_input.command | test("git (add|commit|push|rebase|merge|reset|checkout|switch|stash|tag|branch -[dD])")' > /dev/null; then
  jo continue=false stopReason="Git write commands are blocked."
else
  jo continue=true
fi
