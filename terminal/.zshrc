# Path to dotfiles.
export DOTFILES="$HOME/.dotfiles"

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set default text editor
export EDITOR='code -w'

# Ensure 256 color support
export TERM=xterm-256color

export JAVA_HOME="/usr/local/opt/openjdk/bin/java"

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

# Use case-sensitive completion.
# CASE_SENSITIVE="true"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

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

eval "$(pyenv init -)"

source "$ZSH/oh-my-zsh.sh"

PATH="/Users/tiger/perl5/bin${PATH:+:${PATH}}"
export PATH
PERL5LIB="/Users/tiger/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL5LIB
PERL_LOCAL_LIB_ROOT="/Users/tiger/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_LOCAL_LIB_ROOT
PERL_MB_OPT="--install_base \"/Users/tiger/perl5\""
export PERL_MB_OPT
PERL_MM_OPT="INSTALL_BASE=/Users/tiger/perl5"
export PERL_MM_OPT

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
