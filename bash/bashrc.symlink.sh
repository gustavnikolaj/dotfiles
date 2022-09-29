# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

function sourceFiles() {
  for file in $@ ; do
    source $file
  done
}

#DOTFILES_DIR=$(cd $(dirname $(readlink -f ${BASH_SOURCE[0]}))/.. && pwd)
DOTFILES_DIR=~/dotfiles

# Load bash options
source $DOTFILES_DIR/bash/bash-options.sh

# Add custom bin folders to $PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# Load the prompt
source $DOTFILES_DIR/modules/prompt/prompt.sh

# Load and configure p.sh
export PROJECTS_DIR=~/Projects
source $DOTFILES_DIR/modules/p/p.sh

# Load and configure p2.sh
export P2_DIR=~/Projects
source $DOTFILES_DIR/modules/p2/p2.sh

# Load and configure scratch
export SCRATCH_DIR=~/Scratch
source $DOTFILES_DIR/modules/scratch/scratch.sh

# Load and configure ocp.sh
source $DOTFILES_DIR/modules/ocp/ocp.sh

# Setup go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# title script: set the title of the terminal
function title {
    printf "\033]0;%s\007" "$1"
}

# If running kitty set terminal to use UTF-8 (does not happen by default)
if [ ! -z ${KITTY_WINDOW_ID+x} ] ; then
  if [ "${OSTYPE//[0-9.]/}" == "darwin" ] ; then 
    export LC_CTYPE=UTF-8
  fi
fi

if [ -e $HOME/.rbenv ] ; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Polyfill pbpaste / pbcopy from macos using xclip
if ! command -v pbcopy > /dev/null 2>&1; then # has pbcopy
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
fi

# Load bash autocompletion
[ -f /etc/bash_completion ] && source /etc/bash_completion
# macos version - depends on brew installation. $ brew install bash-completion
[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion


# Load the *.bashrc.sh files from the topic folders in the DOTFILES_DIR
sourceFiles $(find $DOTFILES_DIR -type f -name "*.bashrc.sh")

# Load any local customizations from /.bash_local if it exists
[ -f ~/.bash_local ] && source ~/.bash_local
