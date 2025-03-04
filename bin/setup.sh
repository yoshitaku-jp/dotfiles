#!/bin/bash

echo "Installing brew packages..."
brew bundle --file=../homebrew/Brewfile_brew

echo "Installing cask packages..."
brew bundle --file=../homebrew/Brewfile_cask

echo "Installing vscode packages..."
brew bundle --file=../homebrew/Brewfile_vscode
