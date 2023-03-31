#!/bin/zsh

if ! command -v brew &> /dev/null; then
  echo "Homebrewがインストールされていません。"
  echo "https://brew.sh/index_ja"
  echo "Homebrewをインストールしています..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrewがすでにインストールされています。"
fi

echo ".Brewfileで管理しているアプリケーションをインストールします..."
sudo -n brew bundle --file ./homebrew/Brewfile --verbose
