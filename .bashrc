# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#DOTFILES_DIR=$(cd $(dirname $(readlink -f ${BASH_SOURCE[0]}))/.. && pwd)
DOTFILES_DIR=~/dotfiles

# Load bash options
source $DOTFILES_DIR/bash/bash-options.sh

# Add custom bin folders to $PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$DOTFILES_DIR/bin:$PATH"

# Load the prompt
source $DOTFILES_DIR/modules/prompt/prompt.sh

# Load and configure p.sh
export PROJECTS_DIR=~/Projects
source $DOTFILES_DIR/modules/p/p.sh

# Load and configure scratch
export SCRATCH_DIR=~/Scratch
source $DOTFILES_DIR/modules/scratch/scratch.sh

# Setup go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# title script: set the title of the terminal
function title {
    printf "\033]0;%s\007" "$1"
}

# Polyfill pbpaste / pbcopy from macos using xclip
if ! command -v pbcopy > /dev/null 2>&1; then # has pbcopy
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
fi

source $DOTFILES_DIR/bash/deno.sh

# Load bash autocompletion
[ -f /etc/bash_completion ] && source /etc/bash_completion
# macos version - depends on brew installation. $ brew install bash-completion
[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion

# Load dotfiles completion
source $DOTFILES_DIR/bash/npm-completion-fix.sh
source $DOTFILES_DIR/bash/bash-completion.sh

# Load any local customizations from /.bash_local if it exists
[ -f ~/.bash_local ] && source ~/.bash_local

# Load other bash files
source $DOTFILES_DIR/bash/kubernetes.sh
source $DOTFILES_DIR/bash/nvim.sh
source $DOTFILES_DIR/bash/pf.sh
source $DOTFILES_DIR/nvm/nvm.sh
source $DOTFILES_DIR/bash/work-dotfiles-hook.sh
