export PROJECTS_DIR=~/Projects

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
                cd $PROJECTS_DIR
            else
                z $@
            fi
        else
            printf "\033]0;%s\007" "$destination" # Set the terminal title
            cd $PROJECTS_DIR/$destination
        fi
    fi
}

function _projects_complete_() {
    local word=${COMP_WORDS[COMP_CWORD]}
    local projectdirs=$(find $PROJECTS_DIR -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | tr '\n' ' ')
    COMPREPLY=($(compgen -W "$projectdirs" -- "${word}"))
}
complete -F _projects_complete_ p

