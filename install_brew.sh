#!/bin/bash

set -e  # エラーが発生したらスクリプトを停止

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BREWFILE="$DOTFILES_DIR/Brewfile"

echo "Installing Homebrew and required packages..."

# -------------------------------
# Homebrew のインストール（macOS & Ubuntu）
# -------------------------------
if ! command -v brew &>/dev/null; then
  echo "Homebrew is not installed. Installing now..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS の場合
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    # Linux (Ubuntu) の場合
    sudo apt update
    sudo apt install -y build-essential curl file git
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Linux では `brew` のパスを設定する必要がある
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.profile"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
else
  echo "Homebrew is already installed."
fi

# -------------------------------
# Brewfile によるパッケージインストール
# -------------------------------
if [[ -f "$BREWFILE" ]]; then
  echo "Installing packages from Brewfile..."
  brew bundle --file="$BREWFILE"
else
  echo "Warning: Brewfile not found, skipping package installation."
fi

echo "Homebrew setup completed!"
