function jjw
    # Get jj root
    set jj_root (jj root 2>/dev/null)
    if test $status -ne 0
        echo "Error: Not in a jj repository"
        return 1
    end

    # Get workspace name from argument or select interactively
    if test (count $argv) -eq 0
        # List workspaces and extract just the names
        set workspaces (jj workspace list | string match -r '^[^:]+' | string trim)

        if test (count $workspaces) -eq 0
            echo "No workspaces found"
            return 1
        end

        # Try to use fzf if available, otherwise use the first workspace
        if command -v fzf >/dev/null
            set workspace_name (printf '%s\n' $workspaces | fzf --prompt="Select workspace: ")
            if test -z "$workspace_name"
                echo "No workspace selected"
                return 1
            end
        else
            echo "Available workspaces:"
            for ws in $workspaces
                echo "  $ws"
            end
            echo "Usage: jjw <workspace_name>"
            return 1
        end
    else
        set workspace_name $argv[1]
    end

    # Check if workspace exists in work/ directory
    set workspace_path "$jj_root/work/$workspace_name"

    if test -d $workspace_path
        cd $workspace_path
        echo "Changed to workspace: $workspace_name"
    else
        echo "Error: Workspace directory not found: $workspace_path"
        return 1
    end
end
