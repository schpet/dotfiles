#!/bin/bash
HOOK_NAME="${1:-unknown}"
mkdir -p /tmp/debug-session-ids
cat >> /tmp/debug-session-ids/logfile <<EOF
---debug--- [$HOOK_NAME] $(date '+%Y-%m-%d %H:%M:%S')
$(cat)
---
EOF
