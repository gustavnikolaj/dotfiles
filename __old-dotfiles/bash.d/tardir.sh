function tardir () {
    NAME=`sed 's/\/$//' <<< $1`
    tar cvf "$2${NAME}.tar" "${NAME}";
}
