#!/bin/sh
killall -SIGSTOP i3

xrandr --output eDP1 --auto --primary
xrandr --output DP2-2 --off
xrandr --output DP2-1 --off

killall -SIGCONT i3
