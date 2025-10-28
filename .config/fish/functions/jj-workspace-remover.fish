function jj-workspace-remover
    # Get jj root
    set jj_root (jj root 2>/dev/null)
    if test $status -ne 0
        echo "Error: Not in a jj repository"
        return 1
    end

    # If we're in a workspace (path contains /work/), get the actual repo root
    if string match -q "*/work/*" $jj_root
        set jj_root (string replace -r '/work/.*' '' $jj_root)
    end

    # List workspaces and extract just the names, excluding 'default'
    set workspaces (jj workspace list | string match -r '^[^:]+' | string trim | grep -v '^default$')

    if test (count $workspaces) -eq 0
        echo "No removable workspaces found"
        return 1
    end

    # Select workspace to remove
    set workspace_name (printf '%s\n' $workspaces | fzf --prompt="Select workspace to remove: ")

    if test -z "$workspace_name"
        echo "No workspace selected"
        return 1
    end

    # Confirm deletion
    read -P "Remove workspace '$workspace_name'? [y/N] " -n 1 confirm
    echo

    if test "$confirm" != "y" -a "$confirm" != "Y"
        echo "Cancelled"
        return 0
    end

    # Forget the workspace
    jj workspace forget $workspace_name
    if test $status -ne 0
        echo "Error: Failed to forget workspace"
        return 1
    end

    # Delete the directory
    set workspace_path "$jj_root/work/$workspace_name"
    if test -d $workspace_path
        trash $workspace_path
        if test $status -eq 0
            echo "Removed workspace: $workspace_name"

            # Remove Claude Code project symlink if it exists
            set workspace_claude_dir ~/.claude/projects/-(string replace -a / - (string sub -s 2 $workspace_path))
            if test -L $workspace_claude_dir
                rm $workspace_claude_dir
                echo "Removed Claude Code project symlink"
            end
        else
            echo "Error: Failed to delete workspace directory"
            return 1
        end
    else
        echo "Warning: Workspace directory not found: $workspace_path"
    end
end
