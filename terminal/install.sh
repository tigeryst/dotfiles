#!/usr/bin/env bash

if [ -d $HOME/.dotfiles/terminal/plugins/zsh-syntax-highlighting ]; then
    echo "zsh-syntax-highlighting is already installed"
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.dotfiles/terminal/plugins/zsh-syntax-highlighting
fi

if [ -d $HOME/.dotfiles/terminal/plugins/zsh-autosuggestions ]; then
    echo "zsh-autosuggestions is already installed"
else
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.dotfiles/terminal/plugins/zsh-autosuggestions
fi
