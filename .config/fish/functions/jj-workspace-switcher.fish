function jj-workspace-switcher
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

    # Get workspace name from argument or select interactively
    if test (count $argv) -eq 0
        # List workspaces and extract just the names
        set workspaces (jj workspace list | string match -r '^[^:]+' | string trim)

        if test (count $workspaces) -eq 0
            echo "No workspaces found"
            return 1
        end

        # Add option to create new workspace
        set create_option "[Create new workspace]"
        set selection (printf '%s\n%s\n' $create_option $workspaces | fzf --prompt="Select workspace: ")

        if test -z "$selection"
            echo "No workspace selected"
            return 1
        end

        # Check if user wants to create a new workspace
        if test "$selection" = "$create_option"
            read -P "Enter new workspace name: " workspace_name
            if test -z "$workspace_name"
                echo "Error: Workspace name cannot be empty"
                return 1
            end

            # Create the workspace with full path
            set work_dir "$jj_root/work"
            set workspace_path "$work_dir/$workspace_name"

            # Ensure work directory exists
            mkdir -p $work_dir

            # Create the workspace directory and initialize it
            jj workspace add --name $workspace_name $workspace_path
            if test $status -ne 0
                echo "Error: Failed to create workspace"
                return 1
            end
            echo "Created new workspace: $workspace_name"
        else
            set workspace_name $selection
        end
    else
        set workspace_name $argv[1]
    end

    # Handle special 'default' workspace (at root)
    if test "$workspace_name" = "default"
        cd $jj_root
        echo "Changed to workspace: $workspace_name"
    else
        # Check if workspace exists in work/ directory
        set workspace_path "$jj_root/work/$workspace_name"

        if test -d $workspace_path
            cd $workspace_path
            echo "Changed to workspace: $workspace_name"

            # Create Claude Code project symlink if main project dir exists
            set main_claude_dir ~/.claude/projects/-(string replace -a / - (string sub -s 2 $jj_root))
            if test -d $main_claude_dir
                set workspace_claude_dir ~/.claude/projects/-(string replace -a / - (string sub -s 2 $workspace_path))
                if not test -e $workspace_claude_dir
                    ln -s $main_claude_dir $workspace_claude_dir
                    echo "Created Claude Code project symlink"
                end
            end
        else
            echo "Error: Workspace directory not found: $workspace_path"
            return 1
        end
    end
end
