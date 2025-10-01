# Dotfiles scripts
export PATH="$DOTFILES/bin:$PATH"

# Java binaries, based on JAVA_HOME from .zprofile
[ -n "$JAVA_HOME" ] && export PATH="$JAVA_HOME/bin:$PATH"