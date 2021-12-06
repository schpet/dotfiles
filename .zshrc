# completion
autoload -U compinit
compinit

# shortcuts
alias v=vim
alias vi=vim
alias g=git
alias h=heroku
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias tree='tree -I "node_modules|tmp|dist|build"'
alias rg='rg --smart-case'

command -v batcat &> /dev/null && alias bat=batcat

eval "$(starship init zsh)"

# makes color constants available
autoload -U colors
colors

if [[ "$(uname -s)" == "Darwin" ]]; then
  alias ls='gls --human-readable --color'
fi
alias ll='ls -la'

alias find='gfind'
alias wc='gwc'
alias sed='gsed'

alias b='bundle exec'
alias pi='(cd ios && pod install)'
alias gs="echo 'did you mean g s?'"

export TIME_STYLE=long-iso

# history
export HISTSIZE=1000000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt SHARE_HISTORY

export EDITOR=vim

# 2 width tab indentation
tabs -2
export LESS="--tabs=2 -R"
export MORE="--tabs=2 -R"

# makes ctrl-a, ctrl-e work as expected in tmux
bindkey -e

# allows `rake my:task[an_argument]` to work
unsetopt nomatch

# PATH

# ~/bin
export PATH="$HOME/bin:$PATH"

# brew
export PATH="/usr/local/bin:$PATH"

# vs code
test -f "/Applications/Visual Studio Code.app/" && export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# go
export PATH=$PATH:$(go env GOPATH)/bin

if test -f /usr/local/opt/chruby/share/chruby/chruby.sh; then
  # corey's gist has info on chruby https://gist.github.com/csuhta/80ea33d74fc9b90ece13
  # Activate chruby and the .ruby-version auto-switcher
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  source /usr/local/opt/chruby/share/chruby/auto.sh

  function chruby-install {
    set -e
    ruby-install --src-dir /tmp --cleanup --no-install-deps ruby $1
    source ~/.zshrc
    chruby $1
    gem update --system
    gem install rails rake bundler foreman
  }

  chruby ruby-2.7.3
fi

export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

# https://superuser.com/q/313650
# Set Apple Terminal.app resume directory
if [[ $TERM_PROGRAM == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]] {
  function chpwd {
    local SEARCH=' '
    local REPLACE='%20'
    local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
    printf '\e]7;%s\a' "$PWD_URL"
  }

  chpwd
}

# fix for gpg
GPG_TTY=$(tty)
export GPG_TTY

# install node with n – https://github.com/tj/n
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# yarn global modules
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# android tools, e.g. adb
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export PATH="$HOME/Library/Android/sdk/emulator:$PATH"

command -v pyenv &> /dev/null && export PATH=$(pyenv root)/shims:$PATH

export PATH="$HOME/.local/bin:$PATH"

# jump to project in ~/code
function co {
  cd ~/code/$(find ~/code -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | fzf)
}

# eval "$(direnv hook zsh)"
