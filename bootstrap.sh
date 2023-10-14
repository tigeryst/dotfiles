#!/usr/bin/env bash

echo "Setting up your Mac..."

# Check if script is running as the main script and not being sourced
if [ "$0" = "$BASH_SOURCE" ]; then
  # Ask for the administrator password upfront
  sudo -v

  # Keep-alive: update existing sudo timestamp until script has finished
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &
fi

echo -n "Connect to the internet then press enter to continue... "
read check

# Install Xcode
if command -v xcode-select &>/dev/null; then
  echo "Xcode is already installed"
else
  echo "Installing Xcode"
  xcode-select --install
fi

# Install Oh My Zsh
if [ -d $HOME/.oh-my-zsh ]; then
  echo "Oh My Zsh is already installed"
else
  echo "Installing Oh My Zsh"
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if command -v brew &>/dev/null; then
  echo "Homebrew is already installed"
else
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew update
fi

source brew/install.sh
source vscode/extensions.sh

echo "Setting up git..."
echo -n "Ensure that you are connected to iCloud and have your GitHub credentials saved to your Keychain then press enter to continue... "
read check
rm -f $HOME/.gitconfig
ln -s $HOME/.dotfiles/git/.gitconfig $HOME/.gitconfig

source git/clone.sh
source terminal/install.sh

echo "Creating symbolic links..."
# Symlink the .zshrc file
rm -f $HOME/.zshrc
ln -s $HOME/.dotfiles/terminal/.zshrc $HOME/.zshrc

# Symlink VS Code settings
rm -f $HOME/Library/Application\ Support/Code/User/settings.json
ln -s $HOME/.dotfiles/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

# Symlink the .ghci file for haskell
rm -f $HOME/.ghci
ln -s $HOME/.dotfiles/haskell/.ghci $HOME/.ghci

source os/macos.sh

echo -n "Log in to your Google Drive then press enter to continue... "
read check

echo "Set up of your Mac is completed"
echo 'Enjoy!'
