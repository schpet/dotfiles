# https://github.com/thoughtbot/dotfiles/blob/master/zshrc


export PATH="$HOME/.bin:$PATH"

# Initialize completion
autoload -U compinit
compinit

# makes color constants available
autoload -U colors
colors

# recommended by brew doctor
export PATH="/usr/local/bin:$PATH"
eval "$(rbenv init - zsh --no-rehash)"

alias gs='git status'
alias gb='git branch'
alias gc='git commit -v'
alias gca='git commit --all -v'
alias gco='git checkout'
alias ga='git add'
alias gbdm='git branch --merged | grep -v "\*" | grep -v master | xargs -n 1 git branch -d'

alias vi=vim

# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  current_branch=$(git current-branch 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo " %{$fg[yellow]%}$current_branch%{$reset_color%}"
  fi
}
setopt promptsubst
export PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) \$ '

# Colorize terminal
alias ls='ls -G'
alias ll='ls -lG'
export GREP_OPTIONS="--color"


# Nicer history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

