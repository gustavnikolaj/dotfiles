if command -v fzf &> /dev/null
then
    alias pf='p $(ls -1t $PROJECTS_DIR | fzf)'
else
    alias pf='echo pf depends on fzf which is not available. && false'
fi
