# Shortcuts
alias reshell="source $HOME/.zshrc"
alias shrug="echo '¯\_(ツ)_/¯' | tee >(pbcopy)"
alias relaunch="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Change directories
alias dotfiles="cd $DOTFILES && code ."

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias nupdate="ncu -u && npm update"
