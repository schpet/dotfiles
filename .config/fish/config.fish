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

abbr --add cw cd ~/tanooki
abbr --add cc cd ~/code
