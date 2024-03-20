#!/bin/zsh

if ! command -v brew &> /dev/null; then
  echo "Homebrewがインストールされていません。"
  echo "Homebrewをインストールしています..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Homebrewをインストールしました"
else
  echo "Homebrewがすでにインストールされています。"
fi

echo ".Brewfileで管理しているアプリケーションをインストールします..."
brew bundle --file ./homebrew/Brewfile --verbose
