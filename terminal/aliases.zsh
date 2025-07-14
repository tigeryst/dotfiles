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

# ---------------------
# Remote
# ---------------------

sync_remote_dir() {
    if [ "$#" -ne 4 ]; then
        echo "Usage: syncdir push|pull user@remote /source/path/ /destination/path/"
        return 1
    fi

    MODE="$1"
    REMOTE="$2"
    SOURCE="$3"
    DEST="$4"

    # Force SOURCE to end with trailing slash
    [[ "${SOURCE}" != */ ]] && SOURCE="${SOURCE}/"

    if [ "$MODE" = "push" ]; then
        echo "Checking destination on remote..."
        if ssh "$REMOTE" "[ -d \"$DEST\" ]"; then
            echo "Destination exists. Using rsync to push changes..."
            rsync -avz --delete "$SOURCE" "$REMOTE:\"$DEST\""
        else
            echo "Destination does not exist. Doing initial tar push..."
            ssh "$REMOTE" "mkdir -p \"$DEST\""
            # Archive the contents of the source folder, not the folder itself:
            tar czf - -C "$SOURCE" . |
                ssh "$REMOTE" "tar xzf - -C \"$DEST\""
        fi

    elif [ "$MODE" = "pull" ]; then
        echo "Checking destination locally..."
        if [ -d "$DEST" ]; then
            echo "Destination exists. Using rsync to pull changes..."
            rsync -avz --delete "$REMOTE:\"$SOURCE\"" "$DEST"
        else
            echo "Destination does not exist. Doing initial tar pull..."
            mkdir -p "$DEST"
            ssh "$REMOTE" "tar czf - -C \"$SOURCE\" ." |
                tar xzf - -C "$DEST"
        fi

    else
        echo "Invalid mode: use push or pull"
        return 1
    fi
}
