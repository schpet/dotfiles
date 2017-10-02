# completion
autoload -U compinit
compinit

# shortcuts
alias v=vim
alias g=git

# prompt
git_prompt_info() {
  current_branch=$(git current-branch 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo " %{$fg[yellow]%}$current_branch%{$reset_color%}"
  fi
}
setopt promptsubst
export PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) \$ '

# makes color constants available
autoload -U colors
colors

# use colors
alias ls='gls -Gh'
alias ll='gls -lGh'
alias find='gfind'
export TIME_STYLE=long-iso
export GREP_OPTIONS="--color"

# history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

export EDITOR=vi

# makes ctrl-a, ctrl-e work as expected in tmux
bindkey -e

# PATH

# ~/.bin
export PATH="$HOME/.bin:$PATH"

# brew
export PATH="/usr/local/bin:$PATH"

# npm packages
export PATH="/usr/local/Cellar/node/8.4.0/bin:$PATH"

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
  gem install --no-ri --no-rdoc rails rake bundler foreman
}

chruby ruby-2.4.2
