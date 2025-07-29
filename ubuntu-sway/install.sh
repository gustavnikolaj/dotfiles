#!/bin/bash

# install base sway setup
sudo apt install sway xwayland sway-backgrounds waybar wofi wl-clipboard

# if nvidia drivers are in use
if command -v nvidia-smi ; then
	# Add the --unsupported-gpu flag to /usr/share/wayland-sessions/sway.desktop 
	# Disable the hardware cursor when using proprietary nvidia drivers
	# vim .config/environment.d/nvidia-cursor.conf
	# WLR_NO_HARDWARE_CURSORS=1
fi


