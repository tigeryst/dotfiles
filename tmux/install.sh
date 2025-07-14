#!/usr/bin/env bash
set -eu

echo "Installing tmux plugins..."

# Install tmux plugins
if [ -d "$HOME/.dotfiles/tmux/plugins/tpm" ]; then
    echo "tpm is already installed"
else
    echo "Installing tpm"
    git clone https://github.com/tmux-plugins/tpm "$HOME/.dotfiles/tmux/plugins/tpm"
fi

if [ -d "$HOME/.dotfiles/tmux/plugins/tmux-sensible" ]; then
    echo "tmux-sensible is already installed"
else
    echo "Installing tmux-sensible"
    git clone https://github.com/tmux-plugins/tmux-sensible "$HOME/.dotfiles/tmux/plugins/tmux-sensible"
fi

if [ -d "$HOME/.dotfiles/tmux/plugins/tmux-resurrect" ]; then
    echo "tmux-resurrect is already installed"
else
    echo "Installing tmux-resurrect"
    git clone https://github.com/tmux-plugins/tmux-resurrect "$HOME/.dotfiles/tmux/plugins/tmux-resurrect"
fi

if [ -d "$HOME/.dotfiles/tmux/plugins/tmux-continuum" ]; then
    echo "tmux-continuum is already installed"
else
    echo "Installing tmux-continuum"
    git clone https://github.com/tmux-plugins/tmux-continuum "$HOME/.dotfiles/tmux/plugins/tmux-continuum"
fi
