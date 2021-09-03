#!/usr/bin/env bash

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -f $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions plugins/zsh-autosuggestions

# Symlink the Mackup config file to the home directory
# ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

rm -f $HOME/Library/Application\ Support/Code/User/settings.json
ln -s $HOME/.dotfiles/settings.json $HOME/Library/Application\ Support/Code/User/settings.json


# Set macOS preferences - we will run this last because this will reload the shell
source .macos