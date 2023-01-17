#!/bin/sh

filepath="/usr/local/bin/early-bg"

# Add line before "#fi"
sed -i '/#fi/i (syndaemon -i 0.5 -K -R)&' $filepath

