<<<<<<< HEAD
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="ys"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  vscode
  mise
)

source "$HOME/.rye/env"
source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/rc/base.zsh
source $HOME/.zsh/rc/functions.zsh
source $HOME/.zsh/rc/github-functions.zsh

# Aliases
alias ga="git add"
alias gc="git commit -m"
alias gl="git log --oneline --decorate --graph --all"
alias gs="git status"
alias gp="git push"
alias gd="git diff"
=======
# Load Zsh configuration from dotfiles
for file in $HOME/.zsh/*.zsh; do
  source $file
done
>>>>>>> 496c4b6fd84826e1a613f0b018effae61244acc8
