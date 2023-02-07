#!/bin/bash

echo ".Brewfileで管理しているアプリケーションをインストールします..."
which /opt/homebrew/bin/brew >/dev/null 2>&1 && brew bundle --file ../homebrew/Brewfile --verbose
