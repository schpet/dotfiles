fish_add_path ~/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/libpq/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin

if status is-interactive
    starship init fish | source
    atuin init fish --disable-up-arrow | source
end


set -gx EDITOR vim

# pnpm
set -gx PNPM_HOME "/Users/schpet/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

abbr --add cc cd ~/code
abbr --add cw cd ~/tanooki

abbr --add b bundle
abbr --add e code
abbr --add f flyctl
abbr --add g git
abbr --add gs git status
abbr --add h heroku
abbr --add j just
abbr --add l linear
abbr --add n npm
abbr --add p pnpm
abbr --add v nvim

abbr --add json2ts quicktype --lang ts --just-types --no-enums
abbr --add json2rs quicktype --lang rust --visibility public

abbr --add uncolor gsed -e 's/\x1b\[[0-9;]*m//g'
abbr --add unindent awk '{if (NR==1) {len=index($0, $1); }; print substr($0, len)}'
abbr --add rgg rg --no-heading
abbr --add llmq llm -s \"Answer in as few words as possible. Use a brief style with short replies.\"
