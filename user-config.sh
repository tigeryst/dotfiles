#!/usr/bin/env bash

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -f $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

echo "Setting up git..."
echo -n "Ensure that you have your github credentials saved to your Keychain then press enter to continue... "
read check
rm -f $HOME/.gitconfig
ln -s $HOME/.dotfiles/.gitconfig $HOME/.gitconfig

if [ -d plugins/zsh-syntax-highlighting ]; then
    rm -rf plugins/zsh-syntax-highlighting
fi
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git plugins/zsh-syntax-highlighting

if [ -d plugins/zsh-autosuggestions ]; then
    rm -rf plugins/zsh-autosuggestions
fi
git clone https://github.com/zsh-users/zsh-autosuggestions plugins/zsh-autosuggestions

# Symlink the Mackup config file to the home directory
# ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Symlink VS Code settings
rm -f $HOME/Library/Application\ Support/Code/User/settings.json
ln -s $HOME/.dotfiles/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

# Symlink the .ghci file for haskell
rm -f $HOME/.ghci
ln -s $HOME/.dotfiles/.ghci $HOME/.ghci

# Set macOS preferences - we will run this last because this will reload the shell
script_name=$(basename ${0#-})
this_script=$(basename ${BASH_SOURCE})
if [[ ${script_name} == ${this_script} ]]; then
    # Ask for the administrator password upfront
    sudo -v

    # Keep-alive: update existing `sudo` time stamp until `.macos` has finished
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done 2>/dev/null &
fi
source .macos
