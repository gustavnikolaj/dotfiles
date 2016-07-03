#!/bin/bash
# http://www.thinkwiki.org/wiki/Docking_Solutions
# wait for the dock state to change
sleep 0.5
DOCKED=$(cat /sys/devices/platform/dock.0/docked)
case "$DOCKED" in
    "0")
        #undocked event
        /home/gno/dotfiles/screenlayout/laptop.sh
    "1")
        #docked event
        /home/gno/dotfiles/screenlayout/work.sh
        ;;
esac
exit 0
