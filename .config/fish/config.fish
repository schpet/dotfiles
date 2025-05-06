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
# set -gx DELTA_PAGER "less --mouse"

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
abbr --add fd 'fd --hidden'

abbr --add b bundle
abbr --add be bundle exec
abbr --add br brew
abbr --add bbi brew bundle install
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
abbr --add trurlparams "trurl --url-file - --json | jq -r '.[0].params | map(\"\\(.key)=\\(.value)\")[]'"
abbr --add aider-oneshot 'aider --message="fix this issue:\\n$(linear issue view)"'
abbr --add aider-branch 'aider $(git diff --name-only main.. | checkthrough)'



alias ls eza

source $HOME/.config/fish/abbr.fish

abbr_subcommand git c "commit"
abbr_subcommand git ca "commit -a"
abbr_subcommand git s "status"
abbr_subcommand git amend "commit --amend"
abbr_subcommand git cp "cherry-pick"
abbr_subcommand git cherrypick "cherry-pick"
abbr_subcommand git da "diff HEAD"
abbr_subcommand git dc "diff --cached"
abbr_subcommand git d "diff"
abbr_subcommand git di "diff"
abbr_subcommand git dif "diff"
abbr_subcommand git cce "commit --allow-empty --allow-empty-message -m ''"
abbr_subcommand git reset "reset --keep" # try and stop using git reset --hard
abbr_subcommand git r "restore"

abbr_subcommand brew b "bundle"
abbr_subcommand bundle e "exec"

abbr_subcommand brew i install
abbr_subcommand linear i issue
abbr_subcommand gh i issue
abbr_subcommand gh p "pr"



# by default fish clears the command after ctrl-c, this change preserves the content
# - https://github.com/fish-shell/fish-shell/issues/2904
# - https://github.com/fish-shell/fish-shell/pull/4713
bind -s \cc __fish_cancel_commandline
