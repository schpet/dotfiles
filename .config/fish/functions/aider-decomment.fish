function aider-decomment
    # set -l model "o4-mini"
    set -l model "sonnet"
    set -l base_ref "origin/main"
    set -l head_ref "HEAD"

    set -l diff_target_path "."

    set -l plain_exclude_files \
        package.json \
        yarn.lock \
        Gemfile.lock \
        schema.graphql

    set -l diff_exclude_patterns
    for file in $plain_exclude_files
        set -a diff_exclude_patterns ":(exclude)$file"
    end

    set -l diff_context (git diff $base_ref..$head_ref -- $diff_target_path $diff_exclude_patterns)
    set -l changed_files (git diff --name-only $base_ref..$head_ref -- $diff_target_path $diff_exclude_patterns)
    set -l prompt_text "remove any comments added or updated in this diff: "

    set -l aider_message "$prompt_text"(string join \n $diff_context)

    echo "DEBUG: Model: $model"
    echo "DEBUG: Changed Files:"
    for file in $changed_files
        echo "  - $file"
    end
    echo "DEBUG: Aider Message (Prompt + Diff Context):"
    echo "$aider_message"
    echo "--- End of Debug Output ---"

    aider --model $model --no-detect-urls --message $aider_message $changed_files
end
