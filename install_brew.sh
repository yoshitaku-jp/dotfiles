#!/bin/bash

set -e  # エラーが発生したらスクリプトを停止

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BREWFILE="$DOTFILES_DIR/Brewfile"

echo "Installing Homebrew and required packages..."

# Homebrew のインストール
if ! command -v brew &>/dev/null; then
  echo "Homebrew is not installed. Installing now..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi

# `brew bundle` でパッケージをインストール
if [[ -f "$BREWFILE" ]]; then
  echo "Installing packages from Brewfile..."
  brew bundle --file="$BREWFILE"
else
  echo "Warning: Brewfile not found, skipping package installation."
fi

echo "Homebrew setup completed!"
