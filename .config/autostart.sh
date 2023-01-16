#!/usr/bin/env bash

picom --no-fading-openclose &
.config/polybar/launch.sh &
# xrandr --output DP-2 --primary --mode 1920x1080 --rate 240 --output DP-4 --rate 240 --right-of DP-2
nohup cryptomator & 
flameshot &
nm-applet &
blueman-applet &
setbg &
insync start
telegram-desktop &

