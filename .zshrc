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

alias vi=vim
alias v=vim
alias g=git
alias commithelp="echo 'If applied, this commit will ...'"

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

