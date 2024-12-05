for file in "$DOTFILES_DIR/bash/completion.d/"*; do
    [ -f "$file" ] && source "$file"
done
