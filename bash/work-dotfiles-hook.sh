# In this dotfiles repo I have my personalized set of dotfiles and
# configuration that I need in order to setup my work environment how I like. I
# want to be able to use them at work as well, but I do not want to mix the two
# different sets into the same.
#
# In order to facilitate that I have this script which will be sourced along
# with the bashrc file, and which will look for a file in a predetermined
# location and source that as well if it is present. That allows me to hook the
# work specific dotfiles into my main dotfiles, and maintain a nice separation.

WORKDOTFILES_DIR=~/work-dotfiles
WORKDOTFILES_HOOK=$WORKDOTFILES_DIR/hook.sh

if [ -f $WORKDOTFILES_HOOK ] ; then
    source $WORKDOTFILES_HOOK
fi
