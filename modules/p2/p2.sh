#!/usr/bin/env bash

P2_DIR=~/git

##############################################################################
# Helper methods for function gg
# 

function p2_cd {
    # TODO: Implement PHOOK_CD here.
    echo CD $1
    cd $1
}

function p2_find_git_repos {
    # This could be a performance bottleneck. We should benchmark it before
    # making it more complex though.
    # An easy fix for performance would be to cap the depth of dirs it will
    # descent into while searching for .git dirs, by using the -maxdepth N
    # option.
    # Using maxdepth has the drawback that it only supports a fixed level of
    # nesting folders.
    # maxdepth levels:
    #  - 1 = github.com
    #  - 2 = gustavnikolaj
    #  - 3 = dotfiles.
    # Using 4 to support teams in gitlab.
    # ... oh and +1 because we're actually searching for .git folders within
    # the level we mention above.
    find $P2_DIR -name .git -type d -prune -maxdepth 5 -exec dirname {} \; | sed "s#${P2_DIR}/##"
}

function p2_match {
    # Find all folders in P2_DIR
    local projects="$(p2_find_git_repos)"

    # For each argument, grep for folders that match that argument in the remaining folders
    for arg in $@
    do
        local projects="`echo "$projects" | grep "$arg"`"
    done

    # Sort the folders after lenght of the name.
    echo "$projects" | awk '{print length, $0}' | sort -n | cut -d " " -f2-
}


# gg command

function gg {    
    if [ -z $1 ]; then
        # If none arguments or the first argument was empty, go to the projects dir
        p2_cd $P2_DIR
    else
        local projects=`p2_match $@`

        echo "PROMPT:" $@
        echo "RESULTS:"
        echo "------------------------------------"
        echo "$projects"
        echo "------------------------------------"

        # Go to the first folder in the filtered list of folders
        local destination=`echo "$projects" | head -n 1`
        if [ -z $destination ]; then
            p2_cd $P2_DIR
        else
            p2_cd $P2_DIR/$destination
        fi
    fi

}


##############################################################################
# Helper methods for gg-move command
#

function move_gg_is_git_repo {
    local dotgirdir="$1/.git"
    # echo dotgirdir=$dotgirdir
    [[ -d $dotgirdir ]]    
}

function move_gg_get_origin_remote {
    echo $(cd $1 && git config --get remote.origin.url)
}


function move_gg_verify_giturl {
    local origin=$1

    if [[ "${origin:0:4}" != "git@" ]] ; then
        echo "only supports git ssh urls (url didn't start with git@)"
        return 1
    fi

    if [[ "${origin:(-4)}" != '.git' ]] ; then
        echo "only supports git ssh urls (url didn't end with .git)"
        return 1
    fi

    local originWoGitAt=${origin:4:-4}
    echo originWoGitAt=$originWoGitAt
    echo beforeColon=${originWoGitAt%%:*}
    echo afterColon=${originWoGitAt##*:}

    if [[ -z "${originWoGitAt%%:*}" ]] || [[ -z "${originWoGitAt##*:}" ]] ; then
        echo "malformed git ssh url (no colon, or colon at the start or end)"
        return 1
    fi

    return 0
}


function move_gg_giturl_to_relpath {
    local trimmedOrigin=${origin:4:-4}
    echo ${trimmedOrigin%%:*}/${trimmedOrigin##*:}
}

function p2_confirm_yn {
    read -p "Are you sure? [y/n] "
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo "Aborting..."
        return 1
    fi

    return 0
}

# gg-move command

function gg-move {
    local repopath=$(realpath $@)
    echo CONTEXT: $repopath

    if ! move_gg_is_git_repo $repopath ; then
        echo "$repopath is not a git repo"
        return 1
    else
        echo $repopath "is a git repo"
        local origin=`move_gg_get_origin_remote $repopath`

        echo origin=$origin

        if ! move_gg_verify_giturl $origin ; then
            echo "Invalid URL"
            return 1
        else
            local dest=`move_gg_giturl_to_relpath $origin`
            local destAbs=$P2_DIR/$dest
            local destParent=`dirname $destAbs`
            echo move_gg_giturl_to_relpath=$dest
            echo destAbs=$destAbs
            echo destParent=$destParent


            echo ""
            echo ""
            echo ""
            echo "About to move"
            echo ""
            echo "  $repopath"
            echo ""
            echo "to"
            echo ""
            echo "  $destAbs"
            echo ""

            if [[ "$repopath" == "$destAbs" ]] ; then
                echo "Aborting ... destination unchanged."
                return 1
            fi

            if p2_confirm_yn ; then
                mkdir -p $destParent
                mv $repopath $destAbs
            fi
        fi
    fi
}