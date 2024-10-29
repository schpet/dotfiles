#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Kill puma processes
# @raycast.mode fullOutput

# Find Puma processes
puma_pids=$(pgrep -f puma)

if [ -z "$puma_pids" ]; then
    echo "No Puma processes found."
    exit 0
fi

# Kill Puma processes
for pid in $puma_pids; do
    echo "Killing Puma process with PID: $pid"
    kill $pid
done

echo "All Puma processes have been terminated."
