function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}

function parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

function parse_dir_name() {
    if [ "$HOME" == "`pwd`" ]
    then
        echo "~"
    else
        basename "$PWD"
    fi
}

# print a green $ if not root and a red # if root
# useful when doing sudo -s
function ps1_shell_indicator() {
    if [ "`whoami`" == "root" ]
    then
        echo "\[\033[31m\033[1m\]#\[\033[22m\033[39m\]"
    else
        echo "\[\033[32m\033[1m\]$\[\033[22m\033[39m\]"
    fi
}

function ps1_dirname {
    echo "\[\033[1m\033[90m\033[38m\]$(parse_dir_name)\[\033[39m\033[22m\]"
}

function ps1_git_status {
    echo "\$([[ -n \$(git branch 2> /dev/null) ]] && echo ' on '\[\033[1m\033[90m\033[38m\]\$(parse_git_branch))\[\033[39m\033[22m\]"
}

function ps1_node_version {
    local nvmVersion=$(nvm_ls_current 2> /dev/null)
    local firstNvmRc=$(nvm_find_nvmrc)
    local projectVersion=""
    if [ "$firstNvmRc" != "" ] ; then
        projectVersion=$(nvm_ensure_version_prefix $(cat $firstNvmRc))
    fi


    if [ "$nvmVersion" != "" ]
    then
        if [ "$projectVersion" != "" ]
        then
            # The $projectVersion variable might be a partial version (v9) if
            # the nvmrc file only contained a major version, due to the use of
            # nvm_ensure_version_prefix instead of nvm_format_version.
            #   It's done to not complain when a project has a .nvmrc with the
            # content `8` and you are running node version 8.9.4.
            if ! [[ "$nvmVersion" =~ ^"$projectVersion" ]]
            then
                echo "\[\033[1m\033[31m\033[38m\] node $nvmVersion\[\033[39m\033[22m\]"
# Uncomment the following lines to show the node version when it is correct
#            else
#                echo "\[\033[1m\033[90m\033[38m\] $nvmVersion\[\033[39m\033[22m\]"
            fi
# Uncomment the following lines to display node version on non .nvmrc subtrees.
#        else
#            echo "\[\033[1m\033[90m\033[38m\] $nvmVersion\[\033[39m\033[22m\]"
        fi
    fi
}

function ps1_build_bash_prompt {
    PS1=" $(ps1_dirname)$(ps1_git_status)$(ps1_node_version) $(ps1_shell_indicator) "
}

export PS2="→ "
PROMPT_COMMAND="ps1_build_bash_prompt; $PROMPT_COMMAND"

