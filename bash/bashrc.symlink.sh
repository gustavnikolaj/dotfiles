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

sourceFiles $(find $DOTFILES_DIR/bash/bash.d -type f)
sourceFiles $(find $DOTFILES_DIR -type f -name "*.bashrc.sh")

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
