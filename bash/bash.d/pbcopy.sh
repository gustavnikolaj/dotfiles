if ! command -v pbcopy > /dev/null 2>&1; then # has pbcopy
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
fi
