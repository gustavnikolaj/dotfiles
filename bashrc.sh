# Load the shell dotfiles:
for file in ~/.config/bash.d/* ; do
    [ -r "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null
done
#  possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

export EDITOR=vim

# add local file if present
[ -f ~/.bash_local ] && source ~/.bash_local

# add z library if present
[ -f ~/.local/lib/z/z.sh ] && source ~/.local/lib/z/z.sh
