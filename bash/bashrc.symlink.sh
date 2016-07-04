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

DOTFILES_DIR=$(cd $(dirname $(readlink -f ${BASH_SOURCE[0]}))/.. && pwd)

sourceFiles $(find $DOTFILES_DIR/bash/bash.d -type f)
sourceFiles $(find $DOTFILES_DIR -type f -name "*.bashrc.sh")
