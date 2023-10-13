#!/usr/bin/env bash

if [ -d plugins/zsh-syntax-highlighting ]; then
    echo "zsh-syntax-highlighting is already installed"
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git plugins/zsh-syntax-highlighting
fi

if [ -d plugins/zsh-autosuggestions ]; then
    echo "zsh-autosuggestions is already installed"
else
    git clone https://github.com/zsh-users/zsh-autosuggestions plugins/zsh-autosuggestions
fi