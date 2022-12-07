#!/bin/bash


sudo sed -i 's|/usr/libexec/bluetooth/bluetoothd|/usr/libexec/bluetooth/bluetoothd --noplugin=sap|g' /lib/systemd/system/bluetooth.service
