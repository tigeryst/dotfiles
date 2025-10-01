# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set default text editor
export EDITOR='code -w'

# Ensure 256 color support
export TERM=xterm-256color

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Custom folder other than $ZSH/custom?
ZSH_CUSTOM="$DOTFILES/terminal"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    brew
    colored-man-pages
    colorize
    git
    macos
    pip
    python
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Use case-sensitive completion.
# CASE_SENSITIVE="true"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

source "$ZSH/oh-my-zsh.sh"

eval "$(pyenv init -)"

PATH="$HOME/perl5/bin${PATH:+:${PATH}}"
export PATH
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL5LIB
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_LOCAL_LIB_ROOT
PERL_MB_OPT="--install_base \"$HOME/perl5\""
export PERL_MB_OPT
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
export PERL_MM_OPT

# Prefix-agnostic using brew --prefix: ARM (/opt/homebrew) or Intel (/usr/local).
{
  HOMEBREW_PREFIX="$(brew --prefix 2>/dev/null || true)"
  MINIFORGE_BASE="$HOMEBREW_PREFIX/Caskroom/miniforge/base"

  if [ -x "$MINIFORGE_BASE/bin/conda" ]; then
    __conda_setup="$("$MINIFORGE_BASE/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)" || true
    if [ -n "$__conda_setup" ]; then
      eval "$__conda_setup"
    elif [ -f "$MINIFORGE_BASE/etc/profile.d/conda.sh" ]; then
      . "$MINIFORGE_BASE/etc/profile.d/conda.sh"
    else
      export PATH="$MINIFORGE_BASE/bin:$PATH"
    fi
    unset __conda_setup

    # Mamba hook
    export MAMBA_EXE="$MINIFORGE_BASE/condabin/mamba"
    export MAMBA_ROOT_PREFIX="$MINIFORGE_BASE"
    if [ -x "$MAMBA_EXE" ]; then
      __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2>/dev/null)" || true
      [ -n "$__mamba_setup" ] && eval "$__mamba_setup"
      unset __mamba_setup
    fi
  fi
}