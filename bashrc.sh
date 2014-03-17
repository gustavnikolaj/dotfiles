# Load the shell dotfiles:
for file in ~/.config/bash.d/* ; do
    [ -r "$file" ] && source "$file"
done
unset file
