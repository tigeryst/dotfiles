#!/usr/bin/env bash

echo "Setting up your Mac..."

if [ -f ~/.osx-bootstrapped.txt ]; then
cat << EOF
~/.osx-bootstrapped.txt FOUND!
This laptop has already been bootstrapped.
Exiting. No changes were made.
EOF
exit 0
fi

XCODE_IS_INSTALLED=$(which xcode-select)

# Install Xcode
if test ! $(which xcode-select); then
  echo "Installing Xcode"
  xcode-select --install
fi

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  echo "Installing Oh My Zsh"
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew tap homebrew/cask
brew install mas
brew bundle
brew upgrade
brew cleanup

npm install -g concurrently
npm install -g nodemon
npm install -g sass

# Set default MySQL root password and auth type
# mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;"

# Install PHP extensions with PECL
# pecl install imagick memcached redis swoole

# Install global Composer packages
# /usr/local/bin/composer global require laravel/installer laravel/valet beyondcode/expose

# Install Laravel Valet
# $HOME/.composer/vendor/bin/valet install

# Create a Sites directory
# mkdir $HOME/Sites

# Create sites subdirectories
# mkdir $HOME/Sites/blade-ui-kit
# mkdir $HOME/Sites/eventsauce
# mkdir $HOME/Sites/laravel

# Clone Github repositories
# ./clone.sh

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -f $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Symlink the Mackup config file to the home directory
ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

rm -f $HOME/Library/Application\ Support/Code/User/settings.json
ln -s $HOME/.dotfiles/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

source .vscode

# Set macOS preferences - we will run this last because this will reload the shell
source .macos

touch $HOME/.osx-bootstrapped.txt