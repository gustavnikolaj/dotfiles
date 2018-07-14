load-nvmrc() {
    if [ -f .nvmrc ] ; then
        nvm use || nvm install
    elif [[ $(nvm version) != $(nvm version default) ]] ; then
        echo "nvm: Reverting to default node version."
        nvm use default
    fi
}

export PHOOK_CD=$PHOOK_CD:load-nvmrc
