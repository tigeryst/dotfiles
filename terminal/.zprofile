# Dotfiles root for other scripts to reference
export DOTFILES="$HOME/.dotfiles"

# Ensure Homebrew in PATH for login shells (ARM first, then Intel)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Non-interactive, login-wide PATH additions that GUI apps should see
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# Java (login-wide)
if /usr/libexec/java_home >/dev/null 2>&1; then
  export JAVA_HOME="$(/usr/libexec/java_home)"
fi