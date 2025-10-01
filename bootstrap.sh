#!/usr/bin/env bash
set -eu

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

# Prompt for git user configuration
read -p "Enter your git user name: " git_name
read -p "Enter your git email: " git_email

# Install Xcode
if command -v xcode-select &>/dev/null; then
  echo "Xcode is already installed"
else
  echo "Installing Xcode"
  xcode-select --install
fi

# Install Oh My Zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
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

source "$HOME/.dotfiles/brew/install.sh"
source "$HOME/.dotfiles/cursor/extensions.sh"

echo "Setting up git..."
rm -f "$HOME/.gitconfig"
ln -s "$HOME/.dotfiles/git/.gitconfig" "$HOME/.gitconfig"

# Create .gitconfig.local with user-specific settings
cat > "$HOME/.gitconfig.local" << EOF
[user]
	name = $git_name
	email = $git_email
EOF

echo "Git user configured: $git_name <$git_email>"

source "$HOME/.dotfiles/terminal/install.sh"

echo "Creating symbolic links..."
# Symlink the .zshrc file
rm -f "$HOME/.zshrc"
ln -s "$HOME/.dotfiles/terminal/.zshrc" "$HOME/.zshrc"

# Symlink Cursor settings
rm -f "$HOME/Library/Application Support/Cursor/User/settings.json"
ln -s "$HOME/.dotfiles/cursor/settings.json" "$HOME/Library/Application Support/Cursor/User/settings.json"

# Symlink tmux settings
rm -f "$HOME/.tmux.conf"
ln -s "$HOME/.dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Symlink the .ghci file for haskell
rm -f "$HOME/.ghci"
ln -s "$HOME/.dotfiles/haskell/.ghci" "$HOME/.ghci"

source "$HOME/.dotfiles/tmux/install.sh"
source "$HOME/.dotfiles/javascript/install.sh"
source "$HOME/.dotfiles/python/install.sh"
source "$HOME/.dotfiles/rust/install.sh"

source "$HOME/.dotfiles/os/macos.sh"

echo -n "Log in to your Google Drive then press enter to continue... "
read check

echo "Set up of your Mac is completed. It is recommended to restart the computer to apply all changes."
echo 'Enjoy!'
