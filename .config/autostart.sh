#!/usr/bin/env bash

picom --no-fading-openclose &
.config/polybar/launch.sh &
xrandr --output DP-2 --auto --output DP-2 --auto --left-of DP-4 &
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
