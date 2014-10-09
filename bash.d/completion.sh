#  possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

# nvm tab completion
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
