export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

load-nvmrc() {
    if [ -f .nvmrc ] ; then
        nvm use || nvm install
    elif [[ $(nvm version) != $(nvm version default) ]] ; then
        echo "nvm: Reverting to default node version."
        nvm use default
    fi
}

load-nvmrc # attempt to load appropriate nvm on load

export PHOOK_CD=$PHOOK_CD:load-nvmrc # set up hook for p
