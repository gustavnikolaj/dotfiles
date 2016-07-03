function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
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
function shell_indicator() {
    if [ "`whoami`" == "root" ]
    then
        echo "\[\033[31m\033[1m\]#\[\033[22m\033[39m\]"
    else
        echo "\[\033[32m\033[1m\]$\[\033[22m\033[39m\]"
    fi
}

bold=`echo -e "\033[1m"`
normal=`echo -e "\033[0m"`
green=`echo -e "\033[32m"`

export PS1=" \[$bold\]\$(parse_dir_name)\$([[ -n \$(git branch 2> /dev/null) ]] && echo '\[$normal\] on \[$bold\]')\$(parse_git_branch) \[$green\]\$\[$normal\] "
export PS2="→ "

export PS1=" \[\033[1m\033[90m\033[38m\]\$(parse_dir_name)\[\033[39m\033[22m\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo ' on '\[\033[1m\033[90m\033[38m\]\$(parse_git_branch))\[\033[39m\033[22m\] $(shell_indicator) "
