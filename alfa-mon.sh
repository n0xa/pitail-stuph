#!/bin/sh
# Loads the 8821au kernel module and enables monitor mode. 
# Tested with Alfa AWUS036ACS mini AC600 adapter

modprobe 8821au options rtw_drv_log_level=1 rtw_led_ctrl=1 rtw_vht_enable=1 rtw_power_mgnt=1
iw dev wlan1 set type monitor
ip link set wlan1 up
iw wlan1 set txpower fixed 3000
