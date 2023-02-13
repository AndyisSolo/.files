#!/bin/bash

sed -i -e 's/%amdin	ALL=(ALL:ALL) ALL/# %admin	ALL=(ALL:ALL) ALL/g' /etc/sudoers
echo '%admin ALL=(ALL:ALL) NOPASSWD: /usr/sbin/shutdown,/usr/sbin/reboot,/usr/bin/mount,/usr/bin/umount,/usr/bin/apt update -y,/usr/bin/apt upgrade -y' >> /etc/sudoers
echo 'Defaults !tty_tickets' >> /etc/sudoers
