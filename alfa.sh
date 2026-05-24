#!/bin/sh
# Loads the 88XXau kernel module and enables the interface, if you want to
# use it for connectivity rather than sniffing and injection
modprobe 88XXau
ip link set wlan1 up
