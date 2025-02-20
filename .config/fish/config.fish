source (changelog completions fish | psub)
direnv hook fish | source

fish_add_path ~/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/libpq/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.deno/bin # note - this is already on my path but no idea how deno puts it there?

if status is-interactive
    starship init fish | source
    atuin init fish --disable-up-arrow | source
end

set -gx EDITOR nvim
set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/ripgreprc"
set -gx HOMEBREW_BUNDLE_FILE "$HOME/.config/brew/Brewfile"

# pnpm
set -gx PNPM_HOME "/Users/schpet/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Added by `rbenv init` on Thu Sep 19 12:09:03 PDT 2024
status --is-interactive; and rbenv init - --no-rehash fish | source

abbr --add cc cd ~/code
abbr --add cw cd ~/tanooki
abbr --add fly flyctl

abbr --add b bundle
abbr --add be bundle exec
abbr --add e zed-preview
abbr --add f flyctl
abbr --add g git
abbr --add gs git status
abbr --add h heroku
abbr --add j just
abbr --add l linear
abbr --add n npm
abbr --add p pnpm
abbr --add v nvim
abbr --add vi nvim
abbr --add rgg rg
abbr --add c cargo
abbr --add r bin/rails
abbr --add o open
abbr --add cl changelog

abbr --add json2ts quicktype --lang ts --just-types --no-enums
abbr --add json2rs quicktype --lang rust --visibility public

abbr --add uncolor gsed -e 's/\x1b\[[0-9;]*m//g'
abbr --add unindent awk '{if (NR==1) {len=index($0, $1); }; print substr($0, len)}'
abbr --add llmq llm -s \"Answer in as few words as possible. Use a brief style with short replies.\"
abbr --add aiderl 'aider --message="fix this issue:\\n$(linear view)"'
abbr --add ls eza
abbr --add trurlparams "trurl --url-file - --json | jq -r '.[0].params | map(\"\\(.key)=\\(.value)\")[]'"


# `g co`, etc. subcommand expansion with `abbr`.
# thx paulirish: https://github.com/paulirish/dotfiles/blob/457f8d0ac13927a190aed6e050d9c0496aa6118b/fish/aliases.fish#L43
function subcommand_abbr
  set -l cmd "$argv[1]"
  set -l short "$argv[2]"
  set -l long "$argv[3]"

  # Check that these strings are safe, since we're going to eval. 👺
  if not string match --regex --quiet '^[a-zA-Z]*$' "$short"
    or not string match --regex --quiet '^[a-zA-Z- ]*$' "$long"
    echo "Scary unsupported alias or expansion $short $long"; exit 1;
  end

  set -l abbr_temp_fn_name (string join "_" "abbr" "$cmd" "$short")

  set -l abbr_temp_fn "function $abbr_temp_fn_name
    set --local tokens (commandline --tokenize)
    if test \$tokens[1] = \"$cmd\"
      echo $long
    else
      echo $short
    end;
  end;
  abbr --add $short --position anywhere --function $abbr_temp_fn_name"
  eval "$abbr_temp_fn"
end

subcommand_abbr git c "commit"
subcommand_abbr git ca "commit -a"
subcommand_abbr git s "status"
subcommand_abbr git amend "commit --amend"
subcommand_abbr git cp "cherry-pick"
subcommand_abbr git cherrypick "cherry-pick"

subcommand_abbr git da "diff head"
subcommand_abbr git dc "diff --cached"
subcommand_abbr git d "diff"
subcommand_abbr git di "diff"
subcommand_abbr git dif "diff"

subcommand_abbr linear i "issue"
