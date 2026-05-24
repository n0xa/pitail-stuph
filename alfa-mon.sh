#!/bin/sh
# Loads the 88XXau kernel module and enables monitor mode.
# Module options now baked into modprobe.d during 88XXau installation steps
# Tested with Alfa AWUS036ACS mini AC600 adapter

modprobe 88XXau 
iw dev wlan1 set type monitor
ip link set wlan1 up
iw wlan1 set txpower fixed 3000
