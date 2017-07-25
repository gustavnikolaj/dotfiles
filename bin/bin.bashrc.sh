#BIN_DIRNAME=$(cd $(dirname $(readlink -f ${BASH_SOURCE[0]})) && pwd)
BIN_DIRNAME=~/dotfiles/bin
export PATH="$BIN_DIRNAME:$PATH"
