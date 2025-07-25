#!/bin/bash

# Ensure application directory exists for update-desktop-database
mkdir -p ~/.local/share/applications

# Copy and sync icon files
mkdir -p ~/.local/share/icons/hicolor/48x48/apps/
cp ./applications/icons/*.png ~/.local/share/icons/hicolor/48x48/apps/

update-desktop-database ~/.local/share/applications
