# --------------------
# Shortcuts
# --------------------
alias reshell="source $HOME/.zshrc"
alias shrug="echo '¯\_(ツ)_/¯' | tee >(pbcopy)"
alias relaunch="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# --------------------
# Packages
# --------------------
alias aupdate="brew update && brew upgrade && brew cleanup && mas upgrade"

# --------------------
# Directories
# --------------------
alias dotfiles="cd $DOTFILES && code ."

# --------------------
# JS
# --------------------
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias nupdate="ncu -u && npm update"

# --------------------
# Computer vision
# --------------------
play() {
    local framerate="${1:-64}"            # default: 64 if no arg
    local pattern="${2:-frame_%010d.jpg}" # default pattern if not provided
    ffplay -framerate "$framerate" -i "$pattern"
}

# --------------------
# Terminal multiplexer
# --------------------

# Start a new tmux session (with name)
alias tnew='tmux new -s'

# Attach to an existing tmux session (with name)
alias tatt='tmux attach -t'

# List all tmux sessions
alias tls='tmux ls'

# Kill a tmux session (with name)
alias tkill='tmux kill-session -t'

# Reattach if one exists, or create a new named session
tstart() {
    local name="$1"
    if tmux has-session -t "$name" 2>/dev/null; then
        tmux attach -t "$name"
    else
        tmux new -s "$name"
    fi
}
