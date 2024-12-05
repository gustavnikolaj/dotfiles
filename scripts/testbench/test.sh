#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

docker run \
    --rm \
    -it \
    -v $(pwd):/home/gno/dotfiles \
    --workdir /home/gno \
    dotfiles-testbench \
    bash
