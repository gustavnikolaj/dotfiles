# Set EDITOR to nvim if nvim is installed
if command -v nvim &> /dev/null
then
    export EDITOR='nvim'
    alias vi=nvim
fi

