# Set EDITOR to nvim if nvim is installed
if command -v nvim &> /dev/null
then
    export EDITOR='nvim'
fi

# ... unless we are running in VS Codes internal terminal
# See: ../vscode-as-git-editor.md
if ! [[ $GUSTAVNIKOLAJ_VSCODE == "" ]]; then
  export EDITOR="code --wait" ;
fi
