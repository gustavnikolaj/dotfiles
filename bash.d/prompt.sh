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

bold=`echo -e "\033[1m"`
normal=`echo -e "\033[0m"`

export PS1=" \[$bold\]\$(parse_dir_name)\$([[ -n \$(git branch 2> /dev/null) ]] && echo '\[$normal\] on \[$bold\]')\$(parse_git_branch) \$\[$normal\] "
export PS2="→ "
