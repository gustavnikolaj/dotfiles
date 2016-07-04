function main {
  local DIRNAME=$(cd $(dirname $(readlink -f ${BASH_SOURCE[0]})) && pwd)
  lesskey -o ~/.less -- $DIRNAME/lesskey
}
main
