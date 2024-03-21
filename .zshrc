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
