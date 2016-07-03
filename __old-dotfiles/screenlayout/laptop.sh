#!/bin/sh
killall -SIGSTOP i3

sleep 1

xrandr -d :0.0 --output eDP1 --auto --primary
xrandr -d :0.0 --output DP2-2 --off
xrandr -d :0.0 --output DP2-1 --off

killall -SIGCONT i3
