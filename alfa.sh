#!/bin/sh
# Loads the 8821au kernel module and enables the interface, if you want to
# use it for connectivity rather than sniffing and injection
modprobe 8821au options rtw_drv_log_level=1 rtw_led_ctrl=1 rtw_vht_enable=1 rtw_power_mgnt=1
ip link set wlan1 up
