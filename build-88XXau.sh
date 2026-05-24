#!/bin/sh
# I usually step through these manually rather than scripting it but this is
# my workflow:
#
# Check USB device, kernel, existing drivers:
lsusb | grep -i -E 'realtek|alfa|wireless|wifi|0bda'
uname -r
ls /lib/modules/$(uname -r)/kernel/drivers/net/wireless/
dmesg | grep -i -E '8821|rtl|realtek|usb.*wifi'
# Check for existing packages and headers:
dpkg -l | grep linux-headers
apt-cache search 8821au
apt list --installed 2>/dev/null | grep -i dkms
# Install build dependencies:
sudo apt install -y build-essential bc dkms git
# Clone the aircrack-ng driver source:
cd /usr/src && sudo git clone https://github.com/aircrack-ng/rtl8812au.git rtl8812au-5.6.4.2
# Rename source dir to match DKMS naming convention and build:
sudo mv /usr/src/rtl8812au-5.6.4.2 /usr/src/realtek-rtl88xxau-5.6.4.2~20230501
sudo dkms install realtek-rtl88xxau/5.6.4.2~20230501
# Blacklist from autoloading:
echo 'blacklist 88XXau' | sudo tee /etc/modprobe.d/blacklist-8821au.conf
# Set default module options:
echo 'options 88XXau rtw_led_ctrl=1 rtw_vht_enable=1 rtw_power_mgnt=1' | sudo tee /etc/modprobe.d/8821au-options.conf
# Rebuild module dependency list:
sudo depmod -a

