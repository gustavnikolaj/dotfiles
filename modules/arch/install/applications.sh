#!/bin/bash

# sushi is a filepreviewer for nautilus

yay -S --noconfirm --needed \
    brightnessctl \
    playerctl \
    pamixer \
    wiremix \
    wireplumber \
    wl-clip-persist \
    nautilus \
    sushi \
    ffmpegthumbnailer \
    slurp \
    satty \
    mpv \
    imv \
    evince \
    1password \
    1password-cli \
    brave-bin

yay -S --noconfirm --needed \
    gnome-calculator \
    gnome-keyring \
    libreoffice

# Localsend relies on firewall rules in the firewall file

yay -S --noconfirm --needed \
    localsend-bin

yay -S --noconfirm --needed \
    pinta

yay -S --noconfirm --needed \
    spotify
