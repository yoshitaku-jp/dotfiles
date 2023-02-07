#!/bin/zsh

echo "Xcodeをインストールします..."
xcode-select --install

exec $SHELL -l
