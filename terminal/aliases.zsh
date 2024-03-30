# Shortcuts
alias reloadshell="source $HOME/.zshrc"
alias shrug="echo '¯\_(ツ)_/¯' | tee >(pbcopy)"
alias relaunch="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"
alias mkcd='mkdir -p "$1" && cd "$1"'

# Change directories
alias dotfiles="cd $DOTFILES && code ."
alias library="cd $HOME/Library"
alias desktop="cd $HOME/Desktop"
alias projects="cd $HOME/Projects"

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias nupdate="ncu -u && npm update"
