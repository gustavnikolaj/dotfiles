export SCRATCH_DIR="${SCRATCH_DIR:=~/Scratch}"

function scratch() {
    if [ -z $1 ]; then
        # If none arguments or the first argument was empty, go to the scratch dir
        cd $SCRATCH_DIR
    else
        # Find all folders in SCRATCH_DIR
        local scratchs="`find $SCRATCH_DIR -mindepth 1 -maxdepth 1 -type d -exec basename {} \;`"

        # For each argument, grep for folders that match that argument in the remaining folders
        for arg in $@
        do
            local projects="`echo "$scratchs" | grep "$arg"`"
        done

        local scratchs="`echo "$scratchs" | awk '{print length, $0}' | sort -n | cut -d " " -f2-`"

        local destination=`echo "$projects" | head -n 1`

        if [ -z $destination ]; then
            mkdir -p $SCRATCH_DIR/$1
            cd $SCRATCH_DIR/$1
        else
            cd $SCRATCH_DIR/$destination
        fi
    fi
}

function _scratch_complete() {
    local word=${COMP_WORDS[COMP_CWORD]}
    local scratchdirs=$(find $SCRATCH_DIR -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | tr '\n' ' ')
    COMPREPLY=($(compgen -W "$scratchdirs" -- "${word}"))
}
complete -F _scratch_complete scratch
