BIN_DIRNAME=$(cd $(dirname $(readlink -f ${BASH_SOURCE[0]})) && pwd)
export PATH="$BIN_DIRNAME:$PATH"
