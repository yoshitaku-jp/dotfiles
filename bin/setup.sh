#!/bin/bash

echo "Xcodeをインストールします..."
xcode-select --install

exec $SHELL -l
