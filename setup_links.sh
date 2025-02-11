#!/bin/bash

set -e  # エラーが発生したらスクリプトを停止

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
ZSH_CONFIG_DIR="$DOTFILES_DIR/zsh"
ZSHRC_SRC="$DOTFILES_DIR/.zshrc"
ZSHRC_DST="$HOME/.zshrc"

echo "Setting up dotfiles links..."

# `.zsh` のシンボリックリンクを削除して作り直す
if [[ -L "$HOME/.zsh" ]]; then
  echo "Removing existing symbolic link: $HOME/.zsh"
  rm -f "$HOME/.zsh"
elif [[ -d "$HOME/.zsh" ]]; then
  echo "Removing existing directory: $HOME/.zsh"
  rm -rf "$HOME/.zsh"
fi

echo "Creating symlink: $HOME/.zsh -> $ZSH_CONFIG_DIR"
ln -s "$ZSH_CONFIG_DIR" "$HOME/.zsh"

# `.zshrc` のシンボリックリンクを作成
if [[ -L "$ZSHRC_DST" || -e "$ZSHRC_DST" ]]; then
  echo "Removing existing $ZSHRC_DST..."
  rm -f "$ZSHRC_DST"
fi

echo "Creating symlink: $ZSHRC_DST -> $ZSHRC_SRC"
ln -s "$ZSHRC_SRC" "$ZSHRC_DST"

echo "Dotfiles links setup completed!"
