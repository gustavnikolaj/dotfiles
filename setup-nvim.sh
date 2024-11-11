#!/usr/bin/env bash

set -euo pipefail

# Directory variables
NVIM_CONFIG_DIR="$HOME/.config/nvim"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if $NVIM_CONFIG_DIR is already a symlink to $SCRIPT_DIR/nvim
if [ -L "$NVIM_CONFIG_DIR" ] && [ "$(readlink "$NVIM_CONFIG_DIR")" == "$SCRIPT_DIR/nvim" ]; then
    echo "Symlink to $SCRIPT_DIR/nvim already exists at $NVIM_CONFIG_DIR."
    exit 0
fi

# If $NVIM_CONFIG_DIR exists as anything other than the intended symlink, exit with an error
if [ -e "$NVIM_CONFIG_DIR" ]; then
    echo "$NVIM_CONFIG_DIR already exists and is not the intended symlink."
    exit 1
fi

# Create the symlink if $NVIM_CONFIG_DIR does not exist
ln -s "$SCRIPT_DIR/nvim" "$NVIM_CONFIG_DIR"
echo "Symlink created from $SCRIPT_DIR/nvim to $NVIM_CONFIG_DIR." 
