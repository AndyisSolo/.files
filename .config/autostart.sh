#!/usr/bin/env bash

picom --no-fading-openclose &
.config/polybar/launch.sh &
xrandr --output DP-2 --primary --mode 1920x1080 --rate 240 --output DP-4 --rate 240 --right-of DP-2
xsetroot -cursor_name left_ptr &
autorandr --change --force &
flameshot &
nm-applet &
clipit &
blueman-applet &
setbg &
skypeforlinux &
signal-desktop &
telegram-desktop &
cryptomator &
insync start
xsetroot -cursor_name left_ptr &
