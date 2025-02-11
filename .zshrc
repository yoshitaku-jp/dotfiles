# Load Zsh configuration from dotfiles
for file in $HOME/.zsh/*.zsh; do
  source $file
done
