#!/usr/bin/env bash
set -eu

echo "Installing applications..."

# Ask for sudo once, keep-alive
if [ "$0" = "${BASH_SOURCE[0]}" ]; then
  sudo -v
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

echo -n "Log in to the App Store with your Apple ID then press enter to continue... "
read check
# Install all our dependencies with bundle (See Brewfile)
brew update
brew bundle --file="$HOME/.dotfiles/brew/Brewfile"
brew upgrade
brew cleanup

# Start local database services
echo "Starting database servers..."
brew services start mysql
