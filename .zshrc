# make tools in ~/.bin available
export PATH="$HOME/.bin:$PATH"     

# recommended by brew doctor
export PATH="/usr/local/bin:$PATH" 

# completion
autoload -U compinit
compinit

# ruby's rbenv
eval "$(rbenv init - zsh --no-rehash)"

# shortcuts
alias v=vim
alias g=git
alias fs='find . -type f -not -wholename "*tmp*" | selecta'

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
alias ls='ls -Gh'
alias ll='ls -lGh'
export GREP_OPTIONS="--color"

# history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# set editor
export EDITOR=vi
