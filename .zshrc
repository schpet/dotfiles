# completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

if [[ "$(uname -s)" == "Darwin" ]]; then
  # prefer gnu stuff on mac
  alias ls='gls --human-readable --color'
  alias find='gfind'
  alias wc='gwc'
  alias sed='gsed'
	alias readlink='greadlink'

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
alias f=flyctl
alias tree='tree -I "node_modules|tmp|dist|build"'
alias rg='rg --smart-case'
# alias ls='exa'
alias ll='exa -la'
alias b='bundle exec'
alias gs="echo 'did you mean g s?'"
alias curl="curl --no-progress-meter"
alias td="tracker-description"

command -v batcat &> /dev/null && alias bat=batcat

eval "$(starship init zsh)"

# makes color constants available
autoload -U colors
colors

export TIME_STYLE=long-iso


# vscode seems to want to set my history to ~/.zsh_history which is annoying!!!
if [[ "$(uname -s)" == "Darwin" ]]; then
	test -f "$HOME/.zsh_history" && rm "$HOME/.zsh_history"
fi

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

# chruby
if test -f $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh; then
	source $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh
	source $HOMEBREW_PREFIX/opt/chruby/share/chruby/auto.sh

  chruby ruby-3.1.0
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

# android tools, e.g. adb
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools


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

if type fnm &>/dev/null
then
	eval "$(fnm env --use-on-cd)"
fi

# ??
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

function minimal-ps1 {
  export PS1=$(printf "\n$ ")
}


# python
export PATH=$(pyenv root)/shims:$PATH
