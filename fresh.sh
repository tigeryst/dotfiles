#!/usr/bin/env bash

echo "Setting up your Mac..."

if [ -f ~/.osx-bootstrapped.txt ]; then
  cat <<EOF
~/.osx-bootstrapped.txt found!
This laptop has already been bootstrapped.
Exiting. No changes were made.
EOF
  exit 0
fi

# Install Xcode
if type xcode-select >&- &&
  xpath=$(xcode-select --print-path) &&
  test -d "${xpath}" && test -x "${xpath}"; then
  echo "Installing Xcode"
  xcode-select --install
fi

# Check for Oh My Zsh and install if we don't have it
if [ -d ~/.oh-my-zsh ]; then
  echo "Installing Oh My Zsh"
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# Update Homebrew recipes
brew update

echo "Installing applications"
echo -n "Ensure that you are logged in to the App Store with your Apple ID then press enter to continue... "
read check
# Install all our dependencies with bundle (See Brewfile)
brew bundle || true
brew upgrade
brew cleanup

# Start local database services
brew services start mysql
brew services start mongodb-community

npm install -g npm-check-updates
npm install -g n
npm install -g typescript

# Install haskell
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

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

source .vscode

touch $HOME/.osx-bootstrapped.txt

source user-config.sh

echo "Set up of your Mac is completed"
echo 'Enjoy!'
