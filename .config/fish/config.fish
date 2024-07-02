if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
end

set -gx EDITOR vim

# pnpm
set -gx PNPM_HOME "/Users/schpet/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
