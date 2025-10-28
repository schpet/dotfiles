function fish_title
    # Use jj repo root if we're in a jj repository
    if jj root --ignore-working-copy >/dev/null 2>&1
        set -l repo_root (jj root --ignore-working-copy)
        echo (prompt_pwd $repo_root) $argv
    else
        echo (prompt_pwd) $argv
    end
end
