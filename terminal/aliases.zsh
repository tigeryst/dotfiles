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

# ---------------------
# Virtual environment
# ---------------------

alias mk_env='function _mk_env() {
  local env_name="$1"
  local env_type
  local py_version
  local file_path

  if [ -z "$env_name" ]; then
    read "env_name?Enter the name of the environment: "
    if [ -z "$env_name" ]; then
        echo "Error: Environment name cannot be empty."
        return 1
    fi
  fi

  read "env_type?Enter the type of environment (conda, virtualenv): "

  if [ "$env_type" = "conda" ]; then
    read "py_version?Enter Python version (e.g. 3.8, 3.10): "
    read "file_path?Optional: Path to environment.yml or requirements.txt (leave blank if none): "

    if [[ "$file_path" == *environment.yml || "$file_path" == *environment.yaml ]]; then
      conda env create -n "$env_name" -f "$file_path"
    elif [[ "$file_path" == *requirements.txt ]]; then
      conda create -y -n "$env_name" python="$py_version" jupyterlab && \
      conda activate "$env_name" && pip install -r "$file_path"
    else
      conda create -y -n "$env_name" python="$py_version" jupyterlab && \
      conda activate "$env_name"
    fi

    python -m ipykernel install --user --name "$env_name" --display-name "Python ($env_name)"

  elif [ "$env_type" = "virtualenv" ]; then
    read "root_path?Enter the path to the project root (default: current directory): "
    if [ -z "$root_path" ]; then
      root_path="."
    fi

    read "file_path?Optional: Path to requirements.txt (leave blank if none): "

    python3 -m venv "$root_path/.venv"
    source "$root_path/.venv/bin/activate"
    pip install --upgrade pip
    pip install jupyterlab

    if [[ "$file_path" == *requirements.txt ]]; then
      pip install -r "$file_path"
    fi

    python -m ipykernel install --user --name "$env_name" --display-name "Python ($env_name)"

  else
    echo "Invalid environment type: use conda or virtualenv"
    return 1
  fi
}; _mk_env'

alias rm_env='function _rm_env() {
  local env_name="$1"
  local env_type

  if [ -z "$env_name" ]; then
    read "env_name?Enter the name of the environment: "
    if [ -z "$env_name" ]; then
        echo "Error: Environment name cannot be empty."
        return 1
    fi
  fi

  read "env_type?Enter the type of environment (conda, virtualenv): "

  if [ "$env_type" = "conda" ]; then
    echo "Removing conda environment: $env_name"
    conda deactivate 2>/dev/null
    conda remove -n "$env_name" --all -y
    jupyter kernelspec uninstall "$env_name"

  elif [ "$env_type" = "virtualenv" ]; then
    read "root_path?Enter the path to the project root (default: current directory): "
    if [ -z "$root_path" ]; then
      root_path="."
    fi

    echo "Removing virtual environment: $env_name"
    if [ -d "$root_path/.venv" ] && [ -f "$root_path/.venv/bin/activate" ]; then
      rm -rf "$root_path/.venv"
      jupyter kernelspec uninstall "$env_name"
    else
      echo "Virtual environment not found in: $root_path/.venv"
    fi

  else
    echo "Invalid environment type: use conda or virtualenv"
    return 1
  fi
}; _rm_env'
