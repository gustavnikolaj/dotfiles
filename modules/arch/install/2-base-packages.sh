#!/bin/bash

# inetutils is for common cli tools such as ping, hostname, traceroute,
# ifconfig etc.

# impala is a wifi management terminal ui

# wl-clipboard is a cli clipboard utility providing wl-copy and wl-paste

# plocate https://plocate.sesse.net/

yay -S --noconfirm --needed \
    wget \
    curl \
    unzip \
    inetutils \
    impala \
    fzf \
    jq \
    wl-clipboard \
    bash-completion \
    man \
    less \
    plocate \
    kitty
