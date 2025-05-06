function aider-decomment
    set -l model "o4-mini"
    set -l base_ref "origin/main"
    set -l head_ref "HEAD"

    set -l diff_target_path "."
    set -l diff_exclude_patterns \
        ':(exclude)package.json' \
        ':(exclude)yarn.lock' \
        ':(exclude)Gemfile.lock' \
        ':(exclude)schema.graphql'

    set -l diff_context (git diff $base_ref..$head_ref -- $diff_target_path $diff_exclude_patterns)
    set -l changed_files (git diff --name-only $base_ref..$head_ref -- $diff_target_path $diff_exclude_patterns)
    set -l prompt_text "remove any comments added or updated in this diff: "

    set -l aider_message "$prompt_text$diff_context"

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
