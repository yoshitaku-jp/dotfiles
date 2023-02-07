#!/bin/bash

echo "Xcodeをインストールします..."
xcode-select --install

echo "homebrewをインストールします..."
which /opt/homebrew/bin/brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

exec $SHELL -l
