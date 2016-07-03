export PROJECTS_DIR=~/Projects
export PHOOK_CD=p_set_title:$PHOOK_CD

function p_set_title() {
    printf "\033]0;%s\007" `basename $1` # Set the terminal title
}

function p_cd() {
    cd $1
    if [ "$PHOOK_CD" != "" ] ; then
        local mails=$(echo $PHOOK_CD | tr ":" "\n")
        for hook in $mails; do eval $hook $1 ; done
    fi
}

function p() {
    if [ -z $1 ]; then
        # If none arguments or the first argument was empty, go to the projects dir
        cd $PROJECTS_DIR
    else
        # Find all folders in PROJECTS_DIR
        local projects="`find $PROJECTS_DIR -mindepth 1 -maxdepth 1 -type d -exec basename {} \;`"

        # For each argument, grep for folders that match that argument in the remaining folders
        for arg in $@
        do
            local projects="`echo "$projects" | grep "$arg"`"
        done

        # Sort the folders after lenght of the name.
        local projects="`echo "$projects" | awk '{print length, $0}' | sort -n | cut -d " " -f2-`"

        # Go to the first folder in the filtered list of folders
        local destination=`echo "$projects" | head -n 1`
        if [ -z $destination ]; then
            # If we dont have a match use z to try to make a guess of what you meant
            # and if the z command is not defined, just go to the projects dir.
            if [ -z "`type -t z`" ]; then
                p_cd $PROJECTS_DIR
            else
                local z_guess=$(z -e $@)
                if [ -z $z_guess ] ; then
                    echo "No match for: $@"
                else
                    echo "Jumping to z-match: $z_guess"
                    p_cd $z_guess
                fi
            fi
        else
            p_cd $PROJECTS_DIR/$destination
        fi
    fi
}

function _projects_complete_() {
    local word=${COMP_WORDS[COMP_CWORD]}
    local projectdirs=$(find $PROJECTS_DIR -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | tr '\n' ' ')
    COMPREPLY=($(compgen -W "$projectdirs" -- "${word}"))
}
complete -F _projects_complete_ p

