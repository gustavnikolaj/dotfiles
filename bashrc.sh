# Load the shell dotfiles:
export DOTFILES="/home/gustav/dotfiles"
for file in ~/.config/bash.d/* ; do
    [ -r "$file" ] && source "$file"
done
unset file
[ -f ~/.bash_local ] && source ~/.bash_local
