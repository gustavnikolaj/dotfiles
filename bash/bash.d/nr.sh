# nr: run npm package binaries installed in your current project.
#
# instead of running `./node_modules/.bin/eslint` you run `nr eslint`
# arguments are passed on automatically.

function nr() {
    if [ -z $1 ]; then
        echo 'You need to pass an executable name.'
        return 1 # exit
    else
        $(npm bin)/$@
    fi
}

function _nr_complete_() {
    local word=${COMP_WORDS[COMP_CWORD]}
    local nrbins=$(find $(npm bin) -maxdepth 1 -mindepth 1 -type l -exec basename {} \; | tr '\n' ' ')
    COMPREPLY=($(compgen -W "$nrbins" -- "${word}"))
}
complete -F _nr_complete_ nr
