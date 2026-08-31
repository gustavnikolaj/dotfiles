# Complete the key light scripts off their own --list output, so adding a
# preset to ~/dotfiles/bin/lights updates completion with no second edit.
_lights_completion() {
    # Both commands take exactly one argument.
    [ "$COMP_CWORD" -eq 1 ] || return

    COMPREPLY=( $(compgen -W "$("${COMP_WORDS[0]}" --list 2>/dev/null)" -- "${COMP_WORDS[1]}") )
}

command -v lights &> /dev/null && complete -F _lights_completion lights
command -v set-scene &> /dev/null && complete -F _lights_completion set-scene
