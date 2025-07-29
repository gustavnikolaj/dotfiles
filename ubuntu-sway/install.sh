#!/bin/bash

# install base deps
sudo apt install curl

# install base sway setup
sudo apt install sway xwayland sway-backgrounds waybar wofi wl-clipboard

# if nvidia drivers are in use
if ! command -v nvidia-smi ; then
	# Add the --unsupported-gpu flag to /usr/share/wayland-sessions/sway.desktop 
	# Disable the hardware cursor when using proprietary nvidia drivers
	# vim .config/environment.d/nvidia-cursor.conf
	# WLR_NO_HARDWARE_CURSORS=1
	echo "need to do nvidia setup"
fi

# install brave
if ! command -v brave-browser ; then
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
    sudo apt update
    sudo apt install brave-browser
fi
