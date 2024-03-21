#!/bin/zsh

# すでにシンボリックリンクが存在する場合は、上書きしない
echo ".zshと.zshrcのシンボリックリンクを作成しています..."
ln -snf ~/workspace/dotfiles/.zshrc ~
