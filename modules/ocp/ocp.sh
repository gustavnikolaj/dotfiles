export OCP_DIR="${OCP_DIR:=`realpath ~/OCP`}"
export OCPHOOK_CD=ocp_set_title:$OCPHOOK_CD

function ocp_set_title() {
    printf "\033]0;%s\007" `basename "$1"` # Set the terminal title
}

function ocp_cd() {
    cd $1
    if [ "$OCPHOOK_CD" != "" ] ; then
        local hooks=$(echo $OCPHOOK_CD | tr ":" "\n")
        for hook in $hooks; do eval $hook "$1" ; done
    fi
}

function ocp() {
    if [ -z $1 ]; then
        # If none arguments or the first argument was empty, go to the projects dir
        ocp_cd $OCP_DIR
    else
        # Find all folders in OCP_DIR
        local projects="`find $OCP_DIR -mindepth 1 -maxdepth 1 -type d -exec basename {} \;`"

        # For each argument, grep for folders that match that argument in the remaining folders
        for arg in $@
        do
            local projects="`echo "$projects" | grep "$arg"`"
        done

        # Sort the folders after lenght of the name.
        local projects="`echo "$projects" | awk '{print length, $0}' | sort -n | cut -d " " -f2-`"

        # Go to the first folder in the filtered list of folders
        local destination=`echo "$projects" | head -n 1`
        if [ -z "$destination" ]; then
            cd $OCP_DIR
        else
            cd "$OCP_DIR/$destination"
        fi
    fi
}

alias ocpf='ocp $(ls -l1t $OCP_DIR | fzf)'

