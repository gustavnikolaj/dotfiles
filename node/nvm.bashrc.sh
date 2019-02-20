if [ -z ${NVM_DIR} ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    [[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
fi

source $DOTFILES_DIR/modules/p-load-nvmrc/p-load-nvmrc.sh

load-nvmrc # attempt to load appropriate nvm on load
