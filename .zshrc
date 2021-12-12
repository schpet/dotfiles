# completion
autoload -U compinit
compinit

if [[ "$(uname -s)" == "Darwin" ]]; then
  # prefer gnu stuff on mac
  alias ls='gls --human-readable --color'
  alias find='gfind'
  alias wc='gwc'
  alias sed='gsed'

  alias pi='(cd ios && pod install)'


  # vs code
  test -d "/Applications/Visual Studio Code.app" && export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

  # brew
  export PATH="/usr/local/bin:$PATH"

  # fix for gpg
  GPG_TTY=$(tty)
  export GPG_TTY

fi

# shortcuts
alias v=vim
alias vi=vim
alias g=git
alias h=heroku
alias tree='tree -I "node_modules|tmp|dist|build"'
alias rg='rg --smart-case'
alias ll='ls -la'
alias b='bundle exec'
alias gs="echo 'did you mean g s?'"

command -v batcat &> /dev/null && alias bat=batcat

eval "$(starship init zsh)"

# makes color constants available
autoload -U colors
colors

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

# makes ctrl-a, ctrl-e work as expected in tmux, vscode terminal, elsewhere?
bindkey -e

# allows `rake my:task[an_argument]` to work
unsetopt nomatch

# PATH

# ~/bin
# note! .profile maybe has this? need to put it in here
export PATH="$HOME/bin:$PATH"

command -v go &> /dev/null && export PATH=$PATH:$(go env GOPATH)/bin

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

# install node with n – https://github.com/tj/n
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# android tools, e.g. adb
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# jump to project in ~/code
function co {
  cd ~/code/$(find ~/code -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | fzf)
}
###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    if ! IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)); then
      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    if ! IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)); then

      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
