#!/bin/sh
killall -SIGSTOP i3

sleep 1

xrandr -d :0.0 --output eDP1 --auto --primary
# enable external monitors
xrandr -d :0.0 --output DP2-1 --mode 1920x1200 --right-of eDP1 --primary
xrandr -d :0.0 --output DP2-2 --mode 1920x1200 --right-of DP2-1
# disable internal screen
xrandr -d :0.0 --output eDP1 --off

killall -SIGCONT i3
