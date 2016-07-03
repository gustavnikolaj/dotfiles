# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export DOTFILES="~/dotfiles"
for file in ~/.config/bash.d/* ; do
    [ -r "$file" ] && source "$file"
done
unset file
[ -f ~/.bash_local ] && source ~/.bash_local
