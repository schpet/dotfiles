# Fall back to xterm-256color if TERM is not in terminfo database (e.g., ghostty)
if not infocmp $TERM >/dev/null 2>&1
    set -gx TERM xterm-256color
end

source (changelog completions fish | psub)
direnv hook fish | source

fish_add_path ~/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/libpq/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.deno/bin # note - this is already on my path but no idea how deno puts it there?

if status is-interactive
    if not set -q ASCIINEMA_REC
        starship init fish | source
    else
        function fish_prompt; set_color green; echo -n "❯ "; set_color normal; end
    end
    atuin init fish --disable-up-arrow | source
end

set -gx EDITOR nvim
set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/ripgreprc"
set -gx HOMEBREW_BUNDLE_FILE "$HOME/.config/brew/Brewfile"
# set -gx DELTA_PAGER "less --mouse"

set -gx ANDROID_HOME $HOME/Library/Android/sdk
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/platform-tools


# pnpm
set -gx PNPM_HOME "/Users/schpet/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# claude code
set -gx CLAUDE_CODE_DISABLE_TERMINAL_TITLE 1       # prevent claude code from rewriting terminal title
set -gx CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC 1 # don't ask me how you're doing etc
set -gx CLAUDE_CODE_FORCE_FULL_LOGO 1              # doesn't seem to work... but i want it to.
# todo: CLAUDE_CONFIG_DIR: todo move claude stuff to ~/.config/claude, currently it's at ~/.claude


# use jj with https://github.com/schpet/linear-cli
set -gx LINEAR_VCS jj

# Added by `rbenv init` on Thu Sep 19 12:09:03 PDT 2024
if type -q rbenv
    status --is-interactive; and rbenv init - --no-rehash fish | source
end

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
abbr --add j jj
abbr --add jja jjagent
abbr --add ju just
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
abbr --add claude-yolo claude --dangerously-skip-permissions
abbr --add cc claude --dangerously-skip-permissions
abbr --add ce claude --permission-mode acceptEdits
abbr --add claude-dev claude --plugin-dir ~/code/toolbox/plugins/chores --plugin-dir ~/code/toolbox/plugins/changelog --plugin-dir ~/code/toolbox/plugins/jj-vcs --plugin-dir ~/code/toolbox/plugins/svbump
abbr --add llmm llm -o reasoning_effort minimal
abbr --add pwg open -a ghostty "$(pwd)"

abbr --add json2ts quicktype --lang ts --just-types --no-enums
abbr --add json2rs quicktype --lang rust --visibility public

abbr --add uncolor gsed -e 's/\x1b\[[0-9;]*m//g'
abbr --add unindent awk '{if (NR==1) {len=index($0, $1); }; print substr($0, len)}'
abbr --add trurlparams "trurl --url-file - --json | jq -r '.[0].params | map(\"\\(.key)=\\(.value)\")[]'"
abbr --add aider-oneshot 'aider --message="fix this issue:\\n$(linear issue view)"'
abbr --add aider-branch 'aider $(git diff --name-only main.. | checkthrough)'


# :-)
abbr --add jjw watch -t -n 0.75 --color 'jj log --ignore-working-copy --color=always'


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
abbr_subcommand git dls "diff main.. --name-only"

abbr_subcommand jj d "describe"
abbr_subcommand jj dm "describe -m"
abbr_subcommand jj g "git"
abbr_subcommand jj sq "squash"

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
