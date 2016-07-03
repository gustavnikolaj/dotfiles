function title {
    printf "\033]0;%s\007" "$1"
}

function tardir {
    NAME=`sed 's/\/$//' <<< $1`
    tar cvf "$2${NAME}.tar" "${NAME}";
}
