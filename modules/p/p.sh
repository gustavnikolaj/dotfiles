export PROJECTS_DIR="${PROJECTS_DIR:=~/Projects}"
export PHOOK_CD=p_set_title:$PHOOK_CD

function p_set_title() {
    printf "\033]0;%s\007" `basename $1` # Set the terminal title
}

function p_cd() {
    cd $1
    if [ "$PHOOK_CD" != "" ] ; then
        local hooks=$(echo $PHOOK_CD | tr ":" "\n")
        for hook in $hooks; do eval $hook $1 ; done
    fi
}

function p() {
    if [ -z $1 ]; then
        # If none arguments or the first argument was empty, go to the projects dir
        p_cd $PROJECTS_DIR
    else
        # Find all folders in PROJECTS_DIR
        local projects="$(ls -p ${PROJECTS_DIR} | grep /$ | sed -e 's/\/$//;')"

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
            p_cd $PROJECTS_DIR
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

function pclone() {
    local GIT_REF=${1##*:} 
    local GIT_HOST=${1%:$GIT_REF}

    if [ "git@github.com" != "${GIT_HOST}" ] ; then
        echo Unsupported git url.
        echo pclone only supports git@github.com
        return 1
    fi

    local GIT_REPO_ORG_NAME=${GIT_REF%.git}
    local GIT_REPO_NAME=${GIT_REPO_ORG_NAME##*/}
    local CLONE_DEST=${PROJECTS_DIR}/${GIT_REPO_NAME}


    if [ -e $CLONE_DEST ] ; then
        echo ${CLONE_DEST} already exists.
        return 1
    fi

    git clone $1 $CLONE_DEST
    p_cd $CLONE_DEST
}
