# completion
autoload -U compinit
compinit

# ruby's rbenv
eval "$(rbenv init - --no-rehash zsh)"


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
