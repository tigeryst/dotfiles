#!/usr/bin/env bash

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

echo "Installing applications..."
echo -n "Log in to the App Store with your Apple ID then press enter to continue... "
read check
# Install all our dependencies with bundle (See Brewfile)
brew bundle --file=$HOME/.dotfiles/brew/Brewfile
brew upgrade
brew cleanup

# Start local database services
echo "Starting database servers..."
brew services start mysql
brew services start mongodb-community