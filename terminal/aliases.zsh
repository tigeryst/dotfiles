# --------------------
# Shortcuts
# --------------------
alias reshell="source $HOME/.zshrc"
alias shrug="echo '¯\_(ツ)_/¯' | tee >(pbcopy)"
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

trim_png() {
    # Usage: trim_png input.png output.png
    if [ $# -ne 2 ]; then
        echo "Usage: trim_png <input.png> <output.png>"
        return 1
    fi
    magick "$1" -trim +repage "$2"
}

# ---------------------
# Virtual environment
# ---------------------

alias mk_env='function _mk_env() {
  local env_name="$1"
  local env_type
  local py_version
  local file_path

  # Get environment name
  if [ -z "$env_name" ]; then
    read "env_name?Enter the name of the environment: "
    if [ -z "$env_name" ]; then
        echo "Error: Environment name cannot be empty."
        return 1
    fi
  fi

  # Ask which type of environment to create
  read "env_type?Enter the type of environment (mamba, conda, virtualenv): "

  # Conda or mamba
  if [ "$env_type" = "conda" ] || [ "$env_type" = "mamba" ]; then
    local tool="$env_type"  # tool = conda or mamba

    # Choose Python version
    read "py_version?Enter Python version (e.g. 3.8, 3.10): "

    # Optional: path to environment.yml or requirements.txt
    read "file_path?Optional: Path to environment.yml or requirements.txt (leave blank if none): "

    if [[ "$file_path" == *environment.yml || "$file_path" == *environment.yaml ]]; then
      # If environment.yml provided, create environment from it
      $tool env create -n "$env_name" -f "$file_path"
    else
      # Else just create an empty environment
      $tool create -y -n "$env_name" python="$py_version"
    fi

    # Ensure Jupyterlab and ipykernel are installed
    $tool install -y -n "$env_name" jupyterlab ipykernel

    # Upgrade pip
    $tool run -n "$env_name" python -m pip install --upgrade pip

    if [[ "$file_path" == *requirements.txt ]]; then
      # If requirements.txt provided, install dependencies
      $tool run -n "$env_name" python -m pip install -r "$file_path"
    fi

    # Register Jupyterlab kernel
    $tool run -n "$env_name" python -m ipykernel install --user --name "$env_name" --display-name "Python ($env_name)"

  # Virtualenv
  elif [ "$env_type" = "virtualenv" ]; then
    # Ask for project root path
    read "root_path?Enter the path to the project root (default: current directory): "
    if [ -z "$root_path" ]; then
      root_path="."
    fi

    # Optional: path to requirements.txt
    read "file_path?Optional: Path to requirements.txt (leave blank if none): "

    # Create virtual environment
    local venv_path="$root_path/venv"
    virtualenv "$venv_path"

    # Upgrade pip
    "$venv_path/bin/python" -m pip install --upgrade pip

    # Ensure Jupyterlab and ipykernel are installed
    "$venv_path/bin/python" -m pip install jupyterlab ipykernel

    # If requirements.txt provided, install dependencies
    if [[ "$file_path" == *requirements.txt ]]; then
      "$venv_path/bin/python" -m pip install -r "$file_path"
    fi

    # Register Jupyterlab kernel
    "$venv_path/bin/python" -m ipykernel install --user --name "$env_name" --display-name "Python ($env_name)"

  else
    echo "Invalid environment type: use mamba, conda or virtualenv"
    return 1
  fi
}; _mk_env'


alias rm_env='function _rm_env() {
  local env_name="$1"
  local env_type

  # Get environment name
  if [ -z "$env_name" ]; then
    read "env_name?Enter the name of the environment: "
    if [ -z "$env_name" ]; then
        echo "Error: Environment name cannot be empty."
        return 1
    fi
  fi

  # Ask which type of environment to remove
  read "env_type?Enter the type of environment (mamba, conda, virtualenv): "

  # Conda or mamba
  if [ "$env_type" = "conda" ] || [ "$env_type" = "mamba" ]; then
    local tool="$env_type"
    echo "Removing $tool environment: $env_name"

    # Deactivate
    $tool deactivate 2>/dev/null

    # Uninstall Jupyterlab kernel
    $tool run -n "$env_name" jupyter kernelspec uninstall -y "$env_name"

    # Remove environment
    $tool env remove -n "$env_name" -y

  # Virtualenv
  elif [ "$env_type" = "virtualenv" ]; then
    read "root_path?Enter the path to the project root (default: current directory): "
    if [ -z "$root_path" ]; then
      root_path="."
    fi

    echo "Removing virtual environment: $env_name"
    if [ -d "$root_path/venv" ] && [ -f "$root_path/venv/bin/activate" ]; then
      # Uninstall Jupyterlab kernel
      "$root_path/venv/bin/jupyter" kernelspec uninstall -y "$env_name"

      # Remove virtual environment
      rm -rf "$root_path/venv"
    else
      echo "Virtual environment not found in: $root_path/venv"
    fi

  else
    echo "Invalid environment type: use mamba, conda or virtualenv"
    return 1
  fi
}; _rm_env'

alias export_env='function _export_env() {
  local env_name="$1"
  local env_type
  local output_file

  # Get environment name
  if [ -z "$env_name" ]; then
    read "env_name?Enter the name of the environment: "
    if [ -z "$env_name" ]; then
        echo "Error: Environment name cannot be empty."
        return 1
    fi
  fi

  # Ask which type of environment to export
  read "env_type?Enter the type of environment (mamba, conda, virtualenv): "

  # Ask for output file path
  read "output_file?Enter the output file path (leave blank for default): "

  # Conda or mamba
  if [ "$env_type" = "conda" ] || [ "$env_type" = "mamba" ]; then
    local tool="$env_type"
    
    # Set default output file if not provided
    if [ -z "$output_file" ]; then
      output_file="environment.yml"
    fi

    echo "Exporting $tool environment: $env_name to $output_file"

    # Export environment and remove prefix line
    $tool env export -n "$env_name" | grep -v "^prefix:" > "$output_file"
    
    echo "Environment exported successfully to: $output_file"

  # Virtualenv
  elif [ "$env_type" = "virtualenv" ]; then
    read "root_path?Enter the path to the project root (default: current directory): "
    if [ -z "$root_path" ]; then
      root_path="."
    fi

    # Set default output file if not provided
    if [ -z "$output_file" ]; then
      output_file="requirements.txt"
    fi

    echo "Exporting virtual environment: $env_name to $output_file"

    if [ -d "$root_path/venv" ] && [ -f "$root_path/venv/bin/activate" ]; then
      # Export requirements from virtual environment
      "$root_path/venv/bin/pip" freeze > "$output_file"
      echo "Environment exported successfully to: $output_file"
    else
      echo "Virtual environment not found in: $root_path/venv"
      return 1
    fi

  else
    echo "Invalid environment type: use mamba, conda or virtualenv"
    return 1
  fi
}; _export_env'