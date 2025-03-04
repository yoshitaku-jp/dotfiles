#!/bin/bash

set -e  # エラーが発生したらスクリプトを停止

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Starting dotfiles setup..."

# Homebrew のインストールとパッケージ導入
"$DOTFILES_DIR/install_brew.sh"

# シンボリックリンクの作成
"$DOTFILES_DIR/setup_links.sh"

# Zsh をリロード
exec zsh -l

echo "Dotfiles setup completed!"
