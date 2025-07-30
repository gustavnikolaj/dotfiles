#!/bin/bash

set -e

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

if ! command -v 1password ; then
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
    sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
    curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
    sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
    sudo apt update && sudo apt install 1password
fi

if ! command -v uwsm ; then
  echo "Missing uwsm binary"
  echo "Go build it! https://github.com/Vladimir-csp/uwsm?tab=readme-ov-file#1-building-and-installing" 
  false
fi

# fonts
sudo apt install -y fonts-font-awesome fonts-noto fonts-noto-color-emoji fonts-noto-cjk
mkdir -p ~/.local/share/fonts

if ! fc-list | grep -qi "CaskaydiaMono Nerd Font"; then
  cd /tmp
  wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
  unzip CascadiaMono.zip -d CascadiaFont
  cp CascadiaFont/CaskaydiaMonoNerdFont-Regular.ttf ~/.local/share/fonts
  cp CascadiaFont/CaskaydiaMonoNerdFont-Bold.ttf ~/.local/share/fonts
  cp CascadiaFont/CaskaydiaMonoNerdFont-Italic.ttf ~/.local/share/fonts
  cp CascadiaFont/CaskaydiaMonoNerdFont-BoldItalic.ttf ~/.local/share/fonts
  cp CascadiaFont/CaskaydiaMonoNerdFontPropo-Regular.ttf ~/.local/share/fonts
  cp CascadiaFont/CaskaydiaMonoNerdFontPropo-Bold.ttf ~/.local/share/fonts
  cp CascadiaFont/CaskaydiaMonoNerdFontPropo-Italic.ttf ~/.local/share/fonts
  cp CascadiaFont/CaskaydiaMonoNerdFontPropo-BoldItalic.ttf ~/.local/share/fonts
  rm -rf CascadiaMono.zip CascadiaFont
  fc-cache
  cd -
fi

if ! fc-list | grep -qi "iA Writer Mono S"; then
  cd /tmp
  wget -O iafonts.zip https://github.com/iaolo/iA-Fonts/archive/refs/heads/master.zip
  unzip iafonts.zip -d iaFonts
  cp iaFonts/iA-Fonts-master/iA\ Writer\ Mono/Static/iAWriterMonoS-*.ttf ~/.local/share/fonts
  rm -rf iafonts.zip iaFonts
  fc-cache
  cd -
fi        

# nvim

if ! command -v nvim ; then
    rm -rf ~/.local/opt/nvim
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    mkdir -p ~/.local/{opt,bin}
    tar -xzf nvim-linux-x86_64.tar.gz -C ~/.local/opt
    mv ~/.local/opt/nvim-linux-x86_64 ~/.local/opt/nvim
    rm nvim-linux-x86_64.tar.gz
    ln -sf ~/.local/opt/nvim/bin/nvim ~/.local/bin/nvim
fi
