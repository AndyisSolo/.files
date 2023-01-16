#!/bin/bash

touchpad_rule="/etc/udev/rules.d/99-touchpad.rules"

echo 'ACTION=="add", SUBSYSTEM=="input", ATTRS{name}=="*Mouse*", ATTR{[14]}="0"' | sudo tee $touchpad_rule
echo 'ACTION=="remove", SUBSYSTEM=="input", ATTRS{name}=="*Mouse*", ATTR{[14]}="1"' | sudo tee -a $touchpad_rule
sudo udevadm control --reload-rules

