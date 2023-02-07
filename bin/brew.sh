#!/bin/zsh

echo "homebrewをインストールします..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo ".Brewfileで管理しているアプリケーションをインストールします..."
brew bundle --file ~/homebrew/Brewfile --verbose
